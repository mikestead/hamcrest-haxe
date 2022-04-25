/****
* Copyright 2011 hamcrest.org. See LICENSE.txt
****/

package org.hamcrest.core;

import org.hamcrest.BaseMatcher;
import org.hamcrest.Description;
import org.hamcrest.Matcher;
import org.hamcrest.Exception;

#if (haxe_ver >= 4.2)
import Std.isOfType;
#else
import Std.is as isOfType;
#end

/**
 * Decorates another Matcher, retaining the behavior but allowing tests
 * to be slightly more expressive.
 *
 * For example:  assertThat(cheese, equalTo(smelly))
 *          vs.  assertThat(cheese, is(equalTo(smelly)))
 */
class Is<T> extends BaseMatcher<T> 
{
    var matcher:Matcher<T>;

    public function new(matcher:Matcher<T>)
    {
    	super();
        this.matcher = matcher;
    }

    override public function matches(value:Dynamic):Bool
    {
        return matcher.matches(value);
    }

    override public function describeTo(description:Description):Void
    {
        description.appendText("is ").appendDescriptionOf(matcher);
    }

    override public function describeMismatch(item:Dynamic, mismatchDescription:Description)
    {
    	matcher.describeMismatch(item, mismatchDescription);
    }

	public static function is<T>(value:Dynamic):Matcher<T>
	{
		if (isOfType(value, Matcher))
			return new Is<T>(value);

		if (isOfType(value, Class))
			return isA(value);

		return is(IsEqual.equalTo(value));
	}

	public static function isA<T>(type:Class<Dynamic>):Matcher<T>
	{
		#if (php && haxe_209)
		throw new Exception("PHP does not yet support the instanceOf matcher due to keyword name collision.");
		#else
		return is(IsInstanceOf.instanceOf(type));
		#end
	}
}
