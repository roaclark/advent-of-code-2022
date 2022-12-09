package;

class Solution2 {
	static public function makeGrid(input):Array<Array<Int>> {
		var lines = input.split("\n");
		var grid:Array<Array<Int>> = lines.map(line -> line.split("").map(v -> Std.parseInt(v)));
		return grid;
	}

	static public function getScenicScore(grid, r, c):Int {
		var height = grid.length;
		var width = grid[0].length;

		var up = 0;
		while (up < r && grid[r - up - 1][c] < grid[r][c]) {
			up += 1;
		}
		if (up < r) {
			up += 1;
		}

		var down = 0;
		while (down < (height - 1 - r) && grid[r + down + 1][c] < grid[r][c]) {
			down += 1;
		}
		if (down < (height - 1 - r)) {
			down += 1;
		}

		var left = 0;
		while (left < c && grid[r][c - left - 1] < grid[r][c]) {
			left += 1;
		}
		if (left < c) {
			left += 1;
		}

		var right = 0;
		while (right < (width - 1 - c) && grid[r][c + right + 1] < grid[r][c]) {
			right += 1;
		}
		if (right < (width - 1 - c)) {
			right += 1;
		}

		return up * down * left * right;
	}

	static public function solve(input:String):Int {
		var grid = makeGrid(input);
		var bestScenicScore = 0;
		for (r in 0...grid.length) {
			for (c in 0...grid[0].length) {
				bestScenicScore = Math.ceil(Math.max(bestScenicScore, getScenicScore(grid, r, c)));
			}
		}
		return bestScenicScore;
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
