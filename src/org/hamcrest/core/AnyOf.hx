/****
* Copyright 2011 hamcrest.org. See LICENSE.txt
****/

package org.hamcrest.core;


import org.hamcrest.Description;
import org.hamcrest.Matcher;
import org.hamcrest.Exception;

/**
 * Calculates the logical disjunction of multiple matchers. Evaluation is shortcut, so
 * subsequent matchers are not called if an earlier matcher returns <code>true</code>.
 */
class AnyOf<T> extends ShortcutCombination<T>
{
    public function new(matchers:Iterable<Matcher<T>>)
    {
        super(matchers, "or"); 
    }

    override public function matches(value:Dynamic):Bool
    {
        return doesMatch(value, true);
    }
    
    public static function anyOf<T>(first:Dynamic, 
    							 ?second:Matcher<T> = null,
    							 ?third:Matcher<T> = null, 
    							 ?fourth:Matcher<T> = null, 
    							 ?fifth:Matcher<T> = null, 
    							 ?sixth:Matcher<T> = null, 
    							 ?seventh:Matcher<T> = null, 
    							 ?eighth:Matcher<T> = null, 
    							 ?ninth:Matcher<T> = null, 
    							 ?tenth:Matcher<T> = null):AnyOf<T>
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
    	
    	return new AnyOf<T>(matchers);
    }
}

