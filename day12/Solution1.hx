package;

import haxe.DynamicAccess;

class Solution1 {
	static public function parseGrid(input:String):{start:Array<Int>, goal:Array<Int>, grid:Array<Array<Int>>} {
		var start = null;
		var goal = null;
		var grid:Array<Array<Int>> = [];
		var lines = input.split("\n");
		for (r in 0...lines.length) {
			var line:Array<Int> = [];
			for (c in 0...lines[r].length) {
				var ch = lines[r].charAt(c);
				var v = if (ch == "S") {
					start = [r, c];
					0;
				} else if (ch == "E") {
					goal = [r, c];
					25;
				} else {
					ch.charCodeAt(0) - 97;
				}
				line.push(v);
			}
			grid.push(line);
		}
		return {
			start: start,
			goal: goal,
			grid: grid,
		}
	}

	static public function getVal(grid, pos) {
		return grid[pos[0]][pos[1]];
	}

	static public function addVecs(a, b) {
		return [a[0] + b[0], a[1] + b[1]];
	}

	static public function getChildren(grid:Array<Array<Int>>, curr:Array<Int>):Array<Array<Int>> {
		var children:Array<Array<Int>> = [];
		if (curr[0] > 0) {
			children.push(addVecs(curr, [-1, 0]));
		}
		if (curr[0] < grid.length - 1) {
			children.push(addVecs(curr, [1, 0]));
		}
		if (curr[1] > 0) {
			children.push(addVecs(curr, [0, -1]));
		}
		if (curr[1] < grid[0].length - 1) {
			children.push(addVecs(curr, [0, 1]));
		}
		return children.filter(ch -> getVal(grid, ch) <= getVal(grid, curr) + 1);
	}

	static public function solve(input:String) {
		var parseOutput = parseGrid(input);
		var grid = parseOutput.grid;
		var goal = parseOutput.goal;
		var queue:Array<{pos:Array<Int>, steps:Int}> = [{pos: parseOutput.start, steps: 0}];
		var visited:DynamicAccess<Bool> = {};
		while (queue.length > 0) {
			var curr = queue.pop();
			if (curr.pos[0] == goal[0] && curr.pos[1] == goal[1]) {
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
