/****
* Copyright 2011 hamcrest.org. See LICENSE.txt
****/

package org.hamcrest;

import org.hamcrest.Exception;
import org.hamcrest.Description;

/**
 * Convenient base class for Matchers that require a non-null value of a specific type
 * and that will report why the received value has been rejected.
 * This implements the null check, checks the type and then casts. 
 * To use, implement <pre>matchesSafely()</pre>. 
 *
 * @param <T>
 */
class TypeSafeDiagnosingMatcher<T> extends BaseMatcher<T> 
{
    /**
     * Use this constructor if the subclass that implements <code>matchesSafely</code> 
     * is <em>not</em> the class that binds &lt;T&gt; to a type. 
     * @param expectedType The expectedType of the actual value.
     */
    private function new()
    {
    	super();
    }

    /**
     * Subclasses should implement this. The item will already have been checked
     * for the specific type and will never be null.
     */
    function matchesSafely(item:T, mismatchDescription:Description):Bool
    {
    	throw new MissingImplementationException();
    	return false;
    }
    
    function isExpectedType(value:Dynamic):Bool
    {
    	throw new MissingImplementationException();
    	return false;    
    }
    
    override public function matches(item:Dynamic):Bool
    {
        return item != null && isExpectedType(item) && matchesSafely(cast item, new NullDescription());
    }

    override public function describeMismatch(item:Dynamic, mismatchDescription:Description):Void
    {
		if (item == null || !isExpectedType(item))
		{
			super.describeMismatch(item, mismatchDescription);
		} 
		else 
		{
        	matchesSafely(cast item, mismatchDescription);
        }
    }
}
