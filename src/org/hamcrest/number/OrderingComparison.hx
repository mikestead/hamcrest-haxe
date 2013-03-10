/****
* Copyright 2011 hamcrest.org. See LICENSE.txt
****/

/*  Copyright (c) 2000-2009 hamcrest.org
 */
package org.hamcrest.number;

import org.hamcrest.Description;
import org.hamcrest.Matcher;
import org.hamcrest.TypeSafeMatcher;
import org.hamcrest.Exception;

class OrderingComparison extends TypeSafeMatcher<Dynamic>
{
    static var LESS_THAN:Int = -1;
    static var GREATER_THAN:Int = 1;
    static var EQUAL:Int = 0;

    static var comparisonDescriptions:Array<String> = [
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
    	var value = 0;
    	if (Std.is(actual, Float) || Std.is(actual, Int) || Std.is(actual, String))
    	{
    		if (actual < expected)
    			value = -1;
    		else if (actual > expected)
    			value = 1;
    	}
    	else
    	{
			var field = Reflect.field(value, "__compare");
			if (field != null && Reflect.isFunction(field))
			{
				value = Reflect.compare(actual, expected);
			}
			else
			{
				field = Reflect.field(value, "compareTo");
				if (field != null && Reflect.isFunction(field))
				{
					value = Reflect.callMethod(value, field, [expected]);
				}
				else
				{
					throw new IllegalArgumentException("Argument is not of a comparable type.");
				}
			}
			value = signum(value);
		}
		
		return value;
    }
    
    function signum(value:Int):Int
    {
    	if (value > 0)
    		return 1;
    	else if (value < 0)
    		return -1;
    	return 0;
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
    	return TypedefChecker.isComparable(value);
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
//    public static <T extends Comparable<T>> Matcher<T> lessThanOrEqualTo(T value) {
    public static function lessThanOrEqualTo(value:Dynamic):Matcher<Dynamic>
    {
        return new OrderingComparison(value, LESS_THAN, EQUAL);
    }
}
