package;

using Lambda;

class Solution1 {
	static public function mapPath(input:String):Array<Array<Int>> {
		var path:Array<Array<Int>> = [];
		var coords = input.split(" -> ");
		for (i in 0...coords.length - 1) {
			var coordA:Array<Int> = coords[i].split(",").map(v -> Std.parseInt(v));
			var coordB:Array<Int> = coords[i + 1].split(",").map(v -> Std.parseInt(v));
			if (coordA[0] == coordB[0]) {
				var start = Std.int(Math.min(coordA[1], coordB[1]));
				var end = Std.int(Math.max(coordA[1], coordB[1])) + 1;
				for (y in start...end) {
					path.push([coordA[0], y]);
				}
			} else {
				var start = Std.int(Math.min(coordA[0], coordB[0]));
				var end = Std.int(Math.max(coordA[0], coordB[0])) + 1;
				for (x in start...end) {
					path.push([x, coordA[1]]);
				}
			}
		}
		return path;
	}

	static public function buildMap(input:String):{map:Map<String, Bool>, lowest:Int, sandStart:Int} {
		var map:Map<String, Bool> = [];
		var lowest:Int = null;
		var sandStart:Int = null;
		for (s in input.split("\n")) {
			for (coord in mapPath(s)) {
				if (coord[0] == 500) {
					sandStart = sandStart == null ? coord[1] - 1 : Std.int(Math.min(sandStart, coord[1] - 1));
				}
				lowest = lowest == null ? coord[1] : Std.int(Math.max(lowest, coord[1]));
				map['${coord[0]},${coord[1]}'] = true;
			}
		}
		return {
			map: map,
			lowest: lowest,
			sandStart: sandStart,
		};
	}

	static public function simulateSand(map:Map<String, Bool>, lowest:Int, sandStart:Int) {
		var moving = true;
		var sand = [500, sandStart];
		while (moving) {
			if (!map.exists('${sand[0]},${sand[1] + 1}')) {
				sand = [sand[0], sand[1] + 1];
			} else if (!map.exists('${sand[0] - 1},${sand[1] + 1}')) {
				sand = [sand[0] - 1, sand[1] + 1];
			} else if (!map.exists('${sand[0] + 1},${sand[1] + 1}')) {
				sand = [sand[0] + 1, sand[1] + 1];
			} else {
				moving = false;
			}

			if (sand[1] > lowest) {
				return {
					map: map,
					sandStart: sandStart,
					settled: false,
				};
			}
		}

		map['${sand[0]},${sand[1]}'] = true;

		return {
			map: map,
			sandStart: sand[1] == sandStart ? sandStart - 1 : sandStart,
			settled: true,
		};
	}

	static public function solve(input:String) {
		var mapData = buildMap(input);
		var sandStart = mapData.sandStart;
		var sandCount = 0;
		var moving = true;
		while (moving) {
			var simData = simulateSand(mapData.map, mapData.lowest, sandStart);
			sandStart = simData.sandStart;
			if (simData.settled) {
				sandCount += 1;
			} else {
				moving = false;
			}
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
