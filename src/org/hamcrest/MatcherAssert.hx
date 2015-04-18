/****
* Copyright 2011 hamcrest.org. See LICENSE.txt
****/

package org.hamcrest;

import org.hamcrest.Exception;
import haxe.PosInfos;

class MatcherAssert
{
	private function new()
	{}

	/**
		Assert that a value is true, or that its Matcher successfully matches the value.
		
		@param actual If no Matcher is defined then must be a boolean, otherwise can be any value.
		@param matcher Matcher used to validate `actual`.
		@param reason Optional description outlining reasoning for match
	**/
	public static function assertThat<T>(actual:Dynamic, ?matcher:Matcher<T>, ?reason:String, ?info:PosInfos)
	{
		if (reason == null) reason = "";
		
		if (matcher != null)
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
		else if (Std.is(actual, Bool))
		{
			if (!actual)
			{
				throw new AssertionException(reason, null, info);
			}
		}
		else
		{
			throw new IllegalArgumentException("If no Matcher defined then 'actual' must be of type Bool.");
		}
	}

	
//	public static function assertThat2<T>(valueOne:Dynamic, ?valueTwo:Dynamic, ?matcher:Matcher<T>, ?info:PosInfos)
//	{
//		if (Std.is(valueOne, String) && matcher != null)
//		{
//			assertThatMatch(valueOne, valueTwo, matcher, info);
//		}
//		else if (/*Std.is(valueOne, T) &&*/ Std.is(valueTwo, Matcher) && matcher == null)
//		{
//			assertThatMatch("", valueOne, valueTwo, info);
//		}
//		else if (Std.is(valueOne, String) && Std.is(valueTwo, Bool) && matcher == null)
//		{
//			assertThatBool(valueOne, valueTwo, info);
//		}
//		else if (Std.is(valueOne, Bool) && valueTwo == null && matcher == null)
//		{
//			assertThatBool("", valueOne, info);
//		}
//		else
//		{
//			throw new IllegalArgumentException("Argument(s) where not of the expected type(s).");
//		}
//	}
//
//	static function assertThatMatch<T>(reason:String, actual:T, matcher:Matcher<T>, info:PosInfos)
//	{
//        if (!matcher.matches(actual))
//        {
//            var description = new StringDescription();
//            description.appendText(reason)
//            		   .appendText("\nExpected: ")
//                       .appendDescriptionOf(matcher)
//                       .appendText("\n     but: ");
//            matcher.describeMismatch(actual, description);
//
//            throw new AssertionException(description.toString(), null, info);
//        }
//	}
//
//    static function assertThatBool(reason:String, assertion:Bool, info:PosInfos)
//    {
//        if (!assertion)
//            throw new AssertionException(reason, null, info);
//    }
}
