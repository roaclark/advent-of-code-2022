package;

import haxe.ds.GenericStack;

class Solution1 {
	static public function parseStacks(stackInput:String):Array<GenericStack<String>> {
		var stackLines = stackInput.split("\n");
		var stackCount:Int = Math.ceil(stackLines[0].length / 4);

		var stacks:Array<GenericStack<String>> = [];
		for (_ in 0...stackCount) {
			stacks.push(new GenericStack<String>());
		}

		for (rowI in 0...stackLines.length - 1) {
			var row = stackLines[stackLines.length - rowI - 2];
			for (stackI in 0...stackCount) {
				var ch = row.charAt(1 + 4 * stackI);
				if (ch != " ") {
					stacks[stackI].add(ch);
				}
			}
		}
		return stacks;
	}

	static public function parseStep(step:String):Array<Int> {
		var split = step.split(" ");
		return [Std.parseInt(split[1]), Std.parseInt(split[3]) - 1, Std.parseInt(split[5]) - 1];
	}

	static public function parseSteps(stepInput:String):Array<Array<Int>> {
		return stepInput.split("\n").map(parseStep);
	}

	static public function solve(input:String) {
		var splitInput = input.split("\n\n");
		var stacks = parseStacks(splitInput[0]);
		var steps = parseSteps(splitInput[1]);

		for (step in steps) {
			for (_ in 0...step[0]) {
				var val = stacks[step[1]].pop();
				stacks[step[2]].add(val);
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
