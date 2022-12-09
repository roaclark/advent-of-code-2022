package;

import haxe.DynamicAccess;

class Solution2 {
	static public function moveOneTowards(to:Int, from:Int) {
		if (to > from) {
			return from + 1;
		} else if (to < from) {
			return from - 1;
		} else {
			return from;
		}
	}

	static public function moveTail(head:Array<Int>, tail:Array<Int>):Array<Int> {
		if (Math.abs(head[0] - tail[0]) > 1 || Math.abs(head[1] - tail[1]) > 1) {
			return [moveOneTowards(head[0], tail[0]), moveOneTowards(head[1], tail[1])];
		}
		return tail;
	}

	static public function moveHead(head:Array<Int>, dir:String):Array<Int> {
		return switch dir {
			case 'R': [head[0] + 1, head[1]];
			case 'U': [head[0], head[1] + 1];
			case 'L': [head[0] - 1, head[1]];
			case 'D': [head[0], head[1] - 1];
			default: throw 'Unexpected direction: ${dir}';
		};
	}

	static public function getVisited(input:String, numLinks:Int = 10) {
		var visited:DynamicAccess<Bool> = {};
		var links:Array<Array<Int>> = [for (_ in 0...numLinks) [0, 0]];

		for (line in input.split("\n")) {
			var ins = line.split(" ");
			var dir = ins[0];
			var dist = Std.parseInt(ins[1]);
			for (_ in 0...dist) {
				links[0] = moveHead(links[0], dir);
				var moving = true;
				for (i in 1...numLinks) {
					if (moving) {
						var newLinkI = moveTail(links[i - 1], links[i]);
						if (newLinkI[0] == links[i][0] && newLinkI[1] == links[i][1]) {
							moving = false;
						} else {
							links[i] = newLinkI;
						}
					}
				}
				visited[links[numLinks - 1].join(",")] = true;
			}
		}
		return visited;
	}

	static public function solve(input:String) {
		return getVisited(input).keys().length;
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
