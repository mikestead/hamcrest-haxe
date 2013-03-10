/****
* Copyright 2011 hamcrest.org. See LICENSE.txt
****/

package org.hamcrest.internal;

import org.hamcrest.Matcher;
import org.hamcrest.Exception;
import org.hamcrest.core.IsEqual;
import haxe.PosInfos;

class VarArgMatchers
{
    public static function newIterable<T>(type:Class<Matcher<Iterable<T>>>, 
										first:Dynamic, 
	    								?second:Dynamic,
	    								?third:Dynamic, 
	    								?fourth:Dynamic, 
	    								?fifth:Dynamic, 
	    								?sixth:Dynamic, 
	    								?seventh:Dynamic, 
	    								?eighth:Dynamic, 
	    								?ninth:Dynamic, 
	    								?tenth:Dynamic,
	    								?info:PosInfos):Matcher<Iterable<T>>
	{
    	if (first == null)
    		throw new IllegalArgumentException("Argument could not be processed.", null, info);
    	
    	var matchers:Array<Matcher<T>>;
    	if (Std.is(first, Matcher) || Std.is(first, Array) && first.length > 0 && Std.is(first[0], Matcher))
    		matchers = matchersFromMatchers(first, second, third, fourth, fifth, sixth, seventh, eighth, ninth, tenth);
    	else
    		matchers = matchersFromItems(first, second, third, fourth, fifth, sixth, seventh, eighth, ninth, tenth);
    	
    	return Type.createInstance(type, [matchers]);
    }
    
    static function matchersFromMatchers<T>(first:Dynamic, 
			    							 ?second:Matcher<T>,
			    							 ?third:Matcher<T>, 
			    							 ?fourth:Matcher<T>, 
			    							 ?fifth:Matcher<T>, 
			    							 ?sixth:Matcher<T>, 
			    							 ?seventh:Matcher<T>, 
			    							 ?eighth:Matcher<T>, 
			    							 ?ninth:Matcher<T>, 
			    							 ?tenth:Matcher<T>):Array<Matcher<T>>
    {
    	var matchers:Array<Matcher<T>> = [];
    	if (Std.is(first, Array))
    	{
    		matchers = cast first;
    	}
    	else if (Std.is(first, Matcher))
    	{
    		matchers.push(cast first);
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
    	
    	return matchers;
    }
    
    static function matchersFromItems<T>(first:Dynamic, 
		    							 ?second:Dynamic,
		    							 ?third:Dynamic, 
		    							 ?fourth:Dynamic, 
		    							 ?fifth:Dynamic, 
		    							 ?sixth:Dynamic, 
		    							 ?seventh:Dynamic, 
		    							 ?eighth:Dynamic, 
		    							 ?ninth:Dynamic, 
		    							 ?tenth:Dynamic):Array<Matcher<T>>
    {
    	var matchers:Array<Matcher<T>> = [];
    	if (Std.is(first, Array))
    	{
    		var items:Array<Dynamic> = cast first;
			for (item in items)
				matchers.push(IsEqual.equalTo(item));
    	}
    	else
    	{
    		matchers.push(IsEqual.equalTo(first));
   	    }
   	    
    	if (second != null)	matchers.push(IsEqual.equalTo(second));
    	if (third != null)	matchers.push(IsEqual.equalTo(third));
    	if (fourth != null)	matchers.push(IsEqual.equalTo(fourth));
    	if (fifth != null)	matchers.push(IsEqual.equalTo(fifth));
    	if (sixth != null)	matchers.push(IsEqual.equalTo(sixth));
    	if (seventh != null)matchers.push(IsEqual.equalTo(seventh));
    	if (eighth != null)	matchers.push(IsEqual.equalTo(eighth));
    	if (ninth != null)	matchers.push(IsEqual.equalTo(ninth));
    	if (tenth != null)	matchers.push(IsEqual.equalTo(tenth));
    	
    	return matchers;
    }
}