package;

import haxe.ds.Vector;

typedef Storm = {
	startPosition:Int,
	direction:Int,
};

typedef StormMap = {
	width:Int,
	height:Int,
	rowStorms:Map<Int, Array<Storm>>,
	colStorms:Map<Int, Array<Storm>>
};

class Solution1 {
	static public function parseInput(input:String):StormMap {
		var rowStorms:Map<Int, Array<Storm>> = [];
		var colStorms:Map<Int, Array<Storm>> = [];
		var lines = input.split("\n");
		var height = lines.length;
		var width = lines[0].length;
		for (r in 0...height) {
			rowStorms[r] = [];
			for (c in 0...width) {
				if (r == 0) {
					colStorms[c] = [];
				}
				var ch = lines[r].charAt(c);
				switch ch {
					case "<":
						rowStorms[r].push({startPosition: c, direction: -1});
					case ">":
						rowStorms[r].push({startPosition: c, direction: 1});
					case "v":
						colStorms[c].push({startPosition: r, direction: 1});
					case "^":
						colStorms[c].push({startPosition: r, direction: -1});
				}
			}
		}
		return {
			height: height,
			width: width,
			rowStorms: rowStorms,
			colStorms: colStorms,
		}
	}

	static public function reachableSpace(row:Int, col:Int, width:Int, height:Int):Bool {
		if (row == 0) {
			return col == 1;
		}
		if (row == height - 1) {
			return col == width - 2;
		}
		return (col > 0 && row > 0 && col < width - 1 && row < height - 1);
	}

	static public function stormPosition(storm:Storm, time:Int, mapSize:Int):Int {
		var stormPosition = storm.startPosition + storm.direction * time;
		stormPosition = (stormPosition - 1) % (mapSize - 2);
		if (stormPosition < 0) {
			stormPosition += mapSize - 2;
		}
		return stormPosition + 1;
	}

	static public function checkValid(stormMap:StormMap, positionTime:Vector<Int>):Bool {
		if (!reachableSpace(positionTime[0], positionTime[1], stormMap.width, stormMap.height)) {
			return false;
		}
		for (storm in stormMap.rowStorms[positionTime[0]]) {
			if (stormPosition(storm, positionTime[2], stormMap.width) == positionTime[1]) {
				return false;
			}
		}
		for (storm in stormMap.colStorms[positionTime[1]]) {
			if (stormPosition(storm, positionTime[2], stormMap.height) == positionTime[0]) {
				return false;
			}
		}
		return true;
	}

	static public function findShortestPath(stormMap:StormMap, start:Vector<Int>, goal:Vector<Int>):Int {
		var queue:Array<Vector<Int>> = [start];
		var visited:Map<String, Bool> = [];
		while (queue.length > 0) {
			var curr = queue.shift();
			if (curr[0] == goal[0] && curr[1] == goal[1]) {
				return curr[2];
			}
			var currStr = curr.join(",");
			if (!visited.exists(currStr)) {
				visited[currStr] = true;
				var children:Array<Vector<Int>> = [
					Vector.fromArrayCopy([curr[0], curr[1], curr[2] + 1]),
					Vector.fromArrayCopy([curr[0] + 1, curr[1], curr[2] + 1]),
					Vector.fromArrayCopy([curr[0] - 1, curr[1], curr[2] + 1]),
					Vector.fromArrayCopy([curr[0], curr[1] + 1, curr[2] + 1]),
					Vector.fromArrayCopy([curr[0], curr[1] - 1, curr[2] + 1]),
				];
				for (child in children) {
					if (checkValid(stormMap, child)) {
						queue.push(child);
					}
				}
			}
		}
		throw("No path found");
	}

	static public function solve(input:String):Int {
		var stormMap = parseInput(input);
		return findShortestPath(stormMap, Vector.fromArrayCopy([0, 1, 0]), Vector.fromArrayCopy([stormMap.height - 1, stormMap.width - 2]));
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
