package;

import haxe.DynamicAccess;

using Lambda;

class Solution1 {
	static var BEATS:DynamicAccess<String> = {
		'rock': 'scissors',
		'paper': 'rock',
		'scissors': 'paper',
	}

	static var SCORES:DynamicAccess<Int> = {
		'rock': 1,
		'paper': 2,
		'scissors': 3,
	}

	static var OPPONENT_CODES:DynamicAccess<String> = {
		'A': 'rock',
		'B': 'paper',
		'C': 'scissors',
	}

	static var PLAYER_CODES:DynamicAccess<String> = {
		'X': 'rock',
		'Y': 'paper',
		'Z': 'scissors',
	}

	static public function scoreOutcome(opponentPlay, playerPlay) {
		if (opponentPlay == playerPlay) {
			return 3;
		}
		if (BEATS[opponentPlay] == playerPlay) {
			return 0;
		}
		return 6;
	}

	static public function scoreRound(input:String) {
		var plays = input.split(' ');
		var opponentPlay = OPPONENT_CODES[plays[0]];
		var playerPlay = PLAYER_CODES[plays[1]];
		return SCORES[playerPlay] + scoreOutcome(opponentPlay, playerPlay);
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
