/****
* Copyright 2011 hamcrest.org. See LICENSE.txt
****/

package org.hamcrest.collection;

import org.hamcrest.FeatureMatcher;
import org.hamcrest.Matcher;
import org.hamcrest.Exception;
import org.hamcrest.core.IsEqual;
import org.hamcrest.internal.TypeIdentifier;

class IsIterableWithSize<E> extends FeatureMatcher<Iterable<E>, Int>
{
	static var FEATURE_NAME = "iterable size";
	static var FEATURE_DESCRIPTION = "an iterable with size";

    public function new(sizeMatcher:Matcher<Int>)
    {
        super(sizeMatcher, FEATURE_DESCRIPTION, FEATURE_NAME);
    }

    override function featureValueOf(actual:Iterable<E>):Int
    {
        if (Std.is(actual, Array))
        {
            return cast(actual, Array<Dynamic>).length;
        }
	    else
        {
			var size = 0;
			for (value in actual)
				size++;
			return size;
        }
    }
    
    override function isExpectedType(value:Dynamic):Bool
    {
    	return TypeIdentifier.isIterable(value);
    }

	override function matchesSafely(actual:Iterable<E>, mismatchDescription:Description):Bool
	{
		updateDescription(actual);
		return super.matchesSafely(actual, mismatchDescription);
	}
	
	function updateDescription(actual:Iterable<E>)
	{
		featureName = FEATURE_NAME;
		featureDescription = FEATURE_DESCRIPTION;
		if (Std.is(actual, Array))
		{
			featureName = featureName.split("iterable").join("array");
			featureDescription =featureDescription.split("iterable").join("array");
		}
	}
    
    /**
     * Does array size satisfy a given matcher?
	 *
     * Usage,  assertThat(iterableWithSize(equalTo(x)))
     * or      assertThat(iterableWithSize(x))
     *
     * @param value		Either an iterable size of Int or iterable size of Matcher<Int>.
     */
    public static function hasSize<T>(value:Dynamic):Matcher<Iterable<T>>
    {
    	if (Std.is(value, Matcher))
    		return new IsIterableWithSize<T>(value);
    	else if (Std.is(value, Int))
    		return hasSize(IsEqual.equalTo(value));
    	
    	throw new IllegalArgumentException();
    	return null;
    }
}
