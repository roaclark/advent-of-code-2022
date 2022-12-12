package;

import haxe.DynamicAccess;

class Solution2 {
	static public function getChildren(grid:Array<Array<Int>>, curr:Array<Int>):Array<Array<Int>> {
		var children:Array<Array<Int>> = [];
		if (curr[0] > 0) {
			children.push(Solution1.addVecs(curr, [-1, 0]));
		}
		if (curr[0] < grid.length - 1) {
			children.push(Solution1.addVecs(curr, [1, 0]));
		}
		if (curr[1] > 0) {
			children.push(Solution1.addVecs(curr, [0, -1]));
		}
		if (curr[1] < grid[0].length - 1) {
			children.push(Solution1.addVecs(curr, [0, 1]));
		}
		return children.filter(ch -> Solution1.getVal(grid, curr) <= Solution1.getVal(grid, ch) + 1);
	}

	static public function solve(input:String) {
		var parseOutput = Solution1.parseGrid(input);
		var grid = parseOutput.grid;
		var queue:Array<{pos:Array<Int>, steps:Int}> = [{pos: parseOutput.goal, steps: 0}];
		var visited:DynamicAccess<Bool> = {};
		while (queue.length > 0) {
			var curr = queue.pop();
			if (Solution1.getVal(grid, curr.pos) == 0) {
				return curr.steps;
			}
			if (!visited.exists(curr.pos.join(','))) {
				visited[curr.pos.join(',')] = true;
				for (ch in getChildren(grid, curr.pos)) {
					queue.push({pos: ch, steps: curr.steps + 1});
				}
				queue.sort((a, b) -> b.steps - a.steps);
			}
		}
		throw 'No path found';
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
