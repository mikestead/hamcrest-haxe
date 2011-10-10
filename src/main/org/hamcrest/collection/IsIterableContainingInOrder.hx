/****
* Copyright 2011 hamcrest.org. See LICENSE.txt
****/

package org.hamcrest.collection;

import org.hamcrest.Description;
import org.hamcrest.Matcher;
import org.hamcrest.TypeSafeDiagnosingMatcher;
import org.hamcrest.core.IsEqual;
import org.hamcrest.Exception;
import org.hamcrest.TypedefChecker;
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
    	return TypedefChecker.isIterable(value);
    }

    override public function describeTo(description:Description)
    {
        description.appendText("iterable containing ").appendList("[", ", ", "]", matchers);
    }
    
    public static function contains<T>(first:Dynamic, 
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
//    	if (first == null)
//    		throw new IllegalArgumentException();
//    	
//    	var matchers:Array<Matcher<T>>;
//    	if (Std.is(first, Matcher) || Std.is(first, Array) && first.length > 0 && Std.is(first[0], Matcher))
//    		matchers = matchersFromMatchers(first, second, third, fourth, fifth, sixth, seventh, eighth, ninth, tenth);
//    	else
//    		matchers = matchersFromItems(first, second, third, fourth, fifth, sixth, seventh, eighth, ninth, tenth);
//    	
//    	return new IsIterableContainingInOrder<T>(matchers);
    }
    
//    static function matchersFromMatchers<T>(first:Dynamic, 
//			    							 ?second:Matcher<T>,
//			    							 ?third:Matcher<T>, 
//			    							 ?fourth:Matcher<T>, 
//			    							 ?fifth:Matcher<T>, 
//			    							 ?sixth:Matcher<T>, 
//			    							 ?seventh:Matcher<T>, 
//			    							 ?eighth:Matcher<T>, 
//			    							 ?ninth:Matcher<T>, 
//			    							 ?tenth:Matcher<T>):Array<Matcher<T>>
//    {
//    	var matchers:Array<Matcher<T>> = [];
//    	if (Std.is(first, Array))
//    	{
//    		matchers = cast first;
//    	}
//    	else if (Std.is(first, Matcher))
//    	{
//    		matchers.push(cast first);
//   	    }
//    	if (second != null)	matchers.push(second);
//    	if (third != null)	matchers.push(third);
//    	if (fourth != null)	matchers.push(fourth);
//    	if (fifth != null)	matchers.push(fifth);
//    	if (sixth != null)	matchers.push(sixth);
//    	if (seventh != null)matchers.push(seventh);
//    	if (eighth != null)	matchers.push(eighth);
//    	if (ninth != null)	matchers.push(ninth);
//    	if (tenth != null)	matchers.push(tenth);
//    	
//    	return matchers;
//    }
//    
//    static function matchersFromItems<T>(first:Dynamic, 
//		    							 ?second:Dynamic,
//		    							 ?third:Dynamic, 
//		    							 ?fourth:Dynamic, 
//		    							 ?fifth:Dynamic, 
//		    							 ?sixth:Dynamic, 
//		    							 ?seventh:Dynamic, 
//		    							 ?eighth:Dynamic, 
//		    							 ?ninth:Dynamic, 
//		    							 ?tenth:Dynamic):Array<Matcher<T>>
//    {
//    	var matchers:Array<Matcher<T>> = [];
//    	if (Std.is(first, Array))
//    	{
//    		var items:Array<Dynamic> = cast first;
//			for (item in items)
//				matchers.push(IsEqual.equalTo(item));
//    	}
//    	else
//    	{
//    		matchers.push(IsEqual.equalTo(first));
//   	    }
//    	if (second != null)	matchers.push(IsEqual.equalTo(second));
//    	if (third != null)	matchers.push(IsEqual.equalTo(third));
//    	if (fourth != null)	matchers.push(IsEqual.equalTo(fourth));
//    	if (fifth != null)	matchers.push(IsEqual.equalTo(fifth));
//    	if (sixth != null)	matchers.push(IsEqual.equalTo(sixth));
//    	if (seventh != null)matchers.push(IsEqual.equalTo(seventh));
//    	if (eighth != null)	matchers.push(IsEqual.equalTo(eighth));
//    	if (ninth != null)	matchers.push(IsEqual.equalTo(ninth));
//    	if (tenth != null)	matchers.push(IsEqual.equalTo(tenth));
//    	
//    	return matchers;
//    }
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
