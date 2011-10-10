/****
* Copyright 2011 hamcrest.org. See LICENSE.txt
****/

/*  Copyright (c) 2000-2009 hamcrest.org
 */
package org.hamcrest.core;

import org.hamcrest.BaseMatcher;
import org.hamcrest.Description;
import org.hamcrest.Matcher;


/**
 * Calculates the logical negation of a matcher.
 */
class IsNot<T> extends BaseMatcher<T>
{
    var matcher:Matcher<T>;

    public function new(matcher:Matcher<T>)
    {
    	super();
        this.matcher = matcher;
    }

    override public function matches(arg:Dynamic):Bool
    {
        return !matcher.matches(arg);
    }

    override public function describeTo(description:Description):Void
    {
        description.appendText("not ").appendDescriptionOf(matcher);
    }
    
    /**
     * This is a shortcut to the frequently used not(equalTo(x)).
     *
     * For example:  assertThat(cheese, is(not(equalTo(smelly))))
     *          vs.  assertThat(cheese, is(not(smelly)))
     */
    public static function not<T>(value:Dynamic):Matcher<T>
    {
    	if (Std.is(value, Matcher))
    		return new IsNot<T>(value);
    	
    	return not(IsEqual.equalTo(value));
    }
}
