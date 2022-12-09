package;

import utest.Assert;

class Test extends utest.Test {
	function testMain1() {
		Assert.equals(95437, Solution1.solveFile('input_test1.txt'));
	}

	function testFileSize1() {
		var lines = sys.io.File.getContent('input_test1.txt').split('\n');
		var tree = Solution1.buildTree(lines);
		Assert.equals(584, Solution1.getDirectorySize(tree.dirs['a'].dirs['e']));
		Assert.equals(94853, Solution1.getDirectorySize(tree.dirs['a']));
		Assert.equals(24933642, Solution1.getDirectorySize(tree.dirs['d']));
		Assert.equals(48381165, Solution1.getDirectorySize(tree));
	}
}

function main() {
	utest.UTest.run([new Test()]);
}
