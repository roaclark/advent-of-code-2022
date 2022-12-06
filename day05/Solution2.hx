package;

import haxe.ds.GenericStack;

class Solution2 {
	static public function solve(input:String) {
		var splitInput = input.split("\n\n");
		var stacks = Solution1.parseStacks(splitInput[0]);
		var steps = Solution1.parseSteps(splitInput[1]);

		for (step in steps) {
			var tempStack = new GenericStack<String>();
			for (_ in 0...step[0]) {
				tempStack.add(stacks[step[1]].pop());
			}
			for (_ in 0...step[0]) {
				stacks[step[2]].add(tempStack.pop());
			}
		}

		return stacks.map(v -> v.first()).join("");
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
