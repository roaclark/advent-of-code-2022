package;

import utest.Assert;

class Test extends utest.Test {
	function testMain1() {
		Assert.equals(10605, Solution1.solveFile('input_test1.txt'));
	}

	function createTestMonkeys():Array<Solution1.Monkey> {
		return [
			new Solution1.Monkey([79, 98], v -> v * 19, 23, 2, 3),
			new Solution1.Monkey([54, 65, 75, 74], v -> v + 6, 19, 2, 0),
			new Solution1.Monkey([79, 60, 97], v -> v * v, 13, 1, 3),
			new Solution1.Monkey([74], v -> v + 3, 17, 0, 1),
		];
	}

	function testRound1() {
		var monkeys = createTestMonkeys();
		var accessCounts = Solution1.simulateRounds(monkeys, 1);
		Assert.same([20, 23, 27, 26], monkeys[0].items);
		Assert.same([2080, 25, 167, 207, 401, 1046], monkeys[1].items);
		Assert.same([], monkeys[2].items);
		Assert.same([], monkeys[3].items);
		Assert.same({
			'0': 2,
			'1': 4,
			'2': 3,
			'3': 5
		}, accessCounts);
	}

	function testRound2() {
		var monkeys = createTestMonkeys();
		var accessCounts = Solution1.simulateRounds(monkeys, 20);
		Assert.same([10, 12, 14, 26, 34], monkeys[0].items);
		Assert.same([245, 93, 53, 199, 115], monkeys[1].items);
		Assert.same([], monkeys[2].items);
		Assert.same([], monkeys[3].items);
		Assert.same({
			'0': 101,
			'1': 95,
			'2': 7,
			'3': 105
		}, accessCounts);
	}
}

function main() {
	utest.UTest.run([new Test()]);
}
