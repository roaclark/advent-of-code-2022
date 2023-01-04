package;

import haxe.DynamicAccess;

using Lambda;

class Monkey {
	public var items:Array<Float> = [];
	public var testDiv:Int;

	var oper:Float->Float = null;
	var trueThrow:Int;
	var falseThrow:Int;

	public function new(items, oper, testDiv, trueThrow, falseThrow) {
		this.items = items;
		this.oper = oper;
		this.testDiv = testDiv;
		this.trueThrow = trueThrow;
		this.falseThrow = falseThrow;
	}

	public function inspectAndThrow(modulo:Float) {
		var item = items.shift();
		item = oper(item) % modulo;
		var nextMonkey = item % testDiv == 0 ? trueThrow : falseThrow;
		return {
			item: item,
			nextMonkey: nextMonkey
		};
	}
}

class Solution2 {
	static public function getLeastCommonMultiplePair(a:Int, b:Int):Int {
		var aa = a;
		var bb = b;
		while (bb != 0) {
			var t = bb;
			bb = aa % bb;
			aa = t;
		}

		var gcd = aa;
		return Math.floor(a * b / gcd);
	}

	static public function getLeastCommonMultiple(vals:Array<Int>):Int {
		return vals.fold((v, r) -> {
			return getLeastCommonMultiplePair(v, r);
		}, 1);
	}

	static public function simulateRounds(monkeys:Array<Monkey>, rounds = 1):DynamicAccess<Float> {
		var modulo = getLeastCommonMultiple(monkeys.map(m -> m.testDiv));
		var inspectCounts:DynamicAccess<Float> = {};
		for (i in 0...monkeys.length) {
			inspectCounts['${i}'] = 0.0;
		}

		for (_ in 0...rounds) {
			for (monkeyI in 0...monkeys.length) {
				var monkey = monkeys[monkeyI];
				while (monkey.items.length > 0) {
					inspectCounts['${monkeyI}'] += 1;
					var throwResults = monkey.inspectAndThrow(modulo);
					monkeys[throwResults.nextMonkey].items.push(throwResults.item);
				}
			}
		}

		return inspectCounts;
	}

	static public function parseOperation(input:String):Float->Float {
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
		var items = lines[1].substr(18).split(", ").map(v -> Std.parseFloat(v));
		var oper = parseOperation(lines[2]);
		var testDiv = Std.parseInt(lines[3].substr(21));
		var trueThrow = Std.parseInt(lines[4].substr(29));
		var falseThrow = Std.parseInt(lines[5].substr(30));
		return new Monkey(items, oper, testDiv, trueThrow, falseThrow);
	}

	static public function parseMonkeys(input:String):Array<Monkey> {
		return input.split("\n\n").map(parseMonkey);
	}

	static public function solve(input:String):Float {
		var monkeys = parseMonkeys(input);
		var inspectCount = simulateRounds(monkeys, 10000);

		var values:Array<Float> = inspectCount.keys().map(k -> inspectCount[k]);
		values.sort((a, b) -> {
			if (b > a) {
				return 1;
			} else if (b < a) {
				return -1;
			}
			return 0;
		});
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
