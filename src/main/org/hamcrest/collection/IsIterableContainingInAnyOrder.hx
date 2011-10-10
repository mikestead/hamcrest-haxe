/****
* Copyright 2011 hamcrest.org. See LICENSE.txt
****/

package org.hamcrest.collection;

import org.hamcrest.Description;
import org.hamcrest.Matcher;
import org.hamcrest.TypeSafeDiagnosingMatcher;
import org.hamcrest.Exception;
import org.hamcrest.core.IsEqual;
import org.hamcrest.TypedefChecker;
import org.hamcrest.internal.VarArgMatchers;

class IsIterableContainingInAnyOrder<T> extends TypeSafeDiagnosingMatcher<Iterable<T>>
{
    var matchers:Array<Matcher<T>>;

    public function new(matchers:Array<Matcher<T>>)
    {
    	super();
        this.matchers = matchers;
    }
    
    override function matchesSafely(items:Iterable<T>, mismatchDescription:Description):Bool
    {
		var matching = new Matching<T>(matchers, mismatchDescription);
		for (item in items)
		{
			if (!matching.matches(item))
			{
				return false;
			}
		}
		return matching.isFinished(items);
    }
    
    override function isExpectedType(value:Dynamic):Bool
    {
    	return TypedefChecker.isIterable(value);
    }
    
    override function describeTo(description:Description)
    {
      description.appendText("iterable over ")
          .appendList("[", ", ", "]", matchers)
          .appendText(" in any order");
    }
    
    public static function containsInAnyOrder<E>(first:Dynamic, 
				    							 ?second:Dynamic,
				    							 ?third:Dynamic, 
				    							 ?fourth:Dynamic, 
				    							 ?fifth:Dynamic, 
				    							 ?sixth:Dynamic, 
				    							 ?seventh:Dynamic, 
				    							 ?eighth:Dynamic, 
				    							 ?ninth:Dynamic, 
				    							 ?tenth:Dynamic):Matcher<Iterable<E>>
    {
		return VarArgMatchers.newIterable(cast IsIterableContainingInAnyOrder, first, second, third, fourth, fifth, sixth, seventh, eighth, ninth, tenth);
    }
}

private class Matching<S>
{
	var matchers:Array<Matcher<S>>;
	var mismatchDescription:Description;
	
	public function new(matchers:Array<Matcher<S>>, mismatchDescription:Description)
	{
		this.matchers = matchers.concat([]);
		this.mismatchDescription = mismatchDescription;
	}
  
	public function matches(item:S):Bool
	{
    	return isNotSurplus(item) && isMatched(item);
    }
    
    public function isFinished(items:Iterable<S>):Bool
    {
    	if (matchers.length == 0)
    	{
    		return true;
    	}

		mismatchDescription
			.appendText("No item matches: ").appendList("", ", ", "", matchers)
			.appendText(" in ").appendValueList("[", ", ", "]", items);
		
		return false;
	}
	
  	function isMatched(item:S):Bool
  	{
  		var i = matchers.length;
  		for (i in 0...matchers.length)
  		{
			if (matchers[i].matches(item))
			{
 				matchers.splice(i, 1);
  				return true;
  			}
    	}
		mismatchDescription.appendText("Not matched: ").appendValue(item);
		return false;
	}
  
	function isNotSurplus(item:S):Bool
	{
		if (matchers.length == 0) {
			mismatchDescription.appendText("Not matched: ").appendValue(item);
      		return false;
    	}
    	return true;
  	}
}
