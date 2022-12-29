package;

using Lambda;

class Solution1 {
	static var adjacentVecs:Array<Array<Int>> = [[1, 0, 0], [-1, 0, 0], [0, 1, 0], [0, -1, 0], [0, 0, 1], [0, 0, -1]];

	static public function addVec(a:Array<Int>, b:Array<Int>):Array<Int> {
		return [a[0] + b[0], a[1] + b[1], a[2] + b[2]];
	}

	static public function exposedFaces(map:Map<String, Bool>, coordStr:String):Int {
		var coord = coordStr.split(",").map(v -> Std.parseInt(v));
		return adjacentVecs.fold((adj, exp) -> {
			var adjCoord:Array<Int> = addVec(coord, adj);
			if (!map.exists(adjCoord.join(","))) {
				return exp + 1;
			}
			return exp;
		}, 0);
	}

	static public function solve(input:String):Int {
		var coords = input.split("\n");
		var map:Map<String, Bool> = [for (c in coords) c => true];
		return coords.fold((coord, area) -> {
			return area + exposedFaces(map, coord);
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
