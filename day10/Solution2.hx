package;

class Solution2 {
	static public function updateScreen(cycle:Int, register:Int, screen:StringBuf):StringBuf {
		if (cycle % 40 == 0) {
			screen.add("\n");
		}
		var col:Int = cycle - Math.floor(cycle / 40) * 40;
		if (col >= register - 1 && col <= register + 1) {
			screen.add("#");
		} else {
			screen.add(".");
		}
		return screen;
	}

	static public function solve(input:String) {
		var cycle = 0;
		var register = 1;
		var screen = new StringBuf();
		for (cmd in input.split("\n")) {
			var cmdParts = cmd.split(" ");
			updateScreen(cycle, register, screen);
			cycle += 1;
			if (cmdParts[0] == "addx") {
				updateScreen(cycle, register, screen);
				cycle += 1;
				register += Std.parseInt(cmdParts[1]);
			}
		}
		return screen.toString();
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
