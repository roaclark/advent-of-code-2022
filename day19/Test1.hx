package;

import utest.Assert;

class Test extends utest.Test {
	@:depends(testGeodeCount1)
	function testMain1() {
		Assert.equals(33, Solution1.solveFile('input_test1.txt'));
	}

	@:depends(testStateAdvanceTime1, testStateBuildRobot1, testStateBuildRobot2)
	function testGeodeCount1() {
		var blueprint1 = new Solution1.Blueprint([4, 0, 0], [2, 0, 0], [3, 14, 0], [2, 0, 7]);
		var blueprint2 = new Solution1.Blueprint([2, 0, 0], [3, 0, 0], [3, 8, 0], [3, 0, 12]);
		Assert.equals(9, Solution1.geodeCount(blueprint1, 24));
		Assert.equals(12, Solution1.geodeCount(blueprint2, 24));
	}

	function testStateAdvanceTime1() {
		var robots = [
			Solution1.Material.ORE => 3,
			Solution1.Material.CLAY => 2,
			Solution1.Material.OBSIDIAN => 1,
			Solution1.Material.GEODE => 0,
		];
		var materials = [
			Solution1.Material.ORE => 10,
			Solution1.Material.CLAY => 2,
			Solution1.Material.OBSIDIAN => 5,
			Solution1.Material.GEODE => 1,
		];
		var state = new Solution1.State(robots, materials, 10);

		var newState1 = state.advanceTime(5);
		Assert.equals(3, newState1.robots[Solution1.Material.ORE]);
		Assert.equals(25, newState1.materials[Solution1.Material.ORE]);
		Assert.equals(12, newState1.materials[Solution1.Material.CLAY]);
		Assert.equals(10, newState1.materials[Solution1.Material.OBSIDIAN]);
		Assert.equals(1, newState1.materials[Solution1.Material.GEODE]);
		Assert.equals(15, newState1.time);

		var newState2 = state.advanceTime(10);
		Assert.equals(3, newState2.robots[Solution1.Material.ORE]);
		Assert.equals(40, newState2.materials[Solution1.Material.ORE]);
		Assert.equals(22, newState2.materials[Solution1.Material.CLAY]);
		Assert.equals(15, newState2.materials[Solution1.Material.OBSIDIAN]);
		Assert.equals(1, newState2.materials[Solution1.Material.GEODE]);
		Assert.equals(20, newState2.time);
	}

	function testStateBuildRobot1() {
		var robots = [
			Solution1.Material.ORE => 2,
			Solution1.Material.CLAY => 1,
			Solution1.Material.OBSIDIAN => 0,
			Solution1.Material.GEODE => 1,
		];
		var materials = [
			Solution1.Material.ORE => 1,
			Solution1.Material.CLAY => 0,
			Solution1.Material.OBSIDIAN => 1,
			Solution1.Material.GEODE => 0,
		];
		var state = new Solution1.State(robots, materials, 10);
		var blueprint = new Solution1.Blueprint([3, 0, 0], [4, 0, 0], [2, 4, 0], [5, 0, 2]);

		var newState = state.buildRobot(blueprint, Solution1.Material.ORE);
		Assert.equals(3, newState.robots[Solution1.Material.ORE]);
		Assert.equals(2, newState.materials[Solution1.Material.ORE]);
		Assert.equals(12, newState.time);
		var newState = state.buildRobot(blueprint, Solution1.Material.CLAY);
		Assert.equals(2, newState.robots[Solution1.Material.ORE]);
		Assert.equals(2, newState.robots[Solution1.Material.CLAY]);
		Assert.equals(3, newState.materials[Solution1.Material.ORE]);
		Assert.equals(13, newState.time);
		newState = state.buildRobot(blueprint, Solution1.Material.OBSIDIAN);
		Assert.equals(1, newState.robots[Solution1.Material.OBSIDIAN]);
		Assert.equals(9, newState.materials[Solution1.Material.ORE]);
		Assert.equals(1, newState.materials[Solution1.Material.CLAY]);
		Assert.equals(1, newState.materials[Solution1.Material.OBSIDIAN]);
		Assert.equals(5, newState.materials[Solution1.Material.GEODE]);
		Assert.equals(15, newState.time);
		newState = state.buildRobot(blueprint, Solution1.Material.GEODE);
		Assert.isNull(newState);
	}

