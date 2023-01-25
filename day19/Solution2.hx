package;

using Lambda;

class Solution2 {
	static var MAX_TIME:Int = 32;

	static public function solve(input:String):Int {
		var blueprints:Array<Solution1.Blueprint> = Solution1.parseBlueprints(input);
		blueprints = blueprints.slice(0, 3);
		return blueprints.fold((item:Solution1.Blueprint, result:Int) -> {
			var geodes:Int = Solution1.geodeCount(item, MAX_TIME);
			return result * geodes;
		}, 1);
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
