package;

import haxe.ds.Vector;
import utest.Assert;

class Test extends utest.Test {
	function testMain1() {
		Assert.equals(10, Solution1.solveFile('input_test2.txt'));
		Assert.equals(18, Solution1.solveFile('input_test1.txt'));
	}

	function testStormPosition1() {
		Assert.equals(5, Solution1.stormPosition({startPosition: 4, direction: 1}, 1, 7));
		Assert.equals(3, Solution1.stormPosition({startPosition: 4, direction: -1}, 1, 7));
		Assert.equals(4, Solution1.stormPosition({startPosition: 4, direction: 1}, 5, 7));
		Assert.equals(4, Solution1.stormPosition({startPosition: 4, direction: -1}, 5, 7));
		Assert.equals(2, Solution1.stormPosition({startPosition: 4, direction: -1}, 2, 7));
		Assert.equals(3, Solution1.stormPosition({startPosition: 4, direction: -1}, 21, 7));
		Assert.equals(5, Solution1.stormPosition({startPosition: 4, direction: 1}, 21, 7));
		Assert.equals(1, Solution1.stormPosition({startPosition: 4, direction: 1}, 22, 7));
	}

	function testStormPosition2() {
		// row
		Assert.notEquals(3, Solution1.stormPosition({startPosition: 1, direction: 1}, 11, 8));
		Assert.notEquals(3, Solution1.stormPosition({startPosition: 2, direction: 1}, 11, 8));
		Assert.notEquals(3, Solution1.stormPosition({startPosition: 4, direction: -1}, 11, 8));
		Assert.notEquals(3, Solution1.stormPosition({startPosition: 6, direction: -1}, 11, 8));
		// col
		Assert.notEquals(1, Solution1.stormPosition({startPosition: 4, direction: 1}, 11, 6));
	}

	function testCheckValid1() {
		var stormMap = Solution1.parseInput(sys.io.File.getContent("input_test1.txt"));
		trace(stormMap.rowStorms[1]);
		trace(stormMap.colStorms[3]);
		trace(stormMap.width);
		trace(stormMap.height);
		Assert.isTrue(Solution1.checkValid(stormMap, Vector.fromArrayCopy([1, 3, 11])));
	}
}

function main() {
	utest.UTest.run([new Test()]);
}
