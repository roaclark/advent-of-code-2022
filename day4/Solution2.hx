package;

using Lambda;

class Solution2 {
	static public function checkIfOverlaps(aStart:Int, aEnd:Int, bStart:Int, bEnd:Int):Bool {
		return !(aEnd < bStart || bEnd < aStart);
	}

	static public function solve(input:String) {
		var lines = input.split("\n");
		var assignmentParts = lines.map(Solution1.splitLine);
		return assignmentParts.fold((v, cnt) -> {
			return cnt + (checkIfOverlaps(v[0], v[1], v[2], v[3]) ? 1 : 0);
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
