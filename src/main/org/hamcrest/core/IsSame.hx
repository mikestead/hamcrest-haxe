/****
* Copyright 2011 hamcrest.org. See LICENSE.txt
****/

package org.hamcrest.core;

import org.hamcrest.BaseMatcher;
import org.hamcrest.Description;
import org.hamcrest.Matcher;

/**
 * Is the value the same object as another value?
 */
class IsSame<T> extends BaseMatcher<T>
{
    var object:T;
    
    public function new(object:T)
    {
    	super();
        this.object = object;
    }

    override public function matches(arg:Dynamic):Bool
    {
        return arg == object;
    }

    override public function describeTo(description:Description):Void
    {
        description.appendText("sameInstance(")
                .appendValue(object)
                .appendText(")");
    }
    
    /**
     * Creates a new instance of IsSame
     *
     * @param object The predicate evaluates to true only when the argument is
     *               this object.
     */
    public static function sameInstance<T>(object:T):Matcher<T>
    {
        return new IsSame<T>(object);
    }
}
