package;

import utest.Assert;

class Test extends utest.Test {
	function testMain1() {
		Assert.equals(31, Solution1.solveFile('input_test1.txt'));
	}

	function testChildren1() {
		var parseRes = Solution1.parseGrid(sys.io.File.getContent('input_test1.txt'));
		var grid = parseRes.grid;
		Assert.same([[1, 0], [0, 1]], Solution1.getChildren(grid, [0, 0]));
		Assert.same([[1, 3], [3, 3], [2, 2]], Solution1.getChildren(grid, [2, 3]));
	}
}

function main() {
	utest.UTest.run([new Test()]);
}
