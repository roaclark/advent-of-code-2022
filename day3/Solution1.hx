package;

import haxe.DynamicAccess;

using Lambda;

class Solution1 {
	static public function findSharedItem(sack:String) {
		var compartmentSize:Int = Math.floor(sack.length / 2);
		var compartmentA = sack.substr(0, compartmentSize);
		var compartmentACharacters:DynamicAccess<Bool> = {};
		for (ch in compartmentA.split("")) {
			compartmentACharacters[ch] = true;
		}

		var compartmentB = sack.substr(compartmentSize);
		for (ch in compartmentB.split("")) {
			if (compartmentACharacters[ch]) {
				return ch;
			}
		}
		return null;
	}

	static public function scoreItem(ch:String):Int {
		var charCode = ch.charCodeAt(0);
		if (charCode >= 65 && charCode <= 90) {
			return charCode - 38;
		}
		if (charCode >= 97 && charCode <= 122) {
			return charCode - 96;
		}
		throw "Invalid pack item";
	}

	static public function solve(input:String) {
		var sacks = input.split("\n");
		var sharedItems = sacks.map(findSharedItem);
		var scores = sharedItems.map(scoreItem);
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
