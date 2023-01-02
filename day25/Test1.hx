package;

import utest.Assert;

class Test extends utest.Test {
	function testMain1() {
		Assert.equals("2=-1=0", Solution1.solveFile('input_test1.txt'));
	}

	function testConvertToDecimal1() {
		Assert.equals(1747, Solution1.convertToDecimal("1=-0-2"));
		Assert.equals(906, Solution1.convertToDecimal("12111"));
		Assert.equals(198, Solution1.convertToDecimal("2=0="));
		Assert.equals(11, Solution1.convertToDecimal("21"));
		Assert.equals(201, Solution1.convertToDecimal("2=01"));
		Assert.equals(31, Solution1.convertToDecimal("111"));
		Assert.equals(1257, Solution1.convertToDecimal("20012"));
		Assert.equals(32, Solution1.convertToDecimal("112"));
		Assert.equals(353, Solution1.convertToDecimal("1=-1="));
		Assert.equals(107, Solution1.convertToDecimal("1-12"));
		Assert.equals(7, Solution1.convertToDecimal("12"));
		Assert.equals(3, Solution1.convertToDecimal("1="));
		Assert.equals(37, Solution1.convertToDecimal("122"));
	}

	function testConvertToDecimal2() {
		Assert.equals(-431, Solution1.convertToDecimal("-2=--"));
		Assert.equals(4302694, Solution1.convertToDecimal("21002-2=--"));
		Assert.equals(-347259806, Solution1.convertToDecimal("-=-21002-2=--"));
		Assert.equals(-2788666056, Solution1.convertToDecimal("=-=-21002-2=--"));
		Assert.equals(3314849569, Solution1.convertToDecimal("1=-=-21002-2=--"));
	}

	function testConvertToSnafu1() {
		Assert.equals("1=-0-2", Solution1.convertToSnafu(1747));
		Assert.equals("12111", Solution1.convertToSnafu(906));
		Assert.equals("2=0=", Solution1.convertToSnafu(198));
		Assert.equals("21", Solution1.convertToSnafu(11));
		Assert.equals("2=01", Solution1.convertToSnafu(201));
		Assert.equals("111", Solution1.convertToSnafu(31));
		Assert.equals("20012", Solution1.convertToSnafu(1257));
		Assert.equals("112", Solution1.convertToSnafu(32));
		Assert.equals("1=-1=", Solution1.convertToSnafu(353));
		Assert.equals("1-12", Solution1.convertToSnafu(107));
		Assert.equals("12", Solution1.convertToSnafu(7));
		Assert.equals("1=", Solution1.convertToSnafu(3));
		Assert.equals("122", Solution1.convertToSnafu(37));
	}

	function testConvertToSnafu2() {
		Assert.equals("2=01-0-2-0=-0==-1=01", Solution1.convertToSnafu(30638862852576));
	}
}

function main() {
	utest.UTest.run([new Test()]);
}
