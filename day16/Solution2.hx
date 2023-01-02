package;

using Lambda;

import haxe.ds.Map;

class Solution2 {
	static public function allCombos(v):Array<Array<Bool>> {
		if (v == 0) {
			return [[]];
		}
		var prevCombos = allCombos(v - 1);
		var combos = [];
		for (combo in prevCombos) {
			combos.push(combo.concat([true]));
			combos.push(combo.concat([false]));
		}
		return combos;
	}

	static public function solveCombo(combo, valves, distances):Int {
		var filteredValves:Array<Solution1.Valve> = [];
		for (i in 0...combo.length) {
			if (combo[i]) {
				filteredValves.push(valves[i]);
			}
		}
		return Solution1.maximizePressure(filteredValves, distances, 26);
	}

	static public function solve(input:String):Int {
		var valves = Solution1.parseValves(input);
		var distances:Map<String, Map<String, Int>> = Solution1.getAllValveDistances(valves);
		var valveTargets:Array<Solution1.Valve> = valves.filter(v -> v.rate > 0);

		var cache:Map<String, Int> = [];
		var bestScore = 0;
		for (combo in allCombos(valveTargets.length)) {
			var res = solveCombo(combo, valveTargets, distances);
			cache[combo.join(",")] = res;

			var rev:String = combo.map(v -> !v).join(",");
			if (cache.exists(rev)) {
				var score = cache[rev] + res;
				if (score > bestScore) {
					bestScore = score;
				}
			}
		}
		return bestScore;
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
