package;

typedef Position = {
	row:Int,
	col:Int,
}

typedef MapData = {
	map:Map<String, Bool>,
	rowEdgeTranslations:Map<String, Position>,
	colEdgeTranslations:Map<String, Position>,
	start:Position,
}

enum Direction {
	NORTH;
	EAST;
	SOUTH;
	WEST;
}

class Solution1 {
	static public function scoreDirection(dir:Direction):Int {
		switch dir {
			case NORTH:
				return 3;
			case EAST:
				return 0;
			case SOUTH:
				return 1;
			case WEST:
				return 2;
		};
	}

	static public function parseDirections(input:String):Array<String> {
		var turnReg = ~/R|L/g;
		var distReg = ~/\d+/g;
		var dists = turnReg.split(input);
		var turns = distReg.split(input);

		var directions = [];
		for (i in 0...dists.length - 1) {
			directions.push(dists[i]);
			directions.push(turns[i + 1]);
		}
		directions.push(dists[dists.length - 1]);
		return directions;
	}

	static public function parseMapData(input:String):MapData {
		var map:Map<String, Bool> = [];
		var rowEdgeTranslations:Map<String, Position> = [];
		var colEdgeTranslations:Map<String, Position> = [];

		var lines = input.split("\n");
		var firstRowForCol:Map<Int, Int> = [];
		var lastRowForCol:Map<Int, Int> = [];
		var topLeftCol = null;
		for (row in 1...lines.length + 1) {
			var chars = lines[row - 1].split("");
			var firstCol = null;
			var lastCol = null;
			for (col in 1...chars.length + 1) {
				if (chars[col - 1] != " ") {
					map['$row,$col'] = chars[col - 1] == ".";
					if (firstCol == null) {
						firstCol = col;
						if (row == 1) {
							topLeftCol = col;
						}
					}
					lastCol = col;
					if (!firstRowForCol.exists(col)) {
						firstRowForCol[col] = row;
					}
					lastRowForCol[col] = row;
				}
			}
			rowEdgeTranslations['$row,${firstCol - 1}'] = {row: row, col: lastCol};
			rowEdgeTranslations['$row,${lastCol + 1}'] = {row: row, col: firstCol};
		}
		for (col in firstRowForCol.keys()) {
			var firstRow = firstRowForCol[col];
			var lastRow = lastRowForCol[col];
			colEdgeTranslations['${firstRow - 1},$col'] = {row: lastRow, col: col};
			colEdgeTranslations['${lastRow + 1},$col'] = {row: firstRow, col: col};
		}
		return {
			map: map,
			rowEdgeTranslations: rowEdgeTranslations,
			colEdgeTranslations: colEdgeTranslations,
			start: {row: 1, col: topLeftCol},
		}
	}

	static public function changeDirection(facing:Direction, dir:String):Direction {
		switch (dir) {
			case "R":
				switch (facing) {
					case NORTH:
						return EAST;
					case EAST:
						return SOUTH;
					case SOUTH:
						return WEST;
					case WEST:
						return NORTH;
				}
			case "L":
				switch (facing) {
					case NORTH:
						return WEST;
					case EAST:
						return NORTH;
					case SOUTH:
						return EAST;
					case WEST:
						return SOUTH;
				}
			default:
				throw('Invalid rotate direction: $dir');
		}
	}

	static public function stepDirection(pos:Position, dir:Direction):Position {
		switch dir {
			case NORTH:
				return {row: pos.row - 1, col: pos.col};
			case EAST:
				return {row: pos.row, col: pos.col + 1};
			case SOUTH:
				return {row: pos.row + 1, col: pos.col};
			case WEST:
				return {row: pos.row, col: pos.col - 1};
		}
	}

	static public function moveForward(mapData:MapData, pos:Position, facing:Direction, dist:Int):Position {
		for (_ in 0...dist) {
			var nextPos = stepDirection(pos, facing);
			var nextPosStr = '${nextPos.row},${nextPos.col}';
			if (!mapData.map.exists(nextPosStr)) {
				var translations = (facing == NORTH || facing == SOUTH) ? mapData.colEdgeTranslations : mapData.rowEdgeTranslations;
				nextPos = translations[nextPosStr];
				nextPosStr = '${nextPos.row},${nextPos.col}';
			}
			if (mapData.map[nextPosStr]) {
				pos = nextPos;
			} else {
				return pos;
			}
		}
		return pos;
	}

	static public function traverse(mapData:MapData, directions:Array<String>) {
		var pos = mapData.start;
		var facing = EAST;
		for (dir in directions) {
			var dist = Std.parseInt(dir);
			if (dist == null) {
				facing = changeDirection(facing, dir);
			} else {
				pos = moveForward(mapData, pos, facing, dist);
			}
		}
		return {
			position: pos,
			facing: facing,
		}
	}

	static public function parseInput(input:String):{mapData:MapData, directions:Array<String>} {
		var parts = input.split("\n\n");
		return {
			mapData: parseMapData(parts[0]),
			directions: parseDirections(parts[1]),
		}
	}

	static public function solve(input:String):Int {
		var inputData = parseInput(input);
		var finalLoc = traverse(inputData.mapData, inputData.directions);
		return 1000 * finalLoc.position.row + 4 * finalLoc.position.col + scoreDirection(finalLoc.facing);
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
