/****
* Copyright 2011 hamcrest.org. See LICENSE.txt
****/

package org.hamcrest.collection;

import org.hamcrest.Description;
import org.hamcrest.Matcher;
import org.hamcrest.TypeSafeMatcher;
import org.hamcrest.TypedefChecker;

/**
 * Tests if collection is empty.
 */
class IsEmptyIterable<E> extends TypeSafeMatcher<Iterable<E>>
{
	public function new()
	{
		super();
	}
	
    override function matchesSafely(iterable:Iterable<E>):Bool
    {
        return !iterable.iterator().hasNext();
    }
    
    override function describeMismatchSafely(iterator:Iterable<E>, mismatchDescription:Description)
    {
        mismatchDescription.appendValueList("[", ",", "]", iterator);
    }
    
    override function isExpectedType(value:Dynamic):Bool
    {
    	return TypedefChecker.isIterable(value);
    }

    override public function describeTo(description:Description):Void
    {
        description.appendText("an empty iterable");
    }

    /**
     * Matches an empty iterable.
     */
    public static function emptyIterable<E>():Matcher<Iterable<E>>
    {
        return new IsEmptyIterable<E>();
    }
}
