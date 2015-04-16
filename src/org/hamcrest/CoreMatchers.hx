package org.hamcrest;

import org.hamcrest.core.StringEndsWith;
import org.hamcrest.core.StringStartsWith;
import org.hamcrest.core.StringContains;
import org.hamcrest.core.IsSame;
import org.hamcrest.core.IsNull;
import org.hamcrest.core.IsNot;
import org.hamcrest.core.IsInstanceOf;
import org.hamcrest.core.IsEqual;
import org.hamcrest.core.IsCollectionContaining;
import org.hamcrest.core.IsAnything;
import org.hamcrest.core.Is;
import org.hamcrest.core.Every;
import org.hamcrest.core.DescribedAs;
import org.hamcrest.core.CombinableMatcher;
import org.hamcrest.core.CombinableMatcher;
import org.hamcrest.core.AnyOf;
import org.hamcrest.core.AllOf;

/**
	Provides a shortcut to import all or specific core Matchers.
	
	```
	import org.hamcrest.CoreMatchers.*;
	```
**/
class CoreMatchers
{
	private function new() {}

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
		return AllOf.allOf(first, second, third, fourth, fifth, sixth, seventh, eighth, ninth, tenth);
	}

	public static function anyOf<T>(first:Dynamic,
	                         ?second:Matcher<T>,
	                         ?third:Matcher<T>,
	                         ?fourth:Matcher<T>,
	                         ?fifth:Matcher<T>,
	                         ?sixth:Matcher<T>,
	                         ?seventh:Matcher<T>,
	                         ?eighth:Matcher<T>,
	                         ?ninth:Matcher<T>,
	                         ?tenth:Matcher<T>):AnyOf<T>
	{
		return AnyOf.anyOf(first, second, third, fourth, fifth, sixth, seventh, eighth, ninth, tenth);
	}

	public static function both<LHS>(matcher:Matcher<LHS>):CombinableMatcher<LHS>
	{
		return CombinableMatcher.both(matcher);
	}

	public static function either<LHS>(matcher:Matcher<LHS>):CombinableMatcher<LHS>
	{
		return CombinableMatcher.either(matcher);
	}

	public static function describedAs<T>(description:String, matcher:Matcher<T>, ?values:Array<Dynamic>):Matcher<T>
	{
		return DescribedAs.describedAs(description, matcher, values);
	}

	public static function everyItem<T>(itemMatcher:Matcher<T>):Matcher<Iterable<T>>
	{
		return Every.everyItem(itemMatcher);
	}

	public static function is<T>(value:Dynamic):Matcher<T>
	{
		return Is.is(value);
	}

	public static function anything(?description:String):Matcher<Dynamic>
	{
		return IsAnything.anything(description);
	}

	public static function hasItem<T>(value:Dynamic):Matcher<Iterable<T>>
	{
		return IsCollectionContaining.hasItem(value);
	}

	public static function hasItems<T, U>(values:Array<U>):Matcher<Iterable<T>>
	{
		return IsCollectionContaining.hasItems(values);
	}

	public static function equalTo<T>(operand:Dynamic):Matcher<T>
	{
		return IsEqual.equalTo(operand);
	}

	public static function instanceOf<T>(type:Dynamic):Matcher<T>
	{
		return IsInstanceOf.instanceOf(type);
	}

	public static function any<T>(type:Dynamic):Matcher<T>
	{
		return IsInstanceOf.any(type);
	}

	public static function not<T>(value:Dynamic):Matcher<T>
	{
		return IsNot.not(value);
	}

	public static function nullValue<T>(?type:Class<T>):Matcher<T>
	{
		return IsNull.nullValue(type);
	}

	public static function notNullValue<T>(?type:Class<T>):Matcher<T>
	{
		return IsNull.notNullValue(type);
	}

	public static function sameInstance<T>(object:T):Matcher<T>
	{
		return IsSame.sameInstance(object);
	}

	public static function containsString(substring:String):Matcher<String>
	{
		return StringContains.containsString(substring);
	}

	public static function startsWith(substring:String):Matcher<String>
	{
		return StringStartsWith.startsWith(substring);
	}

	public static function endsWith(substring:String):Matcher<String>
	{
		return StringEndsWith.endsWith(substring);
	}
}
