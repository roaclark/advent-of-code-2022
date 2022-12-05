package;

import utest.Assert;

class Test extends utest.Test {
	function testMain1() {
		Assert.equals(4, Solution2.solveFile('input_test1.txt'));
	}

	function testCheckIfOverlaps1() {
		Assert.equals(false, Solution2.checkIfOverlaps(2, 4, 6, 8));
		Assert.equals(false, Solution2.checkIfOverlaps(2, 3, 4, 5));
		Assert.equals(true, Solution2.checkIfOverlaps(5, 7, 7, 9));
		Assert.equals(true, Solution2.checkIfOverlaps(2, 8, 3, 7));
		Assert.equals(true, Solution2.checkIfOverlaps(6, 6, 4, 6));
		Assert.equals(true, Solution2.checkIfOverlaps(2, 6, 4, 8));
	}
}

function main() {
	utest.UTest.run([new Test()]);
}
