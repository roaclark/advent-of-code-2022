package;

class Solution2 {
	static public function simulateRound(elves:Map<String, Bool>, round:Int):Bool {
		var moved = false;
		var targets:Map<String, Array<String>> = [];
		for (elf in elves.keys()) {
			var target = Solution1.pickTarget(elves, elf, round);
			if (targets.exists(target)) {
				targets[target].push(elf);
			} else {
				targets[target] = [elf];
			}
		}
		for (target in targets.keys()) {
			if (targets[target].length == 1 && target != targets[target][0]) {
				elves.remove(targets[target][0]);
				elves[target] = true;
				moved = true;
			}
		}
		return moved;
	}

	static public function solve(input:String):Int {
		var elves = Solution1.parseInput(input);
		var rounds = 0;
		while (simulateRound(elves, rounds)) {
			rounds++;
		}
		return rounds + 1;
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
