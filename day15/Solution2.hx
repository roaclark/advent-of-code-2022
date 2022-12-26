package;

enum TimelinePointType2 {
	Start;
	End;
}

typedef TimelinePoint2 = {val:Int, type:TimelinePointType2}

class Solution2 {
	static public function getUnreachablePoint(unreachableRanges:Array<Array<Int>>, range:Int):Int {
		var startPoints:Array<TimelinePoint2> = unreachableRanges.map(v -> ({val: v[0], type: TimelinePointType2.Start}));
		var endPoints:Array<TimelinePoint2> = unreachableRanges.map(v -> ({val: v[1], type: TimelinePointType2.End}));

		var timeline:Array<TimelinePoint2> = startPoints.concat(endPoints);
		timeline.sort((a, b) -> {
			if (a.val == b.val && a.type != b.type) {
				return a.type == TimelinePointType2.Start ? -1 : 1;
			}
			return a.val - b.val;
		});

		var stack = 0;
		var potentialGap = null;
		for (v in timeline) {
			switch v.type {
				case TimelinePointType2.Start:
					stack += 1;
					if (potentialGap != null) {
						if (v.val == potentialGap) {
							potentialGap = null;
						} else {
							return potentialGap;
						}
					}
				case TimelinePointType2.End:
					stack -= 1;
					if (stack == 0 && v.val >= 0 && v.val <= range) {
						potentialGap = v.val + 1;
					}
			}
		}

		return null;
	}

	static public function solve(input:String, range:Int = 4000000):Float {
		var pairs = Solution1.parseSensors(input);
		for (row in 0...range + 1) {
			var unreachableRanges = pairs.map(v -> Solution1.getUnreachableRange(v.sensor, v.beacon, row)).filter(v -> v != null);
			var gap = getUnreachablePoint(unreachableRanges, range);
			if (gap != null) {
				return gap * 4000000.0 + row;
			}
		}
		return null;
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
