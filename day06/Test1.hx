package;

import utest.Assert;

class Test extends utest.Test {
	function testMain1() {
		Assert.equals(7, Solution1.solve('mjqjpqmgbljsphdztnvjfqwrcgsmlb'));
		Assert.equals(5, Solution1.solve('bvwbjplbgvbhsrlpgdmjqwftvncz'));
		Assert.equals(6, Solution1.solve('nppdvjthqldpwncqszvftbrmjlhg'));
		Assert.equals(10, Solution1.solve('nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg'));
		Assert.equals(11, Solution1.solve('zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw'));
		Assert.equals(10, Solution1.solve('aaaaaaabcd'));
		Assert.equals(null, Solution1.solve('aaaaaaa'));
	}
}

function main() {
	utest.UTest.run([new Test()]);
}
