package;

typedef Point = {x:Float, y:Float}

typedef Piece = {
	blocks:Array<Point>,
	leftCollisions:Array<Point>,
	rightCollisions:Array<Point>,
	downCollisions:Array<Point>,
	height:Int,
}

class Solution2 {
	static var LOOPS:Float = 1000000000000;
	static var WIDTH:Int = 7;
	static var PIECES:Array<Piece> = [
		{
			blocks: [{x: 0, y: 0}, {x: 1, y: 0}, {x: 2, y: 0}, {x: 3, y: 0}],
			leftCollisions: [{x: -1, y: 0}],
			rightCollisions: [{x: 4, y: 0}],
			downCollisions: [{x: 0, y: -1}, {x: 1, y: -1}, {x: 2, y: -1}, {x: 3, y: -1}],
			height: 1,
		},
		{
			blocks: [{x: 0, y: 1}, {x: 1, y: 0}, {x: 1, y: 1}, {x: 1, y: 2}, {x: 2, y: 1}],
			leftCollisions: [{x: 0, y: 0}, {x: -1, y: 1}, {x: 0, y: 2}],
			rightCollisions: [{x: 2, y: 0}, {x: 3, y: 1}, {x: 2, y: 2}],
			downCollisions: [{x: 0, y: 0}, {x: 1, y: -1}, {x: 2, y: 0}],
			height: 3,
		},
		{
			blocks: [{x: 0, y: 0}, {x: 1, y: 0}, {x: 2, y: 0}, {x: 2, y: 1}, {x: 2, y: 2}],
			leftCollisions: [{x: -1, y: 0}, {x: 1, y: 1}, {x: 1, y: 2}],
			rightCollisions: [{x: 3, y: 0}, {x: 3, y: 1}, {x: 3, y: 2}],
			downCollisions: [{x: 0, y: -1}, {x: 1, y: -1}, {x: 2, y: -1}],
			height: 3,
		},
		{
			blocks: [{x: 0, y: 0}, {x: 0, y: 1}, {x: 0, y: 2}, {x: 0, y: 3}],
			leftCollisions: [{x: -1, y: 0}, {x: -1, y: 1}, {x: -1, y: 2}, {x: -1, y: 3}],
			rightCollisions: [{x: 1, y: 0}, {x: 1, y: 1}, {x: 1, y: 2}, {x: 1, y: 3}],
			downCollisions: [{x: 0, y: -1}],
			height: 4,
		},
		{
			blocks: [{x: 0, y: 0}, {x: 0, y: 1}, {x: 1, y: 0}, {x: 1, y: 1}],
			leftCollisions: [{x: -1, y: 0}, {x: -1, y: 1}],
			rightCollisions: [{x: 2, y: 0}, {x: 2, y: 1}],
			downCollisions: [{x: 0, y: -1}, {x: 1, y: -1}],
			height: 2,
		},
	];

	static public function addPoints(a:Point, b:Point):Point {
		return {
			x: a.x + b.x,
			y: a.y + b.y,
		}
	}

	static public function checkCollision(position:Point, colliders:Array<Point>, map:Map<String, Bool>):Bool {
		for (collPoint in colliders) {
			var target = addPoints(position, collPoint);
			if (target.x < 0 || target.x >= WIDTH || target.y <= 0) {
				return true;
			}
			if (map.exists('${target.x},${target.y}')) {
				return true;
			}
		}
		return false;
	}

	static public function visualize(map:Map<String, Bool>, height:Float):String {
		var viz = new StringBuf();
		viz.add("\n");
		var r = 0;
		while (r < height) {
			for (c in 0...WIDTH) {
				viz.add(map.exists('${c},${height - r}') ? '#' : '.');
			}
			viz.add("\n");
			r++;
		}
		return viz.toString();
	}

	static public function solve(input:String):Float {
		var winds = input.split("");
		var windI:Float = 0;
		var height:Float = 0;
		var map:Map<String, Bool> = [];
		var pieceI:Float = 0;
		var patterns:Map<String, {height:Float, pieceI:Float, windI:Float}> = [];
		var extraPatternHeight:Float = 0;
		while (pieceI < LOOPS) {
			// Ignoring the early patterns since the floor starts differently
			if (pieceI > 10000) {
				var recognizedKey = '${pieceI % PIECES.length},${windI % winds.length}';
				if (patterns.exists(recognizedKey)) {
					var prevInstance = patterns[recognizedKey];
					var pieceJump = pieceI - prevInstance.pieceI;
					var windJump = windI - prevInstance.windI;
					var heightJump = height - prevInstance.height;
					var numJumps = (LOOPS - pieceI) / pieceJump;
					numJumps = numJumps - numJumps % 1;
					pieceI += pieceJump * numJumps;
					windI += windJump * numJumps;
					extraPatternHeight += heightJump * numJumps;
				}
				patterns[recognizedKey] = {height: height, pieceI: pieceI, windI: windI};
			}
			var piece = PIECES[Std.int(pieceI % PIECES.length)];
			var position:Point = {x: 2, y: height + 4};
			var moving = true;
			while (moving) {
				var leftWind = winds[Std.int(windI % winds.length)] == '<';
				windI++;
				var movesSide = !checkCollision(position, leftWind ? piece.leftCollisions : piece.rightCollisions, map);
				if (movesSide) {
					position = addPoints(position, leftWind ? {x: -1, y: 0} : {x: 1, y: 0});
				}
				var movesDown = !checkCollision(position, piece.downCollisions, map);
				if (movesDown) {
					position = addPoints(position, {x: 0, y: -1});
				} else {
					moving = false;
				}
			}
			height = Math.max(height, position.y + piece.height - 1);
			for (block in piece.blocks) {
				var mapBlock = addPoints(position, block);
				map['${mapBlock.x},${mapBlock.y}'] = true;
			}
			pieceI++;
		}
		return height + extraPatternHeight;
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
