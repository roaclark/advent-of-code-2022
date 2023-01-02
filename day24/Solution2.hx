package;

import haxe.ds.Vector;

class Solution2 {
	static public function solve(input:String):Int {
		var stormMap = Solution1.parseInput(input);
		var startPosition = Vector.fromArrayCopy([0, 1]);
		var endPosition = Vector.fromArrayCopy([stormMap.height - 1, stormMap.width - 2]);
		var dist1 = Solution1.findShortestPath(stormMap, Vector.fromArrayCopy([startPosition[0], startPosition[1], 0]), endPosition);
		var dist2 = Solution1.findShortestPath(stormMap, Vector.fromArrayCopy([endPosition[0], endPosition[1], dist1]), startPosition);
		return Solution1.findShortestPath(stormMap, Vector.fromArrayCopy([startPosition[0], startPosition[1], dist2]), endPosition);
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
