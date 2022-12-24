package;

class Solution1 {
	static public function isInt(str:String, ch:Int):Bool {
		return Std.parseInt(str.charAt(ch)) != null;
	}

	static public function getInt(str:String, start:Int) {
		var i = start;
		while (i < str.length && isInt(str, i)) {
			i += 1;
		}
		return {
			val: Std.parseInt(str.substring(start, i)),
			end: i,
		}
	}

	static public function isOrdered(strA, strB):Bool {
		var iA:Int = 0;
		var iB:Int = 0;
		var fakeListA = false;
		var fakeListB = false;
		while (iA < strA.length && iB < strB.length) {
			var chA = strA.charAt(iA);
			if (fakeListA && !isInt(strA, iA)) {
				chA = ']';
				iA -= 1;
				fakeListA = false;
			}
			var chB = strB.charAt(iB);
			if (fakeListB && !isInt(strB, iB)) {
				chB = ']';
				iB -= 1;
				fakeListB = false;
			}

			if (chA == chB && (chA == '[' || chA == ']' || chA == ',')) {
				iA += 1;
				iB += 1;
			} else if (isInt(strA, iA) && isInt(strB, iB)) {
				var resA = getInt(strA, iA);
				var resB = getInt(strB, iB);
				if (resA.val < resB.val) {
					return true;
				} else if (resA.val > resB.val) {
					return false;
				}
				iA = resA.end;
				iB = resB.end;
			} else if (chA == '[' && isInt(strB, iB)) {
				fakeListB = true;
				iA += 1;
			} else if (chB == '[' && isInt(strA, iA)) {
				fakeListA = true;
				iB += 1;
			} else if (chA == ']' && chB != ']') {
				return true;
			} else if (chB == ']' && chA != ']') {
				return false;
			}
		}
		return false;
	}

	static public function solve(input:String):Int {
		var pairs = input.split("\n\n");
		var result:Int = 0;
		for (i in 0...pairs.length) {
			var parts = pairs[i].split("\n");
			if (isOrdered(parts[0], parts[1])) {
				result += i + 1;
			}
		}
		return result;
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
