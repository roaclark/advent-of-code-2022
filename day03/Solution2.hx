package;

import haxe.DynamicAccess;

using Lambda;

class Solution2 {
	static public function findSharedBadge(packA:String, packB:String, packC:String):String {
		var compartmentCharacters:DynamicAccess<Int> = {};
		for (ch in packA.split("")) {
			compartmentCharacters[ch] = 1;
		}
		for (ch in packB.split("")) {
			if (compartmentCharacters.exists(ch)) {
				compartmentCharacters[ch] = 2;
			}
		}
		for (ch in packC.split("")) {
			if (compartmentCharacters[ch] == 2) {
				return ch;
			}
		}
		throw "No matching badge";
	}

	static public function solve(input:String) {
		var sacks = input.split("\n");
		var sharedBadges:Array<String> = [];
		var groupCnt:Int = Math.floor(sacks.length / 3);
		for (i in 0...groupCnt) {
			sharedBadges.push(findSharedBadge(sacks[i * 3], sacks[i * 3 + 1], sacks[i * 3 + 2]));
		}
		var scores = sharedBadges.map(Solution1.scoreItem);
		return scores.fold((v, total) -> v + total, 0);
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
