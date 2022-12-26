package;

import utest.Assert;

class Test extends utest.Test {
	function testMain1() {
		var fileContents = sys.io.File.getContent('input_test1.txt');
		Assert.equals(56000011, Solution2.solve(fileContents, 20));
	}
}

function main() {
	utest.UTest.run([new Test()]);
}
