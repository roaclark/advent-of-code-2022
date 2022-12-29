package;

import utest.Assert;

class Test extends utest.Test {
	function testMain1() {
		Assert.equals(58, Solution2.solveFile('input_test1.txt'));
	}

	function testSteamMap1() {
		var lavaMap:Map<String, Bool> = ["1,1,1" => true, "2,1,1" => true];
		var steamMap:Map<String, Bool> = Solution2.createSteamMap(lavaMap);
		var steamMapKeys = [for (k in steamMap.keys()) k];
		Assert.equals(10646, steamMapKeys.length);
	}

	function testSteamMap2() {
		var coords:Array<String> = sys.io.File.getContent('input_test1.txt').split("\n");
		var lavaMap:Map<String, Bool> = [for (c in coords) c => true];
		var steamMap:Map<String, Bool> = Solution2.createSteamMap(lavaMap);
		var steamMapKeys = [for (k in steamMap.keys()) k];
		Assert.equals(10634, steamMapKeys.length);
	}
}

function main() {
	utest.UTest.run([new Test()]);
}
