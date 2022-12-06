package;

class Solution2 {
	static public function solve(input:String) {
		for (i in 0...input.length - 13) {
			if (!Solution1.hasRepeats(input.substr(i, 14))) {
				return i + 14;
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
