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
    		throw new IllegalArgumentException("A matcher must be specified.", null, info);
    	
    	var matchers:Array<Matcher<T>> = getMatchers(first, second, third, fourth, fifth, 
	                                                    sixth, seventh, eighth, ninth, tenth);
    	return Type.createInstance(type, [matchers]);
    }

    static function getMatchers<T>(first:Dynamic,
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
			for (item in items) matchers.push(getMatcher(item));
    	}
    	else
    	{
    		matchers.push(getMatcher(first));
   	    }
   	    
    	if (second != null)	matchers.push(getMatcher(second));
    	if (third != null)	matchers.push(getMatcher(third));
    	if (fourth != null)	matchers.push(getMatcher(fourth));
    	if (fifth != null)	matchers.push(getMatcher(fifth));
    	if (sixth != null)	matchers.push(getMatcher(sixth));
    	if (seventh != null)matchers.push(getMatcher(seventh));
    	if (eighth != null)	matchers.push(getMatcher(eighth));
    	if (ninth != null)	matchers.push(getMatcher(ninth));
    	if (tenth != null)	matchers.push(getMatcher(tenth));
    	
    	return matchers;
    }

	static function getMatcher<T>(item:Dynamic):Matcher<T>
	{
		if (Std.is(item, Matcher))
			return cast item;
		else
			return IsEqual.equalTo(item);
	}
}
