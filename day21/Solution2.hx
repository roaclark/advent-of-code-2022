package;

typedef Equations = {
	calcTarget:(a:Float, b:Float) -> Float,
	calcA:(tar:Float, b:Float) -> Float,
	calcB:(tar:Float, a:Float) -> Float,
}

typedef Monkey = {
	val:Float,
	eq:Equations,
	monkeyA:String,
	monkeyB:String,
};

class Solution2 {
	static public function getEquations(operand:String):Equations {
		switch (operand) {
			case "+":
				return {
					calcTarget: (a, b) -> a + b,
					calcA: (target, b) -> target - b,
					calcB: (target, a) -> target - a,
				};
			case "-":
				return {
					calcTarget: (a, b) -> a - b,
					calcA: (target, b) -> target + b,
					calcB: (target, a) -> a - target,
				};
			case "*":
				return {
					calcTarget: (a, b) -> a * b,
					calcA: (target, b) -> target / b,
					calcB: (target, a) -> target / a,
				};
			case "/":
				return {
					calcTarget: (a, b) -> a / b,
					calcA: (target, b) -> target * b,
					calcB: (a, target) -> a / target,
				};
			default:
				throw('Unexpected operand: $operand');
		}
	}

	static public function makeMonkey(input:String):Monkey {
		var job = input.substr(6);
		var val = Std.parseInt(job);
		if (val == null) {
			return {
				val: null,
				eq: getEquations(job.charAt(5)),
				monkeyA: job.substr(0, 4),
				monkeyB: job.substr(7),
			}
		}
		return {
			val: val,
			eq: null,
			monkeyA: null,
			monkeyB: null,
		}
	}

	static public function solveMonkey(monkeyMap:Map<String, Monkey>, monkeyName:String):Float {
		var monkey = monkeyMap[monkeyName];
		if (monkey.val == null && monkey.eq != null) {
			var valA = solveMonkey(monkeyMap, monkey.monkeyA);
			var valB = solveMonkey(monkeyMap, monkey.monkeyB);
			if (valA == null || valB == null) {
				return null;
			}
			monkey.val = monkey.eq.calcTarget(valA, valB);
		}
		return monkey.val;
	}

	static public function reverseCalc(monkeyMap:Map<String, Monkey>, start:String, targetVal:Float, goal:String):Float {
		if (start == goal) {
			return targetVal;
		}
		var monkey:Monkey = monkeyMap[start];
		var aVal = monkeyMap[monkey.monkeyA].val;
		var bVal = monkeyMap[monkey.monkeyB].val;
		if (aVal == null) {
			var aTarget = monkey.eq.calcA(targetVal, bVal);
			return reverseCalc(monkeyMap, monkey.monkeyA, aTarget, goal);
		}
		if (bVal == null) {
			var bTarget = monkey.eq.calcB(targetVal, aVal);
			return reverseCalc(monkeyMap, monkey.monkeyB, bTarget, goal);
		}
		throw('All needed values provided, no need for reverse calculation for monkey $start');
	}

	static public function solve(input:String):Float {
		var monkeyMap:Map<String, Monkey> = [
			for (line in input.split("\n"))
				line.substr(0, 4) => makeMonkey(line)
		];
		monkeyMap["humn"] = {
			val: null,
			eq: null,
			monkeyA: null,
			monkeyB: null,
		};
		solveMonkey(monkeyMap, "root");
		var rootMonkey = monkeyMap["root"];
		var aVal = monkeyMap[rootMonkey.monkeyA].val;
		var bVal = monkeyMap[rootMonkey.monkeyB].val;
		if (aVal == null) {
			return reverseCalc(monkeyMap, rootMonkey.monkeyA, bVal, "humn");
		}
		if (bVal == null) {
			return reverseCalc(monkeyMap, rootMonkey.monkeyB, aVal, "humn");
		}
		throw("No missing value for root");
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
