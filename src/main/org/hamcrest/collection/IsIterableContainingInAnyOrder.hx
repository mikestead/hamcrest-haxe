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
//
//    	if (first == null)
//    		throw new IllegalArgumentException();
//    	
//    	var matchers:Array<Matcher<T>>;
//    	if (Std.is(first, Matcher) || Std.is(first, Array) && first.length > 0 && Std.is(first[0], Matcher))
//    		matchers = matchersFromMatchers(first, second, third, fourth, fifth, sixth, seventh, eighth, ninth, tenth);
//    	else
//    		matchers = matchersFromItems(first, second, third, fourth, fifth, sixth, seventh, eighth, ninth, tenth);
//    	
//    	return new IsIterableContainingInAnyOrder<T>(matchers);
    }
//    
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
