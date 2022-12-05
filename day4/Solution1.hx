package;

using Lambda;

class Solution1 {
	static public function checkIfOverlapsFull(aStart:Int, aEnd:Int, bStart:Int, bEnd:Int):Bool {
		if (aStart <= bStart && aEnd >= bEnd) {
			return true;
		}
		if (bStart <= aStart && bEnd >= aEnd) {
			return true;
		}
		return false;
	}

	static public function splitLine(input:String):Array<Int> {
		var assignments = input.split(",");
		var aParts = assignments[0].split("-");
		var bParts = assignments[1].split("-");
		return [
			Std.parseInt(aParts[0]),
			Std.parseInt(aParts[1]),
			Std.parseInt(bParts[0]),
			Std.parseInt(bParts[1])
		];
	}

	static public function solve(input:String):Int {
		var lines = input.split("\n");
		var assignmentParts = lines.map(splitLine);
		return assignmentParts.fold((v, cnt) -> {
			return cnt + (checkIfOverlapsFull(v[0], v[1], v[2], v[3]) ? 1 : 0);
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
