package;

using Lambda;

class Solution2 {
	static public function parseElfStore(input:String):Int {
		var values = input.split("\n");
		return values.fold((item, sum) -> {
			return sum + Std.parseInt(item);
		}, 0);
	}

	static public function solve(input:String) {
		var elfStores = input.split("\n\n");
		var elfValues = elfStores.map(parseElfStore);
		elfValues.sort((a, b) -> b - a);
		return elfValues[0] + elfValues[1] + elfValues[2];
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
