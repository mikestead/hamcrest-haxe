/****
* Copyright 2011 hamcrest.org. See LICENSE.txt
****/

package org.hamcrest;

import haxe.PosInfos;

import org.hamcrest.core.AllOf;
import org.hamcrest.core.AnyOf;
import org.hamcrest.core.CombinableMatcher;
import org.hamcrest.core.DescribedAs;
import org.hamcrest.core.Every;
import org.hamcrest.core.Is;
import org.hamcrest.core.IsAnything;
import org.hamcrest.core.IsCollectionContaining;
import org.hamcrest.core.IsEqual;
import org.hamcrest.core.IsInstanceOf;
import org.hamcrest.core.IsNot;
import org.hamcrest.core.IsNull;
import org.hamcrest.core.IsSame;
import org.hamcrest.core.StringContains;
import org.hamcrest.core.StringEndsWith;
import org.hamcrest.core.StringStartsWith;
import org.hamcrest.number.OrderingComparison;
import org.hamcrest.number.IsCloseTo;
import org.hamcrest.collection.IsArray;
import org.hamcrest.collection.IsArrayWithSize;
import org.hamcrest.collection.IsArrayContaining;
import org.hamcrest.collection.IsArrayContainingInOrder;
import org.hamcrest.collection.IsArrayContainingInAnyOrder;
import org.hamcrest.collection.IsEmptyIterable;
import org.hamcrest.collection.IsIterableWithSize;
import org.hamcrest.collection.IsIterableContainingInOrder;
import org.hamcrest.collection.IsIterableContainingInAnyOrder;
import org.hamcrest.collection.IsHashContaining;
import org.hamcrest.internal.StringMap;

/**
 * Currently (Haxe 2.08, 10.9.11) it is not possible to import static methods to use in a class.
 * There is a feature request open for this http://code.google.com/p/haxe/issues/detail?id=365
 * (please go and star/vote for it!) but until it's resolved you'll need to extend this class.
 */
class MatchersBase
{
	private function new()
	{}

	public function assertThat<T>(valueOne:Dynamic, ?valueTwo:Dynamic, ?matcher:Matcher<T>, ?info:PosInfos)
	{
		MatcherAssert.assertThat(valueOne, valueTwo, matcher, info);
	}

