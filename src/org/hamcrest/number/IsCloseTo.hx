/****
* Copyright 2011 hamcrest.org. See LICENSE.txt
****/

package org.hamcrest.number;

import org.hamcrest.Description;
import org.hamcrest.Matcher;
import org.hamcrest.TypeSafeMatcher;


/**
 * Is the value a number equal to a value within some range of
 * acceptable error?
 */
class IsCloseTo extends TypeSafeMatcher<Float>
{
    var delta:Float;
    var value:Float;

    public function new(value:Float, error:Float)
    {
    	super();
        this.delta = error;
        this.value = value;
    }

    override function matchesSafely(item:Float):Bool
    {
        return actualDelta(item) <= 0.0;
    }

    override function isExpectedType(value:Dynamic):Bool
    {
    	return Std.is(value, Float);   
    }
    
    override function describeMismatchSafely(item:Float, mismatchDescription:Description)
    {
      mismatchDescription.appendValue(item)
                         .appendText(" differed by ")
                         .appendValue(actualDelta(item));
    }

    override function describeTo(description:Description)
    {
        description.appendText("a numeric value within ")
                .appendValue(delta)
                .appendText(" of ")
                .appendValue(value);
    }

    function actualDelta(item:Float):Float
    {
		return (Math.abs((item - value)) - delta);
    }

    public static function closeTo(operand:Float, error:Float):Matcher<Float>
    {
        return new IsCloseTo(operand, error);
    }
}
