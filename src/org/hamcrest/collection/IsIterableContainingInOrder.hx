/****
* Copyright 2011 hamcrest.org. See LICENSE.txt
****/

package org.hamcrest.collection;

import org.hamcrest.internal.TypeIdentifier;
import org.hamcrest.Description;
import org.hamcrest.Matcher;
import org.hamcrest.TypeSafeDiagnosingMatcher;
import org.hamcrest.Exception;
import org.hamcrest.internal.VarArgMatchers;

class IsIterableContainingInOrder<E> extends TypeSafeDiagnosingMatcher<Iterable<E>>
{
    var matchers:Array<Matcher<E>>;

    public function new(matchers:Array<Matcher<E>>)
    {
    	super();
        this.matchers = matchers;
    }

    override function matchesSafely(iterable:Iterable<E>, mismatchDescription:Description):Bool
    {
        var matchSeries = new MatchSeries<E>(matchers, mismatchDescription);
        for (item in iterable) {
            if (!matchSeries.matches(item)) {
                return false;
            }
        }

        return matchSeries.isFinished();
    }
    
    override function isExpectedType(value:Dynamic):Bool
    {
    	return TypeIdentifier.isIterable(value);
    }

    override public function describeTo(description:Description)
    {
        description.appendText("iterable containing ").appendList("[", ", ", "]", matchers);
    }
    
    public static function containsInOrder<T>(first:Dynamic, 
		    							 ?second:Dynamic,
		    							 ?third:Dynamic, 
		    							 ?fourth:Dynamic, 
		    							 ?fifth:Dynamic, 
		    							 ?sixth:Dynamic, 
		    							 ?seventh:Dynamic, 
		    							 ?eighth:Dynamic, 
		    							 ?ninth:Dynamic, 
		    							 ?tenth:Dynamic):Matcher<Iterable<T>>
	{
		return VarArgMatchers.newIterable(cast IsIterableContainingInOrder, first, second, third, fourth, fifth, sixth, seventh, eighth, ninth, tenth);
	}
}

private class MatchSeries<F>
{
    var matchers:Array<Matcher<F>>;
    var mismatchDescription:Description;
    var nextMatchIx:Int;

    public function new(matchers:Array<Matcher<F>>, mismatchDescription:Description)
    {
        if (matchers.length == 0)
            throw new IllegalArgumentException("Should specify at least one expected element");
        
        this.mismatchDescription = mismatchDescription;
        this.matchers = matchers;
        nextMatchIx = 0;
    }

    public function matches(item:F):Bool
    {
        return isNotSurplus(item) && isMatched(item);
    }

    public function isFinished():Bool
    {
        if (nextMatchIx < matchers.length)
        {
            mismatchDescription.appendText("No item matched: ").appendDescriptionOf(matchers[nextMatchIx]);
            return false;
        }
        return true;
    }

    function isMatched(item:F)
    {
        var matcher = matchers[nextMatchIx];
        if (!matcher.matches(item))
        {
            describeMismatch(matcher, item);
            return false;
        }
        nextMatchIx++;
        return true;
    }

    function isNotSurplus(item:F):Bool
    {
        if (matchers.length <= nextMatchIx)
        {
            mismatchDescription.appendText("Not matched: ").appendValue(item);
            return false;
        }
        return true;
    }

    function describeMismatch(matcher:Matcher<F>, item:F)
    {
        mismatchDescription.appendText("item " + nextMatchIx + ": ");
        matcher.describeMismatch(item, mismatchDescription);
    }
}
