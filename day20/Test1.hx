package;

import utest.Assert;

class Test extends utest.Test {
	function testMain1() {
		Assert.equals(3, Solution1.solveFile('input_test1.txt'));
	}

	function testDecrypt1() {
		Assert.same([0, 3, -2, 1, 2, -3, 4], Solution1.decrypt([1, 2, -3, 3, -2, 0, 4]));
	}
}

function main() {
	utest.UTest.run([new Test()]);
}
