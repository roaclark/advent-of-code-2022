package;

import utest.Assert;

class Test extends utest.Test {
	function testMain1() {
		Assert.equals(12, Solution2.solveFile('input_test1.txt'));
	}

	function testScoreRound1() {
		Assert.equals(4, Solution2.scoreRound('A Y'));
		Assert.equals(1, Solution2.scoreRound('B X'));
		Assert.equals(7, Solution2.scoreRound('C Z'));
	}

	function testPickPlay1() {
		Assert.equals('rock', Solution2.pickPlay('rock', 'Y'));
		Assert.equals('rock', Solution2.pickPlay('paper', 'X'));
		Assert.equals('rock', Solution2.pickPlay('scissors', 'Z'));
	}
}

function main() {
	utest.UTest.run([new Test()]);
}
