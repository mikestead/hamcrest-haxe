/****
* Copyright 2011 hamcrest.org. See LICENSE.txt
****/

package org.hamcrest.collection;

import org.hamcrest.Description;
import org.hamcrest.Matcher;
import org.hamcrest.TypeSafeMatcher;
import org.hamcrest.Exception;

/**
 * Matcher for array whose elements satisfy a sequence of matchers.
 * The array size must equal the number of element matchers.
 */
class IsArray<T> extends TypeSafeMatcher<Array<T>>
{
    var elementMatchers:Array<Matcher<T>>;
    
    public function new(elementMatchers:Array<Matcher<T>>)
    {
    	super();
        this.elementMatchers = elementMatchers.concat([]);
    }
    
    override function matchesSafely(array:Array<T>):Bool
    {
        if (array.length != elementMatchers.length) 
        	return false;
        
        for (i in 0...array.length)
            if (!elementMatchers[i].matches(array[i]))
            	return false;
        
        return true;
    }
    
    override function isExpectedType(value:Dynamic):Bool
    {
    	return Std.is(value, Array);
    }

    override function describeMismatchSafely(actual:Array<T>, mismatchDescription:Description):Void
    {
		if (actual.length != elementMatchers.length)
		{
        	mismatchDescription.appendText("array length was " + actual.length);
        	return;
      	}
        for (i in 0...actual.length)
        {
            if (!elementMatchers[i].matches(actual[i]))
            {
				mismatchDescription.appendText("element " + i + " was ").appendValue(actual[i]);
            	return;
            }
        }
	}

    override function describeTo(description:Description):Void
    {
        description.appendList(descriptionStart(), descriptionSeparator(), descriptionEnd(), elementMatchers);
    }
    
    /**
     * Returns the string that starts the description.
     * 
     * Can be overridden in subclasses to customise how the matcher is
     * described.
     */
    function descriptionStart():String
    {
        return "[";
    }

    /**
     * Returns the string that separates the elements in the description.
     * 
     * Can be overridden in subclasses to customise how the matcher is
     * described.
     */
    function descriptionSeparator():String 
    {
        return ", ";
    }

    /**
     * Returns the string that ends the description.
     * 
     * Can be overridden in subclasses to customise how the matcher is
     * described.
     */
    function descriptionEnd():String
    {
        return "]";
    }
    
    /**
     * Evaluates to true only if each matcher[i] is satisfied by array[i].
     */
    public static function array<T>(first:Dynamic, 
    							 ?second:Matcher<T> = null,
    							 ?third:Matcher<T> = null, 
    							 ?fourth:Matcher<T> = null, 
    							 ?fifth:Matcher<T> = null, 
    							 ?sixth:Matcher<T> = null, 
    							 ?seventh:Matcher<T> = null, 
    							 ?eighth:Matcher<T> = null, 
    							 ?ninth:Matcher<T> = null, 
    							 ?tenth:Matcher<T> = null):IsArray<T>
    {
    
    	var matchers:Array<Matcher<T>>;
    	if (Std.is(first, Array))
    	{
    		matchers = cast first;
    	}
    	else if (Std.is(first, Matcher))
    	{
    		matchers = [];
    		matchers.push(cast first);
   	    }
	    else
	    {
	    	throw new IllegalArgumentException("First argument must be of type Matcher or Array<Matcher>");
	    }
	    
    	if (second != null)	matchers.push(second);
    	if (third != null)	matchers.push(third);
    	if (fourth != null)	matchers.push(fourth);
    	if (fifth != null)	matchers.push(fifth);
    	if (sixth != null)	matchers.push(sixth);
    	if (seventh != null)matchers.push(seventh);
    	if (eighth != null)	matchers.push(eighth);
    	if (ninth != null)	matchers.push(ninth);
    	if (tenth != null)	matchers.push(tenth);
    	
    	return new IsArray<T>(matchers);
    }
}
