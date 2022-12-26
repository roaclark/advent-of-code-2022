package;

import utest.Assert;

class Test extends utest.Test {
	function testMain1() {
		Assert.equals(1651, Solution1.solveFile('input_test1.txt'));
	}

	function testMaximizePressure() {
		Assert.equals(29, Solution1.maximizePressure([{name: "AA", rate: 1, neighbors: []}], ["AA" => ["AA" => 0]]));
		Assert.equals(28,
			Solution1.maximizePressure([{name: "AA", rate: 0, neighbors: []}, {name: "BB", rate: 1, neighbors: []}],
				["AA" => ["AA" => 0, "BB" => 1], "BB" => ["AA" => 1, "BB" => 0]]));
		Assert.equals(56,
			Solution1.maximizePressure([{name: "AA", rate: 1, neighbors: []}, {name: "BB", rate: 1, neighbors: []}],
				["AA" => ["AA" => 0, "BB" => 1], "BB" => ["AA" => 1, "BB" => 0]]));
	}
}

function main() {
	utest.UTest.run([new Test()]);
}
