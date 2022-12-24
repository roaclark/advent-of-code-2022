package;

class Solution2 {
	static var DIVIDER_1 = "[[2]]";
	static var DIVIDER_2 = "[[6]]";

	static public function solve(input:String) {
		var allLines:Array<String> = input.split("\n");
		allLines = allLines.filter((st) -> st.length > 0);
		allLines.push(DIVIDER_1);
		allLines.push(DIVIDER_2);
		allLines.sort((a, b) -> Solution1.isOrdered(a, b) ? -1 : 1);
		return (allLines.indexOf(DIVIDER_1) + 1) * (allLines.indexOf(DIVIDER_2) + 1);
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
