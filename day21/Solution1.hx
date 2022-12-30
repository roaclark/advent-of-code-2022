package;

typedef Monkey = {
	val:Float,
	eq:(a:Float, b:Float) -> Float,
	monkeyA:String,
	monkeyB:String,
};

class Solution1 {
	static public function getEquation(operand:String):(a:Float, b:Float) -> Float {
		switch (operand) {
			case "+":
				return (a, b) -> a + b;
			case "-":
				return (a, b) -> a - b;
			case "*":
				return (a, b) -> a * b;
			case "/":
				return (a, b) -> a / b;
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
				eq: getEquation(job.charAt(5)),
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
		if (monkey.val == null) {
			monkey.val = monkey.eq(solveMonkey(monkeyMap, monkey.monkeyA), solveMonkey(monkeyMap, monkey.monkeyB));
		}
		return monkey.val;
	}

	static public function solve(input:String):Float {
		var monkeyMap:Map<String, Monkey> = [
			for (line in input.split("\n"))
				line.substr(0, 4) => makeMonkey(line)
		];
		return solveMonkey(monkeyMap, "root");
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
