/****
* Copyright 2011 hamcrest.org. See LICENSE.txt
****/

package org.hamcrest;

import org.hamcrest.Exception;

/**
 * Convenient base class for Matchers that require a non-null value of a specific type.
 * This simply implements the null check, checks the type and then casts.
 */
class TypeSafeMatcher<T> extends BaseMatcher<T>
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
     * Subclasses should implement this. The item will already have been checked for
     * the specific type and will never be null.
     */
    function matchesSafely(item:T):Bool
    {
    	throw new MissingImplementationException();
    	return false;
    }
    
    function isExpectedType(value:Dynamic):Bool
    {
    	throw new MissingImplementationException();
    	return false;    
    }
    
    /**
     * Subclasses should override this. The item will already have been checked for
     * the specific type and will never be null.
     */
    function describeMismatchSafely(item:T, mismatchDescription:Description)
    {
        super.describeMismatch(item, mismatchDescription);
    }
    
    /**
     * Methods made final to prevent accidental override.
     * If you need to override this, there's no point on extending TypeSafeMatcher.
     * Instead, extend the {@link BaseMatcher}.
     */
    override public function matches(item:Dynamic):Bool 
    {
        return item != null && isExpectedType(item) && matchesSafely(cast item);
    }
    
    override public function describeMismatch(item:Dynamic, description:Description)
    {
        if (item == null)
        {
            super.describeMismatch(item, description);
        }
        else if (!isExpectedType(item))
        {
            description.appendText("was a ")
                       .appendText(Type.getClassName(Type.getClass(item)))
                       .appendText(" (")
                       .appendValue(item)
                       .appendText(")");
        }
        else
        {
            describeMismatchSafely(cast item, description);
        }
    }
}
