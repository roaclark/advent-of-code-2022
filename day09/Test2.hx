package;

import haxe.DynamicAccess;
import utest.Assert;

class Test extends utest.Test {
	function testMain1() {
		Assert.equals(1, Solution2.solveFile('input_test1.txt'));
		Assert.equals(36, Solution2.solveFile('input_test2.txt'));
	}

	function testVisited1() {
		var testVisited:DynamicAccess<Bool> = Solution2.getVisited(sys.io.File.getContent('input_test2.txt'));
		Assert.equals(36, testVisited.keys().length);
		Assert.isTrue(testVisited['0,0']);
		Assert.isTrue(testVisited['1,1']);
		Assert.isTrue(testVisited['2,2']);
		Assert.isTrue(testVisited['1,3']);
		Assert.isTrue(testVisited['2,4']);
		Assert.isTrue(testVisited['3,5']);
		Assert.isTrue(testVisited['4,5']);
		Assert.isTrue(testVisited['5,5']);
		Assert.isTrue(testVisited['6,4']);
		Assert.isTrue(testVisited['7,3']);
		Assert.isTrue(testVisited['8,2']);
		Assert.isTrue(testVisited['9,1']);
		Assert.isTrue(testVisited['10,0']);
		Assert.isTrue(testVisited['9,-1']);
		Assert.isTrue(testVisited['8,-2']);
		Assert.isTrue(testVisited['7,-3']);
		Assert.isTrue(testVisited['6,-4']);
		Assert.isTrue(testVisited['5,-5']);
		Assert.isTrue(testVisited['4,-5']);
		Assert.isTrue(testVisited['3,-5']);
		Assert.isTrue(testVisited['2,-5']);
		Assert.isTrue(testVisited['1,-5']);
		Assert.isTrue(testVisited['0,-5']);
		Assert.isTrue(testVisited['-1,-5']);
		Assert.isTrue(testVisited['-2,-5']);
		Assert.isTrue(testVisited['-3,-4']);
		Assert.isTrue(testVisited['-4,-3']);
		Assert.isTrue(testVisited['-5,-2']);
		Assert.isTrue(testVisited['-6,-1']);
		Assert.isTrue(testVisited['-7,0']);
		Assert.isTrue(testVisited['-8,1']);
		Assert.isTrue(testVisited['-9,2']);
		Assert.isTrue(testVisited['-10,3']);
		Assert.isTrue(testVisited['-11,4']);
		Assert.isTrue(testVisited['-11,5']);
		Assert.isTrue(testVisited['-11,6']);
	}

	function testVisited2() {
		var testVisited:DynamicAccess<Bool> = Solution2.getVisited("R 1\nU 1\nR 1\nU 1\nU 1", 3);
		Assert.equals(2, testVisited.keys().length);
		Assert.isTrue(testVisited['0,0']);
		Assert.isTrue(testVisited['1,1']);
	}

	function testMoveTail_move() {
		Assert.same([1, 1], Solution2.moveTail([2, 2], [0, 0]));
		Assert.same([1, 1], Solution2.moveTail([1, 2], [0, 0]));
		Assert.same([0, 1], Solution2.moveTail([0, 2], [0, 0]));
		Assert.same([-1, 1], Solution2.moveTail([-1, 2], [0, 0]));
		Assert.same([-1, 1], Solution2.moveTail([-2, 2], [0, 0]));
		Assert.same([-1, 1], Solution2.moveTail([-2, 1], [0, 0]));
		Assert.same([-1, 0], Solution2.moveTail([-2, 0], [0, 0]));
		Assert.same([-1, -1], Solution2.moveTail([-2, -1], [0, 0]));
		Assert.same([-1, -1], Solution2.moveTail([-2, -2], [0, 0]));
		Assert.same([-1, -1], Solution2.moveTail([-1, -2], [0, 0]));
		Assert.same([0, -1], Solution2.moveTail([0, -2], [0, 0]));
		Assert.same([1, -1], Solution2.moveTail([1, -2], [0, 0]));
		Assert.same([1, -1], Solution2.moveTail([2, -2], [0, 0]));
		Assert.same([1, -1], Solution2.moveTail([2, -1], [0, 0]));
		Assert.same([1, 0], Solution2.moveTail([2, 0], [0, 0]));
		Assert.same([1, 1], Solution2.moveTail([2, 1], [0, 0]));
	}

	function testMoveTail_noMove() {
		Assert.same([0, 0], Solution2.moveTail([0, 0], [0, 0]));
		Assert.same([0, 0], Solution2.moveTail([1, 1], [0, 0]));
		Assert.same([0, 0], Solution2.moveTail([1, 0], [0, 0]));
		Assert.same([0, 0], Solution2.moveTail([1, -1], [0, 0]));
		Assert.same([0, 0], Solution2.moveTail([0, -1], [0, 0]));
		Assert.same([0, 0], Solution2.moveTail([-1, -1], [0, 0]));
		Assert.same([0, 0], Solution2.moveTail([-1, 0], [0, 0]));
		Assert.same([0, 0], Solution2.moveTail([-1, 1], [0, 0]));
		Assert.same([0, 0], Solution2.moveTail([0, 1], [0, 0]));
	}
}

function main() {
	utest.UTest.run([new Test()]);
}
