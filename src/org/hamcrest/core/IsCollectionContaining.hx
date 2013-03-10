/****
* Copyright 2011 hamcrest.org. See LICENSE.txt
****/

package org.hamcrest.core;

import org.hamcrest.Description;
import org.hamcrest.Matcher;
import org.hamcrest.TypeSafeDiagnosingMatcher;
import org.hamcrest.Exception;
import org.hamcrest.TypedefChecker;

class IsCollectionContaining<T> extends TypeSafeDiagnosingMatcher<Iterable<T>> 
{
    var elementMatcher:Matcher<T>;

    public function new(elementMatcher:Matcher<T>)
    {
    	super();
        this.elementMatcher = elementMatcher;
    }

    override function matchesSafely(collection:Iterable<T>, mismatchDescription:Description):Bool 
    {
        var isPastFirst = false;
        for (item in collection)
        {
            if (elementMatcher.matches(item))
            {
                return true;
            }
            if (isPastFirst)
            {
            	mismatchDescription.appendText(", ");
            }
            elementMatcher.describeMismatch(item, mismatchDescription);
            isPastFirst = true;
        }
        return false;
    }

    override public function describeTo(description:Description):Void
    {
        description
            .appendText("a collection containing ")
            .appendDescriptionOf(elementMatcher);
    }
    
    override function isExpectedType(value:Dynamic):Bool
    {
    	return TypedefChecker.isIterable(value);
    }
    
    public static function hasItem<T>(value:Dynamic):Matcher<Iterable<T>>
    {
    	if (Std.is(value, Matcher))
    		return new IsCollectionContaining<T>(value);
    	
    	return new IsCollectionContaining<T>(IsEqual.equalTo(value));
    }
    
    public static function hasItems<T, U>(values:Array<U>):Matcher<Iterable<T>>
    {
    	if (values != null)
    	{
			var all:Array<Matcher<Iterable<T>>> = [];
    		
    		if (values.length > 0)
	    	{
	    		if (Std.is(values[0], Matcher))
	    		{
					
				    for (elementMatcher in values)
						all.push(new IsCollectionContaining<T>(cast elementMatcher));
					
					return AllOf.allOf(all);
	    		}
	    	}
    		
    		for (element in values)
	            all.push(hasItem(element));
        
        	return AllOf.allOf(all);
	    }
	    
    	throw new IllegalArgumentException();
    	return null;
    }
}

