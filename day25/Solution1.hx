package;

using Lambda;

class Solution1 {
	static public function convertToDecimal(snafu:String):Float {
		var place:Float = 1;
		var val:Float = 0;
		var digits = snafu.split("");
		digits.reverse();
		for (d in digits) {
			switch d {
				case "2":
					val += place * 2;
				case "1":
					val += place * 1;
				case "0":
					val += place * 0;
				case "-":
					val += place * -1;
				case "=":
					val += place * -2;
				default:
					throw('Unexpected digit: $d');
			}
			place *= 5.0;
		}
		return val;
	}

	static public function convertToSnafu(val:Float):String {
		if (val == 0) {
			return "0";
		}
		var resultDigits:Array<String> = [];
		while (val > 0) {
			var digit = val % 5;
			switch digit {
				case 0:
					resultDigits.push("0");
				case 1:
					resultDigits.push("1");
				case 2:
					resultDigits.push("2");
				case 3:
					resultDigits.push("=");
					digit = -2;
				case 4:
					resultDigits.push("-");
					digit = -1;
			}
			val = (val - digit) / 5;
			// Equivalent of floor since Math.floor is unspecified for large numbers
			val = val - val % 1;
		}
		resultDigits.reverse();
		return resultDigits.join("");
	}

	static public function solve(input:String):String {
		var values = input.split("\n").map(convertToDecimal);
		var total = values.fold((a, b) -> a + b, 0);
		return convertToSnafu(total);
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
