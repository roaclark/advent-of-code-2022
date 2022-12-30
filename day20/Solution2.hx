package;

class Solution2 {
	static public function solve(input:String):Float {
		var seq = input.split("\n").map(v -> Std.parseFloat(v) * 811589153);
		seq = Solution1.decrypt(seq, 10);
		return seq[1000 % seq.length] + seq[2000 % seq.length] + seq[3000 % seq.length];
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
