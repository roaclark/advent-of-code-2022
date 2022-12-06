package;

import haxe.DynamicAccess;

class Solution1 {
	static public function hasRepeats(seq:String) {
		var charSet:DynamicAccess<Bool> = {};
		for (ch in seq.split("")) {
			if (charSet[ch]) {
				return true;
			}
			charSet[ch] = true;
		}
		return false;
	}

	static public function solve(input:String) {
		for (i in 0...input.length - 3) {
			if (!hasRepeats(input.substr(i, 4))) {
				return i + 4;
			}
		}
		return null;
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
