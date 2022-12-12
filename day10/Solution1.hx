package;

import haxe.ds.IntMap;

class Solution1 {
	static var CHECK_CYCLES:IntMap<Bool> = [20 => true, 60 => true, 100 => true, 140 => true, 180 => true, 220 => true];

	static public function solve(input:String) {
		var cycle = 0;
		var register = 1;
		var score = 0;
		for (cmd in input.split("\n")) {
			var cmdParts = cmd.split(" ");
			cycle += 1;
			if (CHECK_CYCLES.exists(cycle)) {
				score += cycle * register;
			}
			if (cmdParts[0] == "addx") {
				cycle += 1;
				if (CHECK_CYCLES.exists(cycle)) {
					score += cycle * register;
				}
				register += Std.parseInt(cmdParts[1]);
			}
		}
		return score;
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
