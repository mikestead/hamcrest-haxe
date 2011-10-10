/****
* Copyright 2011 hamcrest.org. See LICENSE.txt
****/

/*  Copyright (c) 2000-2006 hamcrest.org
 */
package org.hamcrest;

import org.hamcrest.Exception;
import haxe.PosInfos;

class MatcherAssert 
{
	private function new()
	{}
	
	public static function assertThat<T>(valueOne:Dynamic, ?valueTwo:Dynamic, ?matcher:Matcher<T>, ?info:PosInfos)
	{
		if (matcher != null && Std.is(valueOne, String) /*&& Std.is(valueTwo, T)*/)
		{
			assertThatMatch(valueOne, valueTwo, matcher, info);
		}
		else if (/*Std.is(valueOne, T) &&*/ Std.is(valueTwo, Matcher) && matcher == null)
		{
			assertThatMatch("", valueOne, valueTwo, info);
		}
		else if (Std.is(valueOne, String) && matcher == null)
		{
			assertThatBool(valueOne, cast(valueTwo, Bool), info);
		}
		else if (valueTwo == null && matcher == null)
		{
			assertThatBool("", valueOne, info);
		}
		else
		{
			throw new IllegalArgumentException("Argument(s) where not of the expected type(s).");
		}
	}
	
	private static function assertThatMatch<T>(reason:String, actual:T, matcher:Matcher<T>, info:PosInfos)
	{
        if (!matcher.matches(actual)) 
        {
            var description = new StringDescription();
            description.appendText(reason)
            		   .appendText("\nExpected: ")
                       .appendDescriptionOf(matcher)
                       .appendText("\n     but: ");
            matcher.describeMismatch(actual, description);
            
            throw new AssertionException(description.toString(), null, info);
        }
	}
    
    private static function assertThatBool(reason:String, assertion:Bool, info:PosInfos)
    {
        if (!assertion)
            throw new AssertionException(reason, null, info);
    }
}
