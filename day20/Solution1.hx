package;

typedef Node = {
	next:Node,
	prev:Node,
	val:Float,
}

class Solution1 {
	static public function convertToArray(head:Node, length:Int):Array<Float> {
		var newSeq:Array<Float> = [];
		var curr = head;
		for (_ in 0...length) {
			newSeq.push(curr.val);
			curr = curr.next;
		}
		return newSeq;
	}

	static public function decrypt(seq:Array<Float>, loops = 1):Array<Float> {
		var nodes:Array<Node> = [for (v in seq) {next: null, prev: null, val: v}];
		var head = null;
		for (i in 0...nodes.length) {
			if (nodes[i].val == 0) {
				head = nodes[i];
			}
			nodes[i].next = nodes[(i + 1) % nodes.length];
			nodes[i].prev = nodes[i == 0 ? nodes.length - 1 : i - 1];
		}
		for (_ in 0...loops) {
			for (node in nodes) {
				for (_ in 0...Std.int(Math.abs(node.val) % (seq.length - 1))) {
					if (node.val > 0) {
						node.prev.next = node.next;
						node.next.prev = node.prev;
						node.prev = node.next;
						node.next = node.next.next;
						node.next.prev = node;
						node.prev.next = node;
					} else {
						node.prev.next = node.next;
						node.next.prev = node.prev;
						node.next = node.prev;
						node.prev = node.prev.prev;
						node.next.prev = node;
						node.prev.next = node;
					}
				}
			}
		}
		return convertToArray(head, seq.length);
	}

	static public function solve(input:String):Float {
		var seq = input.split("\n").map(Std.parseFloat);
		seq = decrypt(seq);
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
