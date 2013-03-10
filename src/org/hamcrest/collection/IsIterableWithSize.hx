/****
* Copyright 2011 hamcrest.org. See LICENSE.txt
****/

package org.hamcrest.collection;

import org.hamcrest.FeatureMatcher;
import org.hamcrest.Matcher;
import org.hamcrest.Exception;
import org.hamcrest.core.IsEqual;
import org.hamcrest.TypedefChecker;

class IsIterableWithSize<E> extends FeatureMatcher<Iterable<E>, Int>
{
    public function new(sizeMatcher:Matcher<Int>)
    {
        super(sizeMatcher, "an iterable with size", "iterable size");
    }

    override function featureValueOf(actual:Iterable<E>):Int
    {
		var size = 0;
		for (value in actual)
			size++;
		return size;
    }
    
    override function isExpectedType(value:Dynamic):Bool
    {
    	return TypedefChecker.isIterable(value);
    }
    
    /**
     * Does array size satisfy a given matcher?
	 *
     * Usage,  assertThat(iterableWithSize(equalTo(x)))
     * or      assertThat(iterableWithSize(x))
     *
     * @param value		Either an iterable size of Int or iterable size of Matcher<Int>.
     */
    public static function iterableWithSize<T>(value:Dynamic):Matcher<Iterable<T>>
    {
    	if (Std.is(value, Matcher))
    		return new IsIterableWithSize<T>(value);
    	else if (Std.is(value, Int))
    		return iterableWithSize(IsEqual.equalTo(value));
    	
    	throw new IllegalArgumentException();
    	return null;
    }
}
