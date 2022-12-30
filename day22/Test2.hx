package;

import utest.Assert;

class Test extends utest.Test {
	function testMain1() {
		var fileContents = sys.io.File.getContent('input_test1.txt');
		Assert.equals(5031, Solution2.solve(fileContents, true));
	}

	function testParseCubeSides_north() {
		var testTable = [
			{
				side: 0,
				expected: {
					position: {row: 3, col: 0},
					facing: Solution1.Direction.EAST,
					faceIndex: 5,
				}
			},
			{
				side: 1,
				expected: {
					position: {row: 49, col: 3},
					facing: Solution1.Direction.NORTH,
					faceIndex: 5,
				}
			},
			{
				side: 2,
				expected: {
					position: {row: 49, col: 3},
					facing: Solution1.Direction.NORTH,
					faceIndex: 0,
				}
			},
			{
				side: 3,
				expected: {
					position: {row: 3, col: 0},
					facing: Solution1.Direction.EAST,
					faceIndex: 2,
				}
			},
			{
				side: 4,
				expected: {
					position: {row: 49, col: 3},
					facing: Solution1.Direction.NORTH,
					faceIndex: 2,
				}
			},
			{
				side: 5,
				expected: {
					position: {row: 49, col: 3},
					facing: Solution1.Direction.NORTH,
					faceIndex: 3,
				}
			},
		];
		var mapData = sys.io.File.getContent('input.txt').split("\n\n")[0];
		var sides = Solution2.parseCubeSides(mapData, false);
		for (i in 0...testTable.length) {
			var testData = testTable[i];
			Assert.same(testData.expected, sides[testData.side].translations[Solution1.Direction.NORTH]({row: 0, col: 3}));
		}
	}

	function testParseCubeSides_south() {
		var testTable = [
			{
				side: 0,
				expected: {
					position: {row: 0, col: 3},
					facing: Solution1.Direction.SOUTH,
					faceIndex: 2,
				}
			},
			{
				side: 1,
				expected: {
					position: {row: 3, col: 49},
					facing: Solution1.Direction.WEST,
					faceIndex: 2,
				}
			},
			{
				side: 2,
				expected: {
					position: {row: 0, col: 3},
					facing: Solution1.Direction.SOUTH,
					faceIndex: 4,
				}
			},
			{
				side: 3,
				expected: {
					position: {row: 0, col: 3},
					facing: Solution1.Direction.SOUTH,
					faceIndex: 5,
				}
			},
			{
				side: 4,
				expected: {
					position: {row: 3, col: 49},
					facing: Solution1.Direction.WEST,
					faceIndex: 5,
				}
			},
			{
				side: 5,
				expected: {
					position: {row: 0, col: 3},
					facing: Solution1.Direction.SOUTH,
					faceIndex: 1,
				}
			},
		];
		var mapData = sys.io.File.getContent('input.txt').split("\n\n")[0];
		var sides = Solution2.parseCubeSides(mapData, false);
		for (i in 0...testTable.length) {
			var testData = testTable[i];
			Assert.same(testData.expected, sides[testData.side].translations[Solution1.Direction.SOUTH]({row: 49, col: 3}));
		}
	}

	function testParseCubeSides_east() {
		var testTable = [
			{
				side: 0,
				expected: {
					position: {row: 3, col: 0},
					facing: Solution1.Direction.EAST,
					faceIndex: 1,
				}
			},
			{
				side: 1,
				expected: {
					position: {row: 46, col: 49},
					facing: Solution1.Direction.WEST,
					faceIndex: 4,
				}
			},
			{
				side: 2,
				expected: {
					position: {row: 49, col: 3},
					facing: Solution1.Direction.NORTH,
					faceIndex: 1,
				}
			},
			{
				side: 3,
				expected: {
					position: {row: 3, col: 0},
					facing: Solution1.Direction.EAST,
					faceIndex: 4,
				}
			},
			{
				side: 4,
				expected: {
					position: {row: 46, col: 49},
					facing: Solution1.Direction.WEST,
					faceIndex: 1,
				}
			},
			{
				side: 5,
				expected: {
					position: {row: 49, col: 3},
					facing: Solution1.Direction.NORTH,
					faceIndex: 4,
				}
			},
		];
		var mapData = sys.io.File.getContent('input.txt').split("\n\n")[0];
		var sides = Solution2.parseCubeSides(mapData, false);
		for (i in 0...testTable.length) {
			var testData = testTable[i];
			Assert.same(testData.expected, sides[testData.side].translations[Solution1.Direction.EAST]({row: 3, col: 49}));
		}
	}

	function testParseCubeSides_west() {
		var testTable = [
			{
				side: 0,
				expected: {
					position: {row: 46, col: 0},
					facing: Solution1.Direction.EAST,
					faceIndex: 3,
				}
			},
			{
				side: 1,
				expected: {
					position: {row: 3, col: 49},
					facing: Solution1.Direction.WEST,
					faceIndex: 0,
				}
			},
			{
				side: 2,
				expected: {
					position: {row: 0, col: 3},
					facing: Solution1.Direction.SOUTH,
					faceIndex: 3,
				}
			},
			{
				side: 3,
				expected: {
					position: {row: 46, col: 0},
					facing: Solution1.Direction.EAST,
					faceIndex: 0,
				}
			},
			{
				side: 4,
				expected: {
					position: {row: 3, col: 49},
					facing: Solution1.Direction.WEST,
					faceIndex: 3,
				}
			},
			{
				side: 5,
				expected: {
					position: {row: 0, col: 3},
					facing: Solution1.Direction.SOUTH,
					faceIndex: 0,
				}
			},
		];
		var mapData = sys.io.File.getContent('input.txt').split("\n\n")[0];
		var sides = Solution2.parseCubeSides(mapData, false);
		for (i in 0...testTable.length) {
			var testData = testTable[i];
			Assert.same(testData.expected, sides[testData.side].translations[Solution1.Direction.WEST]({row: 3, col: 0}));
		}
	}
}

function main() {
	utest.UTest.run([new Test()]);
}
