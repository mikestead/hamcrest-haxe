/****
* Copyright 2011 hamcrest.org. See LICENSE.txt
****/

package org.hamcrest.collection;

import org.hamcrest.Description;
import org.hamcrest.Matcher;
import org.hamcrest.TypeSafeMatcher;
import org.hamcrest.core.IsEqual;

/**
 * Matches if an array contains an item satisfying a nested matcher.
 */
class IsArrayContaining<T> extends TypeSafeMatcher<Array<T>>
{
    var elementMatcher:Matcher<T>;

    public function new(elementMatcher:Matcher<T>)
    {
    	super();
        this.elementMatcher = elementMatcher;
    }

    override function matchesSafely(array:Array<T>):Bool
    {
    	for (item in array)
            if (elementMatcher.matches(item))
                return true;
        
        return false;
    }
    
    override function isExpectedType(value:Dynamic):Bool
    {
    	return Std.is(value, Array);
    }

    override function describeMismatchSafely(item:Array<T>, mismatchDescription:Description):Void
    {
    	super.describeMismatch(item, mismatchDescription);
    }

    override public function describeTo(description:Description):Void
    {
        description
            .appendText("an array containing ")
            .appendDescriptionOf(elementMatcher);
    }

    /**
     * Evaluates to true if any item in an array satisfies the given matcher.
     */
    public static function hasItemInArray<T>(element:Dynamic):Matcher<Array<T>>
    {
    	if (Std.is(element, Matcher))
	        return new IsArrayContaining<T>(element);
	    
	    return hasItemInArray(IsEqual.equalTo(element));
    }
}

