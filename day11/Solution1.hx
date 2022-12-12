package;

import haxe.DynamicAccess;

class Monkey {
	public var items:Array<Int> = [];

	var oper:Int->Int = null;
	var testDiv:Int;
	var trueThrow:Int;
	var falseThrow:Int;

	public function new(items, oper, testDiv, trueThrow, falseThrow) {
		this.items = items;
		this.oper = oper;
		this.testDiv = testDiv;
		this.trueThrow = trueThrow;
		this.falseThrow = falseThrow;
	}

	public function inspectAndThrow(worryDecrease = true) {
		var item = items.shift();
		item = oper(item);
		if (worryDecrease) {
			item = Math.floor(item / 3);
		}
		var nextMonkey = item % testDiv == 0 ? trueThrow : falseThrow;
		return {
			item: item,
			nextMonkey: nextMonkey
		};
	}
}

class Solution1 {
	static public function simulateRounds(monkeys:Array<Monkey>, rounds = 1, worryDecrease = true):DynamicAccess<Int> {
		var inspectCounts:DynamicAccess<Int> = {};
		for (i in 0...monkeys.length) {
			inspectCounts['${i}'] = 0;
		}

		for (_ in 0...rounds) {
			for (monkeyI in 0...monkeys.length) {
				var monkey = monkeys[monkeyI];
				while (monkey.items.length > 0) {
					inspectCounts['${monkeyI}'] += 1;
					var throwResults = monkey.inspectAndThrow(worryDecrease);
					monkeys[throwResults.nextMonkey].items.push(throwResults.item);
				}
			}
		}

		return inspectCounts;
	}

	static public function parseOperation(input:String):Int->Int {
		var eqParts = input.substr(19).split(" ");
		if (eqParts.length != 3) {
			throw 'Invalid equation, wrong number of parts: ${input}';
		}
		return (v) -> {
			var a = eqParts[0] == 'old' ? v : Std.parseInt(eqParts[0]);
			var b = eqParts[2] == 'old' ? v : Std.parseInt(eqParts[2]);
			if (eqParts[1] == '+') {
				return a + b;
			} else if (eqParts[1] == '*') {
				return a * b;
			} else {
				throw 'Invalid equation, wrong operator: ${input}';
			}
		};
	}

	static public function parseMonkey(input:String):Monkey {
		var lines = input.split("\n");
		var items = lines[1].substr(18).split(", ").map(v -> Std.parseInt(v));
		var oper = parseOperation(lines[2]);
		var testDiv = Std.parseInt(lines[3].substr(21));
		var trueThrow = Std.parseInt(lines[4].substr(29));
		var falseThrow = Std.parseInt(lines[5].substr(30));
		return new Monkey(items, oper, testDiv, trueThrow, falseThrow);
	}

	static public function parseMonkeys(input:String):Array<Monkey> {
		return input.split("\n\n").map(parseMonkey);
	}

	static public function solve(input:String) {
		var monkeys = parseMonkeys(input);
		var inspectCount = simulateRounds(monkeys, 20);

		var values:Array<Int> = inspectCount.keys().map(k -> inspectCount[k]);
		values.sort((a, b) -> b - a);
		return values[0] * values[1];
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