	function testStateBuildRobot2() {
		var robots = [
			Solution1.Material.ORE => 1,
			Solution1.Material.CLAY => 0,
			Solution1.Material.OBSIDIAN => 0,
			Solution1.Material.GEODE => 0,
		];
		var materials = [
			Solution1.Material.ORE => 0,
			Solution1.Material.CLAY => 0,
			Solution1.Material.OBSIDIAN => 0,
			Solution1.Material.GEODE => 0,
		];
		var state1 = new Solution1.State(robots, materials, 0);
		var blueprint = new Solution1.Blueprint([4, 0, 0], [2, 0, 0], [3, 14, 0], [2, 0, 7]);

		var state2 = state1.buildRobot(blueprint, Solution1.Material.CLAY);
		Assert.equals(3, state2.time);
		Assert.equals(1, state2.robots[Solution1.Material.CLAY]);
		Assert.equals(1, state2.materials[Solution1.Material.ORE]);

		var state3 = state2.buildRobot(blueprint, Solution1.Material.CLAY);
		Assert.equals(5, state3.time);
		Assert.equals(2, state3.robots[Solution1.Material.CLAY]);
		Assert.equals(1, state3.materials[Solution1.Material.ORE]);
		Assert.equals(2, state3.materials[Solution1.Material.CLAY]);

		var state4 = state3.buildRobot(blueprint, Solution1.Material.CLAY);
		Assert.equals(7, state4.time);
		Assert.equals(3, state4.robots[Solution1.Material.CLAY]);
		Assert.equals(1, state4.materials[Solution1.Material.ORE]);
		Assert.equals(6, state4.materials[Solution1.Material.CLAY]);

		var state5 = state4.buildRobot(blueprint, Solution1.Material.OBSIDIAN);
		Assert.equals(11, state5.time);
		Assert.equals(3, state5.robots[Solution1.Material.CLAY]);
		Assert.equals(1, state5.robots[Solution1.Material.OBSIDIAN]);
		Assert.equals(2, state5.materials[Solution1.Material.ORE]);
		Assert.equals(4, state5.materials[Solution1.Material.CLAY]);

		var state6 = state5.buildRobot(blueprint, Solution1.Material.CLAY)
			.buildRobot(blueprint, Solution1.Material.OBSIDIAN)
			.buildRobot(blueprint, Solution1.Material.GEODE);
		Assert.equals(18, state6.time);
		Assert.equals(4, state6.robots[Solution1.Material.CLAY]);
		Assert.equals(2, state6.robots[Solution1.Material.OBSIDIAN]);
		Assert.equals(1, state6.robots[Solution1.Material.GEODE]);
		Assert.equals(2, state6.materials[Solution1.Material.ORE]);
		Assert.equals(17, state6.materials[Solution1.Material.CLAY]);
		Assert.equals(3, state6.materials[Solution1.Material.OBSIDIAN]);

		var state7 = state6.buildRobot(blueprint, Solution1.Material.GEODE);
		Assert.equals(21, state7.time);
		Assert.equals(4, state7.robots[Solution1.Material.CLAY]);
		Assert.equals(2, state7.robots[Solution1.Material.OBSIDIAN]);
		Assert.equals(2, state7.robots[Solution1.Material.GEODE]);
		Assert.equals(3, state7.materials[Solution1.Material.ORE]);
		Assert.equals(29, state7.materials[Solution1.Material.CLAY]);
		Assert.equals(2, state7.materials[Solution1.Material.OBSIDIAN]);
		Assert.equals(3, state7.materials[Solution1.Material.GEODE]);

		var score = state7.materials[Solution1.Material.GEODE] + (24 - state7.time) * state7.robots[Solution1.Material.GEODE];
		Assert.equals(9, score);
	}
}

function main() {
	utest.UTest.run([new Test()]);
}
