package;

class Solution2 {
	static public function getMinDeletionSize(root:Solution1.Node, target:Int):Array<Int> {
		var size:Int = 0;
		var minDeletion:Int = null;

		var fileIter = root.files.iterator();
		while (fileIter.hasNext()) {
			size += fileIter.next();
		}

		var dirIter = root.dirs.iterator();
		while (dirIter.hasNext()) {
			var dirRes = getMinDeletionSize(dirIter.next(), target);
			var dirSize:Int = dirRes[0];
			var dirMinDeletion:Int = dirRes[1];
			size += dirSize;
			if (dirMinDeletion != null && (minDeletion == null || minDeletion > dirMinDeletion)) {
				minDeletion = dirMinDeletion;
			}
		}

		if (minDeletion != null) {
			return [size, minDeletion];
		} else if (size >= target) {
			return [size, size];
		} else {
			return [size, null];
		}
	}

	static public function solve(input:String):Int {
		var fileTree = Solution1.buildTree(input.split('\n'));
		var neededSpace:Int = Solution1.getDirectorySize(fileTree) - 40000000;
		return getMinDeletionSize(fileTree, neededSpace)[1];
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
