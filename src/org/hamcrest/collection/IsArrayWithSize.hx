/****
* Copyright 2011 hamcrest.org. See LICENSE.txt
****/

package org.hamcrest.collection;

import org.hamcrest.FeatureMatcher;
import org.hamcrest.Matcher;
import org.hamcrest.Exception;
import org.hamcrest.core.IsEqual;
import org.hamcrest.core.DescribedAs;

/**
 * Matches if array size satisfies a nested matcher.
 */
class IsArrayWithSize<E> extends FeatureMatcher<Array<E>, Int>
{
    public function new(sizeMatcher:Matcher<Int>)
    {
        super(sizeMatcher, "an array with size", "array size");
    }

    override function featureValueOf(actual:Array<E>):Int
    {
    	return actual.length;
    }
    
    override function isExpectedType(value:Dynamic):Bool
    {
    	return Std.is(value, Array);
    }
    
    /**
     * Does array size satisfy a given matcher?
	 *
     * Usage,  assertThat(arrayWithSize(equalTo(x)))
     * or      assertThat(arrayWithSize(x))
     *
     * @param value		Either an array size of Int or array size of Matcher<Int>.
     */
    public static function arrayWithSize<E>(value:Dynamic):Matcher<Array<E>>
    {
    	if (Std.is(value, Matcher))
    		return new IsArrayWithSize<E>(value);
    	else if (Std.is(value, Int))
    		return arrayWithSize(IsEqual.equalTo(value));
    	
    	throw new IllegalArgumentException();
    	return null;
    }

    /**
     * Matches an empty array.
     */
    public static function emptyArray<E>():Matcher<Array<E>> 
    {
        var isEmpty = arrayWithSize(0);
        return DescribedAs.describedAs("an empty array", isEmpty);
    }
}
