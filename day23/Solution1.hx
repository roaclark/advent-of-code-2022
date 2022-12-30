package;

using Lambda;

typedef Proposal = {
	checks:Array<Array<Int>>,
	move:Array<Int>,
}

class Solution1 {
	static var PROPOSALS:Array<Proposal> = [
		{
			checks: [[-1, -1], [-1, 0], [-1, 1]],
			move: [-1, 0],
		},
		{
			checks: [[1, -1], [1, 0], [1, 1]],
			move: [1, 0],
		},
		{
			checks: [[-1, -1], [0, -1], [1, -1]],
			move: [0, -1],
		},
		{
			checks: [[-1, 1], [0, 1], [1, 1]],
			move: [0, 1],
		},
	];
	static var EMPTY_PROPOSAL:Proposal = {
		checks: [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]],
		move: [0, 0],
	};

	static public function parseInput(input:String):Map<String, Bool> {
		var elves:Map<String, Bool> = [];
		var lines = input.split("\n");
		for (r in 0...lines.length) {
			var line = lines[r];
			for (c in 0...line.length) {
				if (line.charAt(c) == "#") {
					elves['$r,$c'] = true;
				}
			}
		}
		return elves;
	}

	static public function addVector(a, b) {
		return [a[0] + b[0], a[1] + b[1]];
	}

	static public function validProposal(elves:Map<String, Bool>, elf:Array<Int>, proposal:Proposal) {
		return proposal.checks.fold((check, valid) -> {
			if (!valid) {
				return false;
			}
			var checkPoint = addVector(check, elf);
			return !elves.exists(checkPoint.join(","));
		}, true);
	}

	static public function pickTarget(elves:Map<String, Bool>, elf:String, round:Int):String {
		var elfPoint = elf.split(",").map(Std.parseInt);
		if (validProposal(elves, elfPoint, EMPTY_PROPOSAL)) {
			return elf;
		}
		for (i in round...round + 4) {
			var proposal = PROPOSALS[i % PROPOSALS.length];
			if (validProposal(elves, elfPoint, proposal)) {
				var target = addVector(elfPoint, proposal.move);
				return target.join(",");
			}
		}
		return elf;
	}

	static public function simulateRound(elves:Map<String, Bool>, round:Int):Map<String, Bool> {
		var targets:Map<String, Array<String>> = [];
		for (elf in elves.keys()) {
			var target = pickTarget(elves, elf, round);
			if (targets.exists(target)) {
				targets[target].push(elf);
			} else {
				targets[target] = [elf];
			}
		}
		for (target in targets.keys()) {
			if (targets[target].length == 1) {
				elves.remove(targets[target][0]);
				elves[target] = true;
			}
		}
		return elves;
	}

	static public function countEmptySpaces(elves:Map<String, Bool>):Int {
		var minR:Int = null;
		var maxR:Int = null;
		var minC:Int = null;
		var maxC:Int = null;
		var elfCount:Int = 0;
		for (elf in elves.keys()) {
			var point = elf.split(",").map(Std.parseInt);
			minR = minR == null ? point[0] : Math.floor(Math.min(minR, point[0]));
			maxR = maxR == null ? point[0] : Math.floor(Math.max(maxR, point[0]));
			minC = minC == null ? point[1] : Math.floor(Math.min(minC, point[1]));
			maxC = maxC == null ? point[1] : Math.floor(Math.max(maxC, point[1]));
			elfCount++;
		}
		return (maxC - minC + 1) * (maxR - minR + 1) - elfCount;
	}

	static public function solve(input:String, rounds:Int = 10):Int {
		var elves = parseInput(input);
		for (i in 0...rounds) {
			elves = simulateRound(elves, i);
		}
		return countEmptySpaces(elves);
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
