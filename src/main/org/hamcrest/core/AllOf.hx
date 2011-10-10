/****
* Copyright 2011 hamcrest.org. See LICENSE.txt
****/

package org.hamcrest.core;

import org.hamcrest.Description;
import org.hamcrest.DiagnosingMatcher;
import org.hamcrest.Matcher;
import org.hamcrest.Exception;


/**
 * Calculates the logical conjunction of multiple matchers. Evaluation is shortcut, so
 * subsequent matchers are not called if an earlier matcher returns <code>false</code>.
 */
class AllOf<T> extends DiagnosingMatcher<T>
{
	var matchers:Iterable<Matcher<T>>;

    public function new(matchers:Iterable<Matcher<T>>)
    {
    	super();
    	this.matchers = matchers;
    }

    override function isMatch(value:Dynamic, mismatchDescription:Description):Bool
    {
    	for (matcher in matchers)
    	{
            if (!matcher.matches(value))
            {
            	mismatchDescription.appendDescriptionOf(matcher).appendText(" ");
            	matcher.describeMismatch(value, mismatchDescription);
            	return false;
            }
        }
    	return true;
    }

    override public function describeTo(description:Description):Void
    {
    	description.appendList("(", " " + "and" + " ", ")", matchers);
    }
    
    public static function allOf<T>(first:Dynamic, 
    							 ?second:Matcher<T>,
    							 ?third:Matcher<T>, 
    							 ?fourth:Matcher<T>, 
    							 ?fifth:Matcher<T>, 
    							 ?sixth:Matcher<T>, 
    							 ?seventh:Matcher<T>, 
    							 ?eighth:Matcher<T>, 
    							 ?ninth:Matcher<T>, 
    							 ?tenth:Matcher<T>):AllOf<T>
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

    	return new AllOf<T>(matchers);
    }
}
