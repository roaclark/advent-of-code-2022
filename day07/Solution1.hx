package;

import haxe.DynamicAccess;

class Node {
	public var parent:Node;
	public var name:String;
	public var dirs:DynamicAccess<Node>;
	public var files:DynamicAccess<Int>;

	public function new(parent:Node, name:String) {
		this.parent = parent;
		this.name = name;
		this.dirs = {};
		this.files = {};
	}
}

class Solution1 {
	static public function buildTree(inputLines:Array<String>):Node {
		var root:Node = new Node(null, '/');

		var curr:Node = null;
		var i = 0;
		while (i < inputLines.length) {
			var line:Array<String> = inputLines[i].split(" ");
			if (line[0] != '$') {
				throw 'Unexpected non-command line: ${inputLines[i]}';
			} else if (line[1] == 'cd') {
				if (line[2] == '/') {
					curr = root;
				} else if (line[2] == '..') {
					curr = curr.parent;
				} else {
					curr = curr.dirs[line[2]];
				}
			} else if (line[1] == 'ls') {
				i += 1;
				while (i < inputLines.length && inputLines[i].substr(0, 1) != '$') {
					var lsEntry = inputLines[i].split(" ");
					if (lsEntry[0] == 'dir') {
						curr.dirs[lsEntry[1]] = new Node(curr, lsEntry[1]);
					} else {
						curr.files[lsEntry[1]] = Std.parseInt(lsEntry[0]);
					}
					i += 1;
				}
				i -= 1;
			} else {
				throw 'Unrecognized command:: ${inputLines[i]}';
			}
			i += 1;
		}
		return root;
	}

	static public function getDirectorySize(root:Node):Int {
		var size = 0;
		var fileIter = root.files.iterator();
		while (fileIter.hasNext()) {
			size += fileIter.next();
		}
		var dirIter = root.dirs.iterator();
		while (dirIter.hasNext()) {
			size += getDirectorySize(dirIter.next());
		}
		return size;
	}

	static public function sumDirectorySizes(root:Node, max:Int):Array<Int> {
		var size = 0;
		var totalSizes = 0;
		var fileIter = root.files.iterator();
		while (fileIter.hasNext()) {
			size += fileIter.next();
		}
		var dirIter = root.dirs.iterator();
		while (dirIter.hasNext()) {
			var dirRes = sumDirectorySizes(dirIter.next(), max);
			var dirSize:Int = dirRes[0];
			var dirTotalSizes:Int = dirRes[1];
			totalSizes += dirTotalSizes;
			size += dirSize;
		}
		return [size, totalSizes + (size <= max ? size : 0)];
	}

	static public function solve(input:String) {
		var fileTree = buildTree(input.split('\n'));
		return sumDirectorySizes(fileTree, 100000)[1];
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
