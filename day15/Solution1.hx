package;

import haxe.ds.Map;

typedef Coordinate = {x:Int, y:Int}

enum TimelinePointType {
	Start;
	End;
	Beacon;
}

typedef TimelinePoint = {val:Int, type:TimelinePointType}

class Solution1 {
	static public function parseCoord(input:String):Coordinate {
		var parts:Array<String> = input.substr(2).split(", y=");
		return {
			x: Std.parseInt(parts[0]),
			y: Std.parseInt(parts[1]),
		}
	}

	static public function parseSensor(input:String):{sensor:Coordinate, beacon:Coordinate} {
		var parts:Array<String> = input.substr(10).split(": closest beacon is at ");
		return {
			sensor: parseCoord(parts[0]),
			beacon: parseCoord(parts[1]),
		};
	}

	static public function parseSensors(input:String):Array<{sensor:Coordinate, beacon:Coordinate}> {
		return input.split("\n").map(parseSensor);
	}

	static public function getUnreachableRange(sensor, beacon, line) {
		var dist = Std.int(Math.abs(sensor.x - beacon.x)) + Std.int(Math.abs(sensor.y - beacon.y));
		var lineDist = Std.int(Math.abs(line - sensor.y));
		if (lineDist > dist) {
			return null;
		}
		var lineX = dist - lineDist;
		return [sensor.x - lineX, sensor.x + lineX];
	}

	static public function getTotalUnreachables(unreachableRanges:Array<Array<Int>>, beacons:Array<Int>):Int {
		var startPoints:Array<TimelinePoint> = unreachableRanges.map(v -> ({val: v[0], type: TimelinePointType.Start}));
		var endPoints:Array<TimelinePoint> = unreachableRanges.map(v -> ({val: v[1], type: TimelinePointType.End}));
		var beaconPoints:Array<TimelinePoint> = beacons.map(v -> ({val: v, type: TimelinePointType.Beacon}));

		var timeline:Array<TimelinePoint> = startPoints.concat(endPoints).concat(beaconPoints);
		timeline.sort((a, b) -> {
			if (a.val == b.val && a.type != b.type) {
				if (a.type == TimelinePointType.Start || b.type == TimelinePointType.End) {
					return -1;
				}
				return 1;
			}
			return a.val - b.val;
		});

		var stack = 0;
		var runStart = null;
		var total = 0;
		for (v in timeline) {
			switch v.type {
				case TimelinePointType.Start:
					stack += 1;
					if (runStart == null) {
						runStart = v.val;
					}
				case TimelinePointType.End:
					stack -= 1;
					if (stack == 0) {
						total += v.val - runStart + 1;
						runStart = null;
					}
				case TimelinePointType.Beacon:
					if (stack > 0) {
						total -= 1;
					}
			}
		}

		return total;
	}

	static public function getLineBeacons(beacons:Array<Coordinate>, line:Int):Array<Int> {
		var beaconPoints:Map<Int, Bool> = [];
		for (b in beacons) {
			if (b.y == line) {
				beaconPoints[b.x] = true;
			}
		}
		return [for (v in beaconPoints.keys()) v];
	}

	static public function solve(input:String, line:Int = 2000000):Int {
		var pairs = parseSensors(input);
		var unreachableRanges = pairs.map(v -> getUnreachableRange(v.sensor, v.beacon, line)).filter(v -> v != null);
		var lineBeacons = getLineBeacons(pairs.map(v -> v.beacon), line);
		return getTotalUnreachables(unreachableRanges, lineBeacons);
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
