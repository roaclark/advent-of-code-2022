package;

import utest.Assert;

class Test extends utest.Test {
	function testMain1() {
		Assert.equals(6032, Solution1.solveFile('input_test1.txt'));
	}

	function testParseDirections1() {
		Assert.same(["10", "R", "5", "L", "5", "R", "10", "L", "4", "R", "5", "L", "5"], Solution1.parseDirections("10R5L5R10L4R5L5"));
	}

	function testParseMapData1() {
		var mapInput = "        ...#
        .#..
        #...
        ....
...#.......#
........#...
..#....#....
..........#.
        ...#....
        .....#..
        .#......
        ......#.";
		var mapData = Solution1.parseMapData(mapInput);

		Assert.equals(96, [for (k in mapData.map.keys()) k].length);
		Assert.isTrue(mapData.map["1,9"]);
		Assert.isFalse(mapData.map["2,10"]);
		Assert.isTrue(mapData.map["2,9"]);
		Assert.isFalse(mapData.map["9,12"]);
		Assert.isFalse(mapData.map.exists("3,3"));

		Assert.same({row: 1, col: 12}, mapData.rowEdgeTranslations["1,8"]);
		Assert.same({row: 1, col: 9}, mapData.rowEdgeTranslations["1,13"]);
		Assert.same({row: 8, col: 12}, mapData.rowEdgeTranslations["8,0"]);
		Assert.same({row: 8, col: 1}, mapData.rowEdgeTranslations["8,13"]);
		Assert.same({row: 9, col: 9}, mapData.rowEdgeTranslations["9,17"]);
		Assert.same({row: 9, col: 16}, mapData.rowEdgeTranslations["9,8"]);

		Assert.same({row: 5, col: 8}, mapData.colEdgeTranslations["9,8"]);
		Assert.same({row: 8, col: 8}, mapData.colEdgeTranslations["4,8"]);
		Assert.same({row: 1, col: 9}, mapData.colEdgeTranslations["13,9"]);
		Assert.same({row: 12, col: 9}, mapData.colEdgeTranslations["0,9"]);
		Assert.same({row: 9, col: 13}, mapData.colEdgeTranslations["13,13"]);
		Assert.same({row: 12, col: 13}, mapData.colEdgeTranslations["8,13"]);

		Assert.same({row: 1, col: 9}, mapData.start);
	}
}

function main() {
	utest.UTest.run([new Test()]);
}
