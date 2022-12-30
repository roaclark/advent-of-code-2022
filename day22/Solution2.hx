package;

typedef FullState = {faceIndex:Int, position:Solution1.Position, facing:Solution1.Direction}
typedef PointTranslation = (Solution1.Position) -> FullState
typedef FaceTranslations = Map<Solution1.Direction, PointTranslation>

typedef CubeSide = {
	map:Map<String, Bool>,
	translations:FaceTranslations,
	position:Solution1.Position,
}

class Solution2 {
	static var TEST_SIZE = 4;
	static var FULL_SIZE = 50;

	static public function convertToGlobal(sides:Array<CubeSide>, state:FullState):Solution1.Position {
		return {
			row: state.position.row + sides[state.faceIndex].position.row,
			col: state.position.col + sides[state.faceIndex].position.col,
		}
	}

	static public function parseCubeSide(input:String, start:Solution1.Position, size:Int, translations:FaceTranslations):CubeSide {
		var lines = input.split("\n");
		var map:Map<String, Bool> = [];
		for (r in 0...size) {
			var row = lines[r + start.row];
			for (c in 0...size) {
				var ch = row.charAt(c + start.col);
				map['$r,$c'] = ch == '.';
			}
		}
		return {
			map: map,
			translations: translations,
			position: start,
		}
	}

	static public function parseCubeSides(input:String, test:Bool):Array<CubeSide> {
		if (test) {
			//   0
			// 123
			//   45
			return [
				parseCubeSide(input, {row: 0, col: TEST_SIZE * 2}, TEST_SIZE, [
					NORTH => (pos) -> {position: {row: 0, col: TEST_SIZE - pos.col - 1}, facing: SOUTH, faceIndex: 1},
					EAST => (pos) -> {position: {row: TEST_SIZE - pos.row - 1, col: TEST_SIZE - 1}, facing: WEST, faceIndex: 5},
					SOUTH => (pos) -> {position: {row: 0, col: pos.col}, facing: SOUTH, faceIndex: 3},
					WEST => (pos) -> {position: {row: 0, col: pos.row}, facing: SOUTH, faceIndex: 2},
				]),
				parseCubeSide(input, {row: TEST_SIZE, col: 0}, TEST_SIZE, [
					NORTH => (pos) -> {position: {row: 0, col: TEST_SIZE - pos.col - 1}, facing: SOUTH, faceIndex: 0},
					EAST => (pos) -> {position: {row: pos.row, col: 0}, facing: EAST, faceIndex: 2},
					SOUTH => (pos) -> {position: {row: TEST_SIZE - 1, col: TEST_SIZE - pos.col - 1}, facing: NORTH, faceIndex: 4},
					WEST => (pos) -> {position: {row: TEST_SIZE - 1 - pos.col, col: TEST_SIZE - 1}, facing: NORTH, faceIndex: 5},
				]),
				parseCubeSide(input, {row: TEST_SIZE, col: TEST_SIZE}, TEST_SIZE, [
					NORTH => (pos) -> {position: {row: pos.col, col: 0}, facing: EAST, faceIndex: 0},
					EAST => (pos) -> {position: {row: pos.row, col: 0}, facing: EAST, faceIndex: 3},
					SOUTH => (pos) -> {position: {row: pos.row, col: TEST_SIZE - 1}, facing: EAST, faceIndex: 4},
					WEST => (pos) -> {position: {row: TEST_SIZE - pos.col - 1, col: 0}, facing: WEST, faceIndex: 1},
				]),
				parseCubeSide(input, {row: TEST_SIZE, col: TEST_SIZE * 2}, TEST_SIZE, [
					NORTH => (pos) -> {position: {row: TEST_SIZE - 1, col: pos.col}, facing: NORTH, faceIndex: 0},
					EAST => (pos) -> {position: {row: 0, col: TEST_SIZE - pos.row - 1}, facing: SOUTH, faceIndex: 5},
					SOUTH => (pos) -> {position: {row: 0, col: pos.col}, facing: SOUTH, faceIndex: 4},
					WEST => (pos) -> {position: {row: pos.row, col: TEST_SIZE - 1}, facing: WEST, faceIndex: 2},
				]),
				parseCubeSide(input, {row: TEST_SIZE * 2, col: TEST_SIZE * 2}, TEST_SIZE, [
					NORTH => (pos) -> {position: {row: TEST_SIZE - 1, col: pos.col}, facing: NORTH, faceIndex: 3},
					EAST => (pos) -> {position: {row: pos.row, col: 0}, facing: EAST, faceIndex: 5},
					SOUTH => (pos) -> {position: {row: TEST_SIZE - 1, col: TEST_SIZE - pos.col - 1}, facing: NORTH, faceIndex: 1},
					WEST => (pos) -> {position: {row: TEST_SIZE - 1, col: TEST_SIZE - pos.row - 1}, facing: NORTH, faceIndex: 2},
				]),
				parseCubeSide(input, {row: TEST_SIZE * 2, col: TEST_SIZE * 3}, TEST_SIZE, [
					NORTH => (pos) -> {position: {row: TEST_SIZE - pos.col - 1, col: TEST_SIZE - 1}, facing: WEST, faceIndex: 3},
					EAST => (pos) -> {position: {row: TEST_SIZE - pos.row - 1, col: TEST_SIZE - 1}, facing: WEST, faceIndex: 0},
					SOUTH => (pos) -> {position: {row: TEST_SIZE - pos.col - 1, col: 0}, facing: EAST, faceIndex: 1},
					WEST => (pos) -> {position: {row: pos.row, col: TEST_SIZE - 1}, facing: WEST, faceIndex: 4},
				]),
			];
		} else {
			//  01
			//  2
			// 34
			// 5
			return [
				parseCubeSide(input, {row: 0, col: FULL_SIZE}, FULL_SIZE, [
					NORTH => (pos) -> {position: {row: pos.col, col: 0}, facing: EAST, faceIndex: 5},
					EAST => (pos) -> {position: {row: pos.row, col: 0}, facing: EAST, faceIndex: 1},
					SOUTH => (pos) -> {position: {row: 0, col: pos.col}, facing: SOUTH, faceIndex: 2},
					WEST => (pos) -> {position: {row: FULL_SIZE - pos.row - 1, col: 0}, facing: EAST, faceIndex: 3},
				]),
				parseCubeSide(input, {row: 0, col: FULL_SIZE * 2}, FULL_SIZE, [
					NORTH => (pos) -> {position: {row: FULL_SIZE - 1, col: pos.col}, facing: NORTH, faceIndex: 5},
					EAST => (pos) -> {position: {row: FULL_SIZE - pos.row - 1, col: FULL_SIZE - 1}, facing: WEST, faceIndex: 4},
					SOUTH => (pos) -> {position: {row: pos.col, col: FULL_SIZE - 1}, facing: WEST, faceIndex: 2},
					WEST => (pos) -> {position: {row: pos.row, col: FULL_SIZE - 1}, facing: WEST, faceIndex: 0},
				]),
				parseCubeSide(input, {row: FULL_SIZE, col: FULL_SIZE}, FULL_SIZE, [
					NORTH => (pos) -> {position: {row: FULL_SIZE - 1, col: pos.col}, facing: NORTH, faceIndex: 0},
					EAST => (pos) -> {position: {row: FULL_SIZE - 1, col: pos.row}, facing: NORTH, faceIndex: 1},
					SOUTH => (pos) -> {position: {row: 0, col: pos.col}, facing: SOUTH, faceIndex: 4},
					WEST => (pos) -> {position: {row: 0, col: pos.row}, facing: SOUTH, faceIndex: 3},
				]),
				parseCubeSide(input, {row: FULL_SIZE * 2, col: 0}, FULL_SIZE, [
					NORTH => (pos) -> {position: {row: pos.col, col: 0}, facing: EAST, faceIndex: 2},
					EAST => (pos) -> {position: {row: pos.row, col: 0}, facing: EAST, faceIndex: 4},
					SOUTH => (pos) -> {position: {row: 0, col: pos.col}, facing: SOUTH, faceIndex: 5},
					WEST => (pos) -> {position: {row: FULL_SIZE - pos.row - 1, col: 0}, facing: EAST, faceIndex: 0},
				]),
				parseCubeSide(input, {row: FULL_SIZE * 2, col: FULL_SIZE}, FULL_SIZE, [
					NORTH => (pos) -> {position: {row: FULL_SIZE - 1, col: pos.col}, facing: NORTH, faceIndex: 2},
					EAST => (pos) -> {position: {row: FULL_SIZE - pos.row - 1, col: FULL_SIZE - 1}, facing: WEST, faceIndex: 1},
					SOUTH => (pos) -> {position: {row: pos.col, col: FULL_SIZE - 1}, facing: WEST, faceIndex: 5},
					WEST => (pos) -> {position: {row: pos.row, col: FULL_SIZE - 1}, facing: WEST, faceIndex: 3},
				]),
				parseCubeSide(input, {row: FULL_SIZE * 3, col: 0}, FULL_SIZE, [
					NORTH => (pos) -> {position: {row: FULL_SIZE - 1, col: pos.col}, facing: NORTH, faceIndex: 3},
					EAST => (pos) -> {position: {row: FULL_SIZE - 1, col: pos.row}, facing: NORTH, faceIndex: 4},
					SOUTH => (pos) -> {position: {row: 0, col: pos.col}, facing: SOUTH, faceIndex: 1},
					WEST => (pos) -> {position: {row: 0, col: pos.row}, facing: SOUTH, faceIndex: 0},
				]),
			];
		}
	}

