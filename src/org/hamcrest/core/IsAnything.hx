/****
* Copyright 2011 hamcrest.org. See LICENSE.txt
****/

/*  Copyright (c) 2000-2006 hamcrest.org
 */
package org.hamcrest.core;

import org.hamcrest.Description;
import org.hamcrest.Matcher;
import org.hamcrest.BaseMatcher;


/**
 * A matcher that always returns <code>true</code>.
 */
class IsAnything<T> extends BaseMatcher<T>
{
    var message:String;

    public function new(?message:String = "ANYTHING")
    {
    	super();
    	this.message = message;
    }
    
    override public function matches(value:Dynamic):Bool
    {
        return true;
    }

    override public function describeTo(description:Description):Void
    {
        description.appendText(message);
    }

    /**
     * This matcher always evaluates to true.
	 *
	 * @param description A meaningful string used when describing itself.
     */
    public static function anything(?description:String):Matcher<Dynamic>
    {
        return new IsAnything<Dynamic>(description);
    }
}
