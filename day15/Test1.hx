package;

import utest.Assert;

class Test extends utest.Test {
	// @Ignored
	function testMain1() {
		var fileContents = sys.io.File.getContent('input_test1.txt');
		Assert.equals(26, Solution1.solve(fileContents, 10));
	}

	function testGetUnreachableRange() {
		Assert.same([-1, 17], Solution1.getUnreachableRange({x: 8, y: 7}, {x: 2, y: 10}, 7));
		Assert.same([2, 14], Solution1.getUnreachableRange({x: 8, y: 7}, {x: 2, y: 10}, 10));
		Assert.same([8, 8], Solution1.getUnreachableRange({x: 8, y: 7}, {x: 2, y: 10}, 16));
		Assert.same([8, 8], Solution1.getUnreachableRange({x: 8, y: 7}, {x: 2, y: 10}, -2));
		Assert.isNull(Solution1.getUnreachableRange({x: 8, y: 7}, {x: 2, y: 10}, 17));
		Assert.isNull(Solution1.getUnreachableRange({x: 8, y: 7}, {x: 2, y: 10}, -3));
	}

	function testGetTotalUnreachables() {
		Assert.equals(26, Solution1.getTotalUnreachables([[12, 12], [2, 14], [2, 2], [-2, 2], [16, 24], [14, 18]], [2]));
	}
}

function main() {
	utest.UTest.run([new Test()]);
}