	static public function parseInput(input:String, test:Bool):{
		sides:Array<CubeSide>,
		directions:Array<String>,
	} {
		var parts = input.split("\n\n");

		return {
			sides: parseCubeSides(parts[0], test),
			directions: Solution1.parseDirections(parts[1]),
		}
	}

	static public function moveForward(sides:Array<CubeSide>, state:FullState, dist:Int):FullState {
		for (_ in 0...dist) {
			var nextPos = Solution1.stepDirection(state.position, state.facing);
			var nextState = {position: nextPos, faceIndex: state.faceIndex, facing: state.facing};
			if (!sides[state.faceIndex].map.exists('${nextPos.row},${nextPos.col}')) {
				nextState = sides[state.faceIndex].translations[state.facing](state.position);
			}
			if (sides[nextState.faceIndex].map['${nextState.position.row},${nextState.position.col}']) {
				state = nextState;
			} else {
				return state;
			}
		}
		return state;
	}

	static public function traverse(sides:Array<CubeSide>, directions:Array<String>):FullState {
		var state:FullState = {
			position: {row: 0, col: 0},
			faceIndex: 0,
			facing: EAST,
		}
		for (dir in directions) {
			var dist = Std.parseInt(dir);
			if (dist == null) {
				state.facing = Solution1.changeDirection(state.facing, dir);
			} else {
				state = moveForward(sides, state, dist);
			}
		}
		return state;
	}

	static public function solve(input:String, test:Bool = false) {
		var parts = parseInput(input, test);
		var finalState = traverse(parts.sides, parts.directions);
		var globalPosition = convertToGlobal(parts.sides, finalState);
		return 1000 * (globalPosition.row + 1) + 4 * (globalPosition.col + 1) + Solution1.scoreDirection(finalState.facing);
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
