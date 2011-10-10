/****
* Copyright 2011 hamcrest.org. See LICENSE.txt
****/

package org.hamcrest.core;

import org.hamcrest.Description;
import org.hamcrest.Matcher;
import org.hamcrest.BaseMatcher;

/**
 * Is the value null?
 */
class IsNull<T> extends BaseMatcher<T>
{
	public function new()
	{
		super();
	}
	
    override public function matches(value:Dynamic):Bool
    {
        return value == null;
    }

    override public function describeTo(description:Description):Void
    {
        description.appendText("null");
    }

    /**
     * Matches if value is null.
     */
    public static function nullValue<T>(?type:Class<T>):Matcher<T>
    {
    	return new IsNull<T>();
    }
    

    /**
     * Matches if value is not null.
     */
    public static function notNullValue<T>(?type:Class<T>):Matcher<T>
    {
        return IsNot.not(nullValue(type));
    }
}

