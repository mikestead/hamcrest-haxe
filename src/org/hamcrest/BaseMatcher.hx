/****
* Copyright 2011 hamcrest.org. See LICENSE.txt
****/

package org.hamcrest;

import org.hamcrest.Exception;

/**
 * BaseClass for all Matcher implementations.
 *
 * @see Matcher
 */
class BaseMatcher<T> implements Matcher<T>
{
	private function new()
	{
	}
	
    public function describeMismatch(item:Dynamic, description:Description):Void
    {
    	description.appendText("was ").appendValue(item);
    }
    
    public function matches(item:Dynamic):Bool
    {
	    throw new MissingImplementationException();
	    return false;
    }
    
    public function describeTo(description:Description):Void
    {
	    throw new MissingImplementationException();    
    }
    
    public function toString():String
    {
        return StringDescription.asString(this);
    }
}
