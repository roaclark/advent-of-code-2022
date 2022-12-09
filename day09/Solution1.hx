package;

import haxe.DynamicAccess;

class Solution1 {
	static public function moveHead(head:Array<Int>, dir:String, dist:Int):Array<Int> {
		return switch dir {
			case 'R': [head[0] + dist, head[1]];
			case 'U': [head[0], head[1] + dist];
			case 'L': [head[0] - dist, head[1]];
			case 'D': [head[0], head[1] - dist];
			default: throw 'Unexpected direction: ${dir}';
		};
	}

	static public function moveTail(head:Array<Int>, tail:Array<Int>):Array<Int> {
		if (head[0] > tail[0] + 1) {
			return [tail[0] + 1, head[1]];
		}
		if (head[0] < tail[0] - 1) {
			return [tail[0] - 1, head[1]];
		}
		if (head[1] > tail[1] + 1) {
			return [head[0], tail[1] + 1];
		}
		if (head[1] < tail[1] - 1) {
			return [head[0], tail[1] - 1];
		}
		return tail;
	}

	static public function solve(input:String) {
		var visited:DynamicAccess<Bool> = {};
		var head:Array<Int> = [0, 0];
		var tail:Array<Int> = [0, 0];
		for (line in input.split("\n")) {
			var ins = line.split(" ");
			var dir = ins[0];
			var dist = Std.parseInt(ins[1]);
			head = moveHead(head, dir, dist);
			for (_ in 0...dist) {
				tail = moveTail(head, tail);
				visited[tail.join(",")] = true;
			}
		}
		return visited.keys().length;
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
