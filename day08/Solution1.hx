package;

using Lambda;

class Solution1 {
	static public function solve(input:String):Int {
		var lines = input.split("\n");
		var height = lines.length;
		var width = lines[0].length;
		var grid:Array<Array<Int>> = lines.map(line -> line.split("").map(v -> Std.parseInt(v)));
		var reachable:Array<Array<Bool>> = [for (_ in 0...height) [for (_ in 0...width) false]];

		for (r in 0...height) {
			var c = 0;
			reachable[r][c] = true;
			var max = grid[r][c];
			while (c < width) {
				if (grid[r][c] > max) {
					max = grid[r][c];
					reachable[r][c] = true;
				}
				c += 1;
			}
			var c = width - 1;
			reachable[r][c] = true;
			var max = grid[r][c];
			while (c >= 0) {
				if (grid[r][c] > max) {
					max = grid[r][c];
					reachable[r][c] = true;
				}
				c -= 1;
			}
		}

		for (c in 0...width) {
			var r = 0;
			reachable[r][c] = true;
			var max = grid[r][c];
			while (r < height) {
				if (grid[r][c] > max) {
					max = grid[r][c];
					reachable[r][c] = true;
				}
				r += 1;
			}
			var r = width - 1;
			reachable[r][c] = true;
			var max = grid[r][c];
			while (r >= 0) {
				if (grid[r][c] > max) {
					max = grid[r][c];
					reachable[r][c] = true;
				}
				r -= 1;
			}
		}

		return reachable.fold((row, t) -> {
			return t + row.fold((val, t) -> {
				return t + (val ? 1 : 0);
			}, 0);
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
