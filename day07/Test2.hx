package;

import utest.Assert;

class Test extends utest.Test {
	function testMain1() {
		Assert.equals(24933642, Solution2.solveFile('input_test1.txt'));
	}
}

function main() {
	utest.UTest.run([new Test()]);
}
