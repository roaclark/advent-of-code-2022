package;

import utest.Assert;

class Test extends utest.Test {
	function testMain1() {
		Assert.equals(8, Solution2.solveFile('input_test1.txt'));
	}

	function testScenicScore1() {
		var fileContents = sys.io.File.getContent('input_test1.txt');
		var grid = Solution2.makeGrid(fileContents);
		Assert.equals(4, Solution2.getScenicScore(grid, 1, 2));
		Assert.equals(8, Solution2.getScenicScore(grid, 3, 2));
	}
}

function main() {
	utest.UTest.run([new Test()]);
}
