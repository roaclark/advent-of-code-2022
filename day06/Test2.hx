package;

import utest.Assert;

class Test extends utest.Test {
	function testMain1() {
		Assert.equals(19, Solution2.solve('mjqjpqmgbljsphdztnvjfqwrcgsmlb'));
		Assert.equals(23, Solution2.solve('bvwbjplbgvbhsrlpgdmjqwftvncz'));
		Assert.equals(23, Solution2.solve('nppdvjthqldpwncqszvftbrmjlhg'));
		Assert.equals(29, Solution2.solve('nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg'));
		Assert.equals(26, Solution2.solve('zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw'));
	}
}

function main() {
	utest.UTest.run([new Test()]);
}
