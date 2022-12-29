package;

import utest.Assert;

class Test extends utest.Test {
	function testMain1() {
		Assert.equals(64, Solution1.solveFile('input_test1.txt'));
	}

	function testSolve1() {
		Assert.equals(10, Solution1.solve("1,1,1\n2,1,1"));
	}

	function testExposedFaces1() {
		var map = ["1,1,1" => true, "2,1,1" => true];
		Assert.equals(5, Solution1.exposedFaces(map, "1,1,1"));
	}
}

function main() {
	utest.UTest.run([new Test()]);
}
