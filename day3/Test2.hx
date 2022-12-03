package;

import utest.Assert;

class Test extends utest.Test {
	function testMain1() {
		Assert.equals(70, Solution2.solveFile('input_test1.txt'));
	}

	function testFindSharedBadge() {
		Assert.equals("r", Solution2.findSharedBadge("vJrwpWtwJgWrhcsFMMfFFhFp", "jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL", "PmmdzqPrVvPwwTWBwg"));
		Assert.equals("Z", Solution2.findSharedBadge("wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn", "ttgJtRGJQctTZtZT", "CrZsJsPPZsGzwwsLwLmpwMDw"));
	}
}

function main() {
	utest.UTest.run([new Test()]);
}
