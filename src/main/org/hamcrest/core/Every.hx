/****
* Copyright 2011 hamcrest.org. See LICENSE.txt
****/

package org.hamcrest.core;

import org.hamcrest.Description;
import org.hamcrest.Matcher;
import org.hamcrest.TypeSafeDiagnosingMatcher;

class Every<T> extends TypeSafeDiagnosingMatcher<Iterable<T>>
{
	var matcher:Matcher<T>;

	public function new(matcher:Matcher<T>)
	{
		super();
		this.matcher = matcher;
	}
	
	public function doMatchesSafely(collection:Iterable<T>, mismatchDescription:Description):Bool
	{
		return matchesSafely(collection, mismatchDescription);
	}
	
	override function matchesSafely(collection:Iterable<T>, mismatchDescription:Description):Bool
	{
		for (t in collection)
		{
			if (!matcher.matches(t))
			{
				mismatchDescription.appendText("an item ");
				matcher.describeMismatch(t, mismatchDescription);
				return false;
			}
		}
		return true;
	}

	override public function describeTo(description:Description):Void
	{
		description.appendText("every item is ").appendDescriptionOf(matcher);
	}
	
    override function isExpectedType(value:Dynamic):Bool
    {
    	return TypedefChecker.isIterable(value);
    }
	
	/**
     * @param itemMatcher A matcher to apply to every element in a collection.
     * @return Evaluates to TRUE for a collection in which every item matches itemMatcher 
     */
	public static function everyItem<T>(itemMatcher:Matcher<T>):Matcher<Iterable<T>>
	{
		return new Every<T>(itemMatcher);
	}

}
