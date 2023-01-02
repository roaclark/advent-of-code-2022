package;

import haxe.ds.Map;

typedef Valve = {name:String, rate:Int, neighbors:Array<String>}

typedef SearchNode = {
	valve:String,
	time:Int,
	open:Map<String, Bool>,
	pressure:Int,
}

class Solution1 {
	static public function parseValve(input:String):Valve {
		var name = input.substr(6, 2);
		var splitString = input.indexOf("; tunnels lead to valves ") == -1 ? "; tunnel leads to valve " : "; tunnels lead to valves ";
		var parts = input.substr(23).split(splitString);
		return {
			name: name,
			rate: Std.parseInt(parts[0]),
			neighbors: parts[1].split(", "),
		}
	}

	static public function parseValves(input:String):Array<Valve> {
		return input.split("\n").map(parseValve);
	}

	static public function getAllValveDistances(valves:Array<Valve>):Map<String, Map<String, Int>> {
		var distances:Map<String, Map<String, Int>> = [];
		for (valve in valves) {
			var valveDists:Map<String, Int> = [for (ch in valve.neighbors) ch => 1];
			valveDists[valve.name] = 0;
			distances[valve.name] = valveDists;
		}

		for (kValve in valves) {
			for (iValve in valves) {
				for (jValve in valves) {
					var k = kValve.name;
					var i = iValve.name;
					var j = jValve.name;
					if (distances[i][k] != null && distances[k][j] != null) {
						if (distances[i][j] == null || (distances[i][j] > distances[i][k] + distances[k][j])) {
							distances[i][j] = distances[i][k] + distances[k][j];
						}
					}
				}
			}
		}

		return distances;
	}

	static public function maximizePressure(valves:Array<Valve>, distances:Map<String, Map<String, Int>>, time:Int = 30):Int {
		var best = 0;
		var queue:Array<SearchNode> = [
			{
				valve: 'AA',
				time: 0,
				open: [],
				pressure: 0,
			}
		];

		while (queue.length > 0) {
			var curr = queue.pop();
			if (curr.time < time) {
				best = Std.int(Math.max(best, curr.pressure));
				for (nextValve in valves) {
					if (!curr.open.exists(nextValve.name)) {
						var timeToOpenNext = distances[curr.valve][nextValve.name] + 1;
						var nextOpen:Map<String, Bool> = curr.open.copy();
						nextOpen[nextValve.name] = true;
						queue.push({
							valve: nextValve.name,
							time: curr.time + timeToOpenNext,
							open: nextOpen,
							pressure: curr.pressure + (time - timeToOpenNext - curr.time) * nextValve.rate,
						});
					}
				}
			}
		}

		return best;
	}

	static public function solve(input:String):Int {
		var valves = parseValves(input);
		var distances = getAllValveDistances(valves);
		var valveTargets = valves.filter(v -> v.rate > 0);
		return maximizePressure(valveTargets, distances);
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