    public function allOf<T>(first:Dynamic,
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

    public function anyOf<T>(first:Dynamic,
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

    public function both<LHS>(matcher:Matcher<LHS>):CombinableMatcher<LHS>
    {
        return CombinableMatcher.both(matcher);
    }

    public function either<LHS>(matcher:Matcher<LHS>):CombinableMatcher<LHS>
    {
        return CombinableMatcher.either(matcher);
    }

    public function describedAs<T>(description:String, matcher:Matcher<T>, ?values:Array<Dynamic>):Matcher<T>
    {
        return DescribedAs.describedAs(description, matcher, values);
    }

	public function everyItem<T>(itemMatcher:Matcher<T>):Matcher<Iterable<T>>
	{
		return Every.everyItem(itemMatcher);
	}

	public function is<T>(value:Dynamic):Matcher<T>
	{
		return Is.is(value);
	}

    public function anything(?description:String):Matcher<Dynamic>
    {
        return IsAnything.anything(description);
    }

    public function hasItem<T>(value:Dynamic):Matcher<Iterable<T>>
    {
    	return IsCollectionContaining.hasItem(value);
    }

    public function hasItems<T, U>(values:Array<U>):Matcher<Iterable<T>>
    {
    	return IsCollectionContaining.hasItems(values);
    }

//    public function equalTo<T>(operand:T):Matcher<T>
    public function equalTo<T>(operand:Dynamic):Matcher<T>
    {
        return IsEqual.equalTo(operand);
    }

	#if (!php || (php && haxe_210))
	public function instanceOf<T>(type:Dynamic):Matcher<T>
    {
        return IsInstanceOf.instanceOf(type);
    }
	#end

    public function any<T>(type:Dynamic):Matcher<T>
    {
        return IsInstanceOf.any(type);
    }

    public function not<T>(value:Dynamic):Matcher<T>
    {
		return IsNot.not(value);
    }

    public function nullValue<T>(?type:Class<T>):Matcher<T>
    {
    	return IsNull.nullValue(type);
    }

    public function notNullValue<T>(?type:Class<T>):Matcher<T>
    {
        return IsNull.notNullValue(type);
    }

    public function sameInstance<T>(object:T):Matcher<T>
    {
        return IsSame.sameInstance(object);
    }

    public function containsString(substring:String):Matcher<String>
    {
        return StringContains.containsString(substring);
    }

    public function endsWith(substring:String):Matcher<String>
    {
        return StringEndsWith.endsWith(substring);
    }

    public function startsWith(substring:String):Matcher<String>
    {
        return StringStartsWith.startsWith(substring);
    }

    /**
     * @return Is value = expected?
     */
    public function comparesEqualTo(value:Dynamic):Matcher<Dynamic>
    {
        return OrderingComparison.comparesEqualTo(value);
    }

    /**
     * Is value > expected?
     */
    public function greaterThan(value:Dynamic):Matcher<Dynamic>
    {
        return OrderingComparison.greaterThan(value);
    }

    /**
     * Is value >= expected?
     */
    public function greaterThanOrEqualTo(value:Dynamic):Matcher<Dynamic>
    {
        return OrderingComparison.greaterThanOrEqualTo(value);
    }

    /**
     * Is value < expected?
     */
    public function lessThan(value:Dynamic):Matcher<Dynamic>
    {
        return OrderingComparison.lessThan(value);
    }

    /**
     * Is value <= expected?
     */
    public function lessThanOrEqualTo(value:Dynamic):Matcher<Dynamic>
    {
        return OrderingComparison.lessThanOrEqualTo(value);
    }

    /**
     * Evaluates to true only if each matcher[i] is satisfied by array[i].
     */
    public function array<T>(first:Dynamic,
    							 ?second:Matcher<T> = null,
    							 ?third:Matcher<T> = null,
    							 ?fourth:Matcher<T> = null,
    							 ?fifth:Matcher<T> = null,
    							 ?sixth:Matcher<T> = null,
    							 ?seventh:Matcher<T> = null,
    							 ?eighth:Matcher<T> = null,
    							 ?ninth:Matcher<T> = null,
    							 ?tenth:Matcher<T> = null):IsArray<T>
    {
    	return IsArray.array(first, second, third, fourth, fifth, sixth, seventh, eighth, ninth, tenth);
    }

    /**
     * Evaluates to true if any item in an array satisfies the given matcher.
     */
    public function hasItemInArray<T>(element:Dynamic):Matcher<Array<T>>
    {
    	return IsArrayContaining.hasItemInArray(element);
    }

    public function closeTo(operand:Float, error:Float):Matcher<Float>
    {
        return new IsCloseTo(operand, error);
    }

    public function contains<T>(first:Dynamic,
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
		return IsIterableContainingInOrder.contains(first, second, third, fourth, fifth, sixth, seventh, eighth, ninth, tenth);
	}

    public function containsInAnyOrder<T>(first:Dynamic,
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
		return IsIterableContainingInAnyOrder.containsInAnyOrder(first, second, third, fourth, fifth, sixth, seventh, eighth, ninth, tenth);
	}

    public function arrayContainingInAnyOrder<T>(first:Dynamic,
				    							 ?second:Dynamic,
				    							 ?third:Dynamic,
				    							 ?fourth:Dynamic,
				    							 ?fifth:Dynamic,
				    							 ?sixth:Dynamic,
				    							 ?seventh:Dynamic,
				    							 ?eighth:Dynamic,
				    							 ?ninth:Dynamic,
				    							 ?tenth:Dynamic):Matcher<Array<T>>
	{
		return IsArrayContainingInAnyOrder.arrayContainingInAnyOrder(first, second, third, fourth, fifth, sixth, seventh, eighth, ninth, tenth);
	}

    public function arrayContaining<T>(first:Dynamic, ?second:Dynamic, ?third:Dynamic, ?fourth:Dynamic, ?fifth:Dynamic,
    									?sixth:Dynamic, ?seventh:Dynamic, ?eighth:Dynamic, ?ninth:Dynamic, ?tenth:Dynamic):Matcher<Array<T>>
	{
		return IsArrayContainingInOrder.arrayContaining(first, second, third, fourth, fifth, sixth, seventh, eighth, ninth, tenth);
	}

    public function arrayWithSize<T>(value:Dynamic):Matcher<Array<T>>
    {
    	return IsArrayWithSize.arrayWithSize(value);
    }

    public function emptyArray<E>():Matcher<Array<E>>
    {
    	return IsArrayWithSize.emptyArray();
    }

	public function emptyIterable<E>():Matcher<Iterable<E>>
    {
		return IsEmptyIterable.emptyIterable();
    }

    public function iterableWithSize<E>(value:Dynamic):Matcher<Iterable<E>>
    {
    	return IsIterableWithSize.iterableWithSize(value);
    }

    public function hasEntry<V>(key:Dynamic, value:Dynamic):Matcher<StringMap<V>>
    {
    	return IsHashContaining.hasEntry(key, value);
    }

    public function hasKey(key:Dynamic):Matcher<StringMap<Dynamic>>
    {
    	return IsHashContaining.hasKey(key);
    }

    public function hasValue<V>(value:Dynamic):Matcher<StringMap<V>>
    {
    	return IsHashContaining.hasValue(value);
    }
}
