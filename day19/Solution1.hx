package;

using Lambda;

enum abstract Material(Int) {
	var ORE = 0;
	var CLAY = 1;
	var OBSIDIAN = 2;
	var GEODE = 3;
}

class Blueprint {
	public var robotCosts:Map<Material, Map<Material, Int>>;

	private function convertListToMap(list:Array<Int>):Map<Material, Int> {
		return [ORE => list[0], CLAY => list[1], OBSIDIAN => list[2],];
	}

	public function new(oreCost:Array<Int>, clayCost:Array<Int>, obsidianCost:Array<Int>, geodeCost:Array<Int>) {
		this.robotCosts = [
			ORE => convertListToMap(oreCost),
			CLAY => convertListToMap(clayCost),
			OBSIDIAN => convertListToMap(obsidianCost),
			GEODE => convertListToMap(geodeCost),
		];
	}

	public function maxCosts():Map<Material, Int> {
		var maxCosts = [ORE => 0, CLAY => 0, OBSIDIAN => 0,];
		for (_type => robotCost in robotCosts) {
			for (mat => cost in robotCost) {
				maxCosts[mat] = Math.floor(Math.max(cost, maxCosts[mat]));
			}
		}
		return maxCosts;
	}
}

class State {
	public var robots:Map<Material, Int>;
	public var materials:Map<Material, Int>;
	public var time:Int;

	public function new(robots, materials, time) {
		this.robots = robots;
		this.materials = materials;
		this.time = time;
	}

	public function advanceTime(jump:Int):State {
		var newMaterials = this.materials.copy();
		newMaterials[ORE] = this.materials[ORE] + jump * this.robots[ORE];
		newMaterials[CLAY] = this.materials[CLAY] + jump * this.robots[CLAY];
		newMaterials[OBSIDIAN] = this.materials[OBSIDIAN] + jump * this.robots[OBSIDIAN];
		newMaterials[GEODE] = this.materials[GEODE] + jump * this.robots[GEODE];
		return new State(this.robots.copy(), newMaterials, this.time + jump);
	}

	public function buildRobot(blueprint:Blueprint, type:Material):State {
		var cost = blueprint.robotCosts[type];
		var timeNeeded = 0;
		for (mat => amt in cost) {
			var missing:Int = Math.floor(Math.max(amt - this.materials[mat], 0));
			if (missing > 0) {
				var robots = this.robots[mat];
				if (robots == 0) {
					return null;
				}
				timeNeeded = Math.floor(Math.max(timeNeeded, Math.ceil(missing / robots)));
			}
		}
		var newState = advanceTime(timeNeeded + 1);
		for (mat => amt in cost) {
			newState.materials[mat] -= amt;
		}
		newState.robots[type] += 1;
		return newState;
	}

	public function toString():String {
		var data = [
			this.robots[ORE],
			this.robots[CLAY],
			this.robots[OBSIDIAN],
			this.robots[GEODE],
			this.materials[ORE],
			this.materials[CLAY],
			this.materials[OBSIDIAN],
			this.materials[GEODE],
			time,
		];
		return data.join(",");
	}
}

class Solution1 {
	static var MAX_TIME = 24;

	static public function parseBlueprint(input:String):Blueprint {
		var regex = ~/Blueprint \d+: Each ore robot costs (\d+) ore. Each clay robot costs (\d+) ore. Each obsidian robot costs (\d+) ore and (\d+) clay. Each geode robot costs (\d+) ore and (\d+) obsidian./;
		if (regex.match(input)) {
			var oreRobotCost:Array<Int> = [Std.parseInt(regex.matched(1)), 0, 0];
			var clayRobotCost:Array<Int> = [Std.parseInt(regex.matched(2)), 0, 0];
			var obsidianRobotCost:Array<Int> = [Std.parseInt(regex.matched(3)), Std.parseInt(regex.matched(4)), 0];
			var geodeRobotCost:Array<Int> = [Std.parseInt(regex.matched(5)), 0, Std.parseInt(regex.matched(6))];
			return new Blueprint(oreRobotCost, clayRobotCost, obsidianRobotCost, geodeRobotCost);
		} else {
			throw 'Invalid blueprint input: $input';
		}
	}

	static public function parseBlueprints(input:String):Array<Blueprint> {
		return input.split("\n").map(parseBlueprint);
	}

	static public function geodeCount(blueprint:Blueprint, maxTime:Int):Int {
		var maxCosts = blueprint.maxCosts();
		var bestScore = 0;
		var visited = new Map<String, Bool>();
		var startingRobots = [ORE => 1, CLAY => 0, OBSIDIAN => 0, GEODE => 0];
		var startingMaterials = [ORE => 0, CLAY => 0, OBSIDIAN => 0, GEODE => 0];
		var queue = [new State(startingRobots, startingMaterials, 0)];
		while (queue.length > 0) {
			var state = queue.pop();
			var stateString = state.toString();
			if (state.time <= maxTime && !visited.exists(stateString)) {
				visited[stateString] = true;
				var score = state.materials[GEODE] + (maxTime - state.time) * state.robots[GEODE];
				bestScore = Math.floor(Math.max(bestScore, score));
				for (mat => _cost in blueprint.robotCosts) {
					// Don't build more robots than you actually need to produce anything over one turn
					if (!maxCosts.exists(mat) || state.robots[mat] < maxCosts[mat]) {
						var step = state.buildRobot(blueprint, mat);
						if (step != null && step.time <= maxTime) {
							queue.push(step);
						}
					}
				}
			}
		}
		return bestScore;
	}

	static public function solve(input:String):Int {
		var blueprints:Array<Blueprint> = parseBlueprints(input);
		return blueprints.foldi((item:Blueprint, result:Int, index:Int) -> {
			var geodes = geodeCount(item, MAX_TIME);
			return result + (index + 1) * geodes;
		}, 0);
	}

	static public function solveFile(filename:String = 'input.txt') {
		var fileContents = sys.io.File.getContent(filename);
		return solve(fileContents);
	}

	static public function main() {
		var solution = solveFile();
		trace(solution);
	}
}
