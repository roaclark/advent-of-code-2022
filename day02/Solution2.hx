package;

import haxe.DynamicAccess;

using Lambda;

class Solution2 {
	static var BEATS:DynamicAccess<String> = {
		'rock': 'scissors',
		'paper': 'rock',
		'scissors': 'paper',
	}

	static var LOSES:DynamicAccess<String> = {
		'scissors': 'rock',
		'rock': 'paper',
		'paper': 'scissors',
	}

	static var SCORES:DynamicAccess<Int> = {
		'rock': 1,
		'paper': 2,
		'scissors': 3,
	}

	static var OUTCOME_SCORES:DynamicAccess<Int> = {
		'X': 0,
		'Y': 3,
		'Z': 6,
	}

	static var OPPONENT_CODES:DynamicAccess<String> = {
		'A': 'rock',
		'B': 'paper',
		'C': 'scissors',
	}

	static public function pickPlay(opponentPlay, goal) {
		if (goal == 'X') {
			return BEATS[opponentPlay];
		}
		if (goal == 'Y') {
			return opponentPlay;
		}
		return LOSES[opponentPlay];
	}

	static public function scoreRound(input:String) {
		var plays = input.split(' ');
		var opponentPlay = OPPONENT_CODES[plays[0]];
		var goal = plays[1];
		var playerPlay = pickPlay(opponentPlay, goal);
		return OUTCOME_SCORES[goal] + SCORES[playerPlay];
	}

	static public function solve(input:String) {
		var rounds = input.split('\n');
		return rounds.fold((round, total) -> total + scoreRound(round), 0);
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
