/****
* Copyright 2011 hamcrest.org. See LICENSE.txt
****/

package org.hamcrest.core;

import org.hamcrest.BaseMatcher;
import org.hamcrest.Description;
import org.hamcrest.Matcher;
import org.hamcrest.Exception;

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
    	if (Std.is(value, Matcher))
    		return new Is<T>(value);
    	if (Std.is(value, Class))
    		return is(IsInstanceOf.instanceOf(value));
    	
    	return is(IsEqual.equalTo(value));
    }
}
