package org.hamcrest.number;

import org.hamcrest.internal.TypeIdentifier;
import org.hamcrest.Description;
import org.hamcrest.Matcher;
import org.hamcrest.internal.TypeIdentifier;
import org.hamcrest.Exception;

class OrderingComparison extends TypeSafeMatcher<Dynamic>
{
	static var LESS_THAN:Int = -1;
	static var GREATER_THAN:Int = 1;
	static var EQUAL:Int = 0;

	static var comparisonDescriptions:Array<String> =
	[
		"less than",
		"equal to",
		"greater than"
	];
	
	var expected:Dynamic;
	var minCompare:Int;
	var maxCompare:Int;

	private function new(expected:Dynamic, minCompare:Int, maxCompare:Int)
	{
		super();
		this.expected = expected;
		this.minCompare = minCompare;
		this.maxCompare = maxCompare;
	}

	override function matchesSafely(actual:Dynamic):Bool
	{
		var compare = compareToExpected(actual);
		return minCompare <= compare && compare <= maxCompare;
	}
	
	function compareToExpected(actual:Dynamic):Int
	{
		var expectedCompareTo = getCompareToFunction(expected);
		var actualCompareTo = getCompareToFunction(actual);
		
		var value = 0;
		
		if (TypeIdentifier.isComparablePrimitive(actual))
		{
			if (TypeIdentifier.isComparablePrimitive(expected))
			{
				value = Reflect.compare(actual, expected);
			}
			else if (TypeIdentifier.isNumber(actual) && Std.is(expected, Date))
			{
				value = Reflect.compare(actual, cast(expected, Date).getTime());
			}
			else if (expectedCompareTo != null)
			{
				value = Reflect.callMethod(expected, expectedCompareTo, [actual]);
				// Invert response becuase we asked the expected to compare instead of actual
				value = invertSignum(value);
			}
			else
			{
				throw new IllegalArgumentException("Expected value is not of a comparable type. [" + expected + "]");
			}
		}
		else if (Std.is(actual, Date))
		{
			if (TypeIdentifier.isNumber(expected))
			{
				value = Reflect.compare(cast(actual, Date).getTime(), expected);
			}
			else if (Std.is(expected, Date))
			{
				value = Reflect.compare(cast(actual, Date).getTime(), cast(expected, Date).getTime());
			}
			else if (expectedCompareTo != null)
			{
				value = Reflect.callMethod(expected, expectedCompareTo, [actual]);
				// Invert response becuase we asked the expected to compare instead of actual
				value = invertSignum(value);
			}
			else
			{
				throw new IllegalArgumentException("Expected value is not of a comparable type. [" + expected + "]");
			}
		}
		else if (actualCompareTo != null)
		{
			value = Reflect.callMethod(actual, actualCompareTo, [expected]);
		}
		else
		{
			throw new IllegalArgumentException("Actual value is not of a comparable type. [" + actual + "]");
		}
		return signum(value);
	}
	
	static function getCompareToFunction(subject:Dynamic)
	{
		var field = Reflect.field(subject, "compareTo");
		if (field != null && Reflect.isFunction(field))
			return field;
		return null;
	}
	
	static function signum(value:Int):Int
	{
		if (value > 0) return 1;
		else if (value < 0) return -1;
		else return 0;
	}
	
	static function invertSignum(value:Int):Int
	{
		if (value > 0) return -1;
		else if (value < 0) return 1;
		else return 0;
	}

	override function describeMismatchSafely(actual:Dynamic, mismatchDescription:Description):Void
	{
		mismatchDescription.appendValue(actual).appendText(" was ")
				.appendText(asText(compareToExpected(actual)))
				.appendText(" ").appendValue(expected);
	}

	override function describeTo(description:Description):Void
	{
		description.appendText("a value ").appendText(asText(minCompare));
		if (minCompare != maxCompare) {
			description.appendText(" or ").appendText(asText(maxCompare));
		}
		description.appendText(" ").appendValue(expected);
	}

	function asText(comparison:Int):String
	{
		return comparisonDescriptions[comparison + 1];
	}

	override function isExpectedType(value:Dynamic):Bool
	{
		return TypeIdentifier.isComparable(value);
	}
	
	/**
	 * @return Is value = expected?
	 */
	public static function comparesEqualTo(value:Dynamic):Matcher<Dynamic>
	{
		return new OrderingComparison(value, EQUAL, EQUAL);
	}

	/**
	 * Is value > expected?
	 */
	public static function greaterThan(value:Dynamic):Matcher<Dynamic>
	{
		return new OrderingComparison(value, GREATER_THAN, GREATER_THAN);
	}

	/**
	 * Is value >= expected?
	 */
	public static function greaterThanOrEqualTo(value:Dynamic):Matcher<Dynamic>
	{
		return new OrderingComparison(value, EQUAL, GREATER_THAN);
	}

	/**
	 * Is value < expected?
	 */
	public static function lessThan(value:Dynamic):Matcher<Dynamic>
	{
		return new OrderingComparison(value, LESS_THAN, LESS_THAN);
	}

	/**
	 * Is value <= expected?
	 */
//	public static <T extends Comparable<T>> Matcher<T> lessThanOrEqualTo(T value) {
	public static function lessThanOrEqualTo(value:Dynamic):Matcher<Dynamic>
	{
		return new OrderingComparison(value, LESS_THAN, EQUAL);
	}
}
