package;

import haxe.DynamicAccess;

class Solution2 {
	static public function simulateSand(map:Map<String, Bool>, lowest:Int, sandStart:Int) {
		var moving = true;
		var sand = [500, sandStart];
		while (moving) {
			if (sand[1] == lowest + 1) {
				moving = false;
			} else if (!map.exists('${sand[0]},${sand[1] + 1}')) {
				sand = [sand[0], sand[1] + 1];
			} else if (!map.exists('${sand[0] - 1},${sand[1] + 1}')) {
				sand = [sand[0] - 1, sand[1] + 1];
			} else if (!map.exists('${sand[0] + 1},${sand[1] + 1}')) {
				sand = [sand[0] + 1, sand[1] + 1];
			} else {
				moving = false;
			}
		}

		map['${sand[0]},${sand[1]}'] = true;

		return {
			map: map,
			sandStart: sand[1] == sandStart ? sandStart - 1 : sandStart,
		};
	}

	static public function solve(input:String) {
		var mapData = Solution1.buildMap(input);
		var sandStart = mapData.sandStart;
		var sandCount = 0;
		var moving = true;
		while (moving) {
			var simData = simulateSand(mapData.map, mapData.lowest, sandStart);
			sandStart = simData.sandStart;
			sandCount += 1;
			moving = sandStart >= 0;
		}
		return sandCount;
	}

	static public function solveFile(filename:String = 'input.txt') {
		var fileContents = sys.io.File.getContent(filename);
		return solve(fileContents);
	}

	static public function main() {
		var solution = solveFile();
		trace(solution);
	}
}
