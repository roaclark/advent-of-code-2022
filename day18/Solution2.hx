package;

import haxe.io.ArrayBufferView.ArrayBufferViewImpl;

using Lambda;

class Solution2 {
	static var MAX_STEAM_COORD:Int = 20;
	static var MIN_STEAM_COORD:Int = -1;
	static var adjacentVecs:Array<Array<Int>> = [[1, 0, 0], [-1, 0, 0], [0, 1, 0], [0, -1, 0], [0, 0, 1], [0, 0, -1]];

	static public function addVec(a:Array<Int>, b:Array<Int>):Array<Int> {
		return [a[0] + b[0], a[1] + b[1], a[2] + b[2]];
	}

	static public function exposedFaces(steamMap:Map<String, Bool>, coordStr:String):Int {
		var coord = coordStr.split(",").map(v -> Std.parseInt(v));
		return adjacentVecs.fold((adj, exp) -> {
			var adjCoord:Array<Int> = addVec(coord, adj);
			if (steamMap.exists(adjCoord.join(","))) {
				return exp + 1;
			}
			return exp;
		}, 0);
	}

	static public function validSteam(lavaMap:Map<String, Bool>, coord:Array<Int>):Bool {
		if (coord[0] < MIN_STEAM_COORD || coord[0] > MAX_STEAM_COORD) {
			return false;
		}
		if (coord[1] < MIN_STEAM_COORD || coord[1] > MAX_STEAM_COORD) {
			return false;
		}
		if (coord[2] < MIN_STEAM_COORD || coord[2] > MAX_STEAM_COORD) {
			return false;
		}
		if (lavaMap.exists(coord.join(","))) {
			return false;
		}
		return true;
	}

	static public function createSteamMap(lavaMap:Map<String, Bool>):Map<String, Bool> {
		var queue:Array<Array<Int>> = [[MIN_STEAM_COORD, MIN_STEAM_COORD, MIN_STEAM_COORD]];
		var visited:Map<String, Bool> = [];
		while (queue.length > 0) {
			var curr = queue.pop();
			var currStr = curr.join(",");
			if (!visited.exists(currStr)) {
				visited[currStr] = true;
				var children = adjacentVecs.map(adj -> addVec(adj, curr));
				for (ch in children) {
					if (validSteam(lavaMap, ch)) {
						queue.push(ch);
					}
				}
			}
		}
		return visited;
	}

	static public function solve(input:String):Int {
		var coords = input.split("\n");
		var lavaMap:Map<String, Bool> = [for (c in coords) c => true];
		var steamMap = createSteamMap(lavaMap);
		return coords.fold((coord, area) -> {
			return area + exposedFaces(steamMap, coord);
		}, 0);
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
