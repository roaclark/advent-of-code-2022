package;

import utest.Assert;

class Test extends utest.Test {
	function testMain1() {
		Assert.equals(13, Solution1.solveFile('input_test1.txt'));
	}

	function isOrderedTest(expected, a, b) {
		if (expected) {
			Assert.isTrue(Solution1.isOrdered(a, b), 'Expected strings to be in the correct order:\n${a}\n${b}');
		} else {
			Assert.isFalse(Solution1.isOrdered(a, b), 'Expected strings to be in the incorrect order:\n${a}\n${b}');
		}
	}

	function testIsOrdered1() {
		isOrderedTest(true, "[1,1,3,1,1]", "[1,1,5,1,1]");
		isOrderedTest(true, "[[1],[2,3,4]]", "[[1],4]");
		isOrderedTest(false, "[9]", "[[8,7,6]]");
		isOrderedTest(true, "[[4,4],4,4]", "[[4,4],4,4,4]");
		isOrderedTest(false, "[7,7,7,7]", "[7,7,7]");
		isOrderedTest(true, "[]", "[3]");
		isOrderedTest(false, "[[[]]]", "[[]]");
		isOrderedTest(false, "[1,[2,[3,[4,[5,6,7]]]],8,9]", "[1,[2,[3,[4,[5,6,0]]]],8,9]");
	}

	function testIsOrdered2() {
		isOrderedTest(true, "[1]", "[2]");
		isOrderedTest(false, "[2]", "[1]");
		isOrderedTest(true, "[1]", "[1,1]");
		isOrderedTest(false, "[1,1]", "[1]");
		isOrderedTest(true, "[[1]]", "[2]");
		isOrderedTest(false, "[[2]]", "[1]");
		isOrderedTest(false, "[[1,1]]", "[1]");
	}

	function testIsOrderded3() {
		isOrderedTest(false, "[[[],3,[[2,2,7,4,7],1]],[6],[[1,[9]],[[3,6,10,2,0],[10,3,0,6,1],8,7],[[3,7,5,9],5,1]],[0]]",
			"[[[]],[],[],[1,1,6,[[8,0,5,9,10],6],8]]");
		isOrderedTest(false,
			"[[5,[[0],6,[7,8,7,5],[4,8,7,7],10],[0,9,[4,9,9,6,3],[6],4],[[8,9],3,[]]],[[]],[0,[[10,10,5,8,5],2,7,0,[3]],[2,[4,6,5,1,6],[7,10,10,4],7]]]",
			"[[5,0],[[[6,3,5],[3],[8,1,5],5,9],[6],[2,0],2,[10]],[]]");
	}
}

function main() {
	utest.UTest.run([new Test()]);
}
