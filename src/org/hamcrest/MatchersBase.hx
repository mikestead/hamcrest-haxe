package org.hamcrest;

import haxe.PosInfos;
import org.hamcrest.collection.IsArray;
import org.hamcrest.collection.IsEmptyIterable;
import org.hamcrest.collection.IsIterableWithSize;
import org.hamcrest.collection.IsIterableContainingInOrder;
import org.hamcrest.collection.IsIterableContainingInAnyOrder;
import org.hamcrest.collection.IsHashContaining;
import org.hamcrest.number.IsCloseTo;
import org.hamcrest.number.OrderingComparison;
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
	Base class to extend to inherit shortcuts to all Matchers.
	
	_Now that Haxe supports importing of static functions, `import org.hamcrest.Matchers.*`
	is now the prefered approach_.
	
	@deprecated use `org.hamcrest.Matchers` instead.
**/
class MatchersBase
{
	private function new()
	{}

	/**
		Assert that a value is true, or that its Matcher successfully matches the value.
		
		Not strictly a Matcher, but included here for import convenience.
		
		@param actual If no Matcher is defined then must be a boolean, otherwise can be any value.
		@param matcher Matcher used to validate `actual`.
		@param reason Optional description outlining reasoning for match
	**/
	function assertThat<T>(actual:Dynamic, ?matcher:Matcher<T>, ?reason:String, ?info:PosInfos)
	{
		MatcherAssert.assertThat(actual, matcher, reason, info);
	}
	// Core Matchers

	/**
		Creates a matcher that matches if the examined object matches *ALL* of the specified matchers.
		
		For example: 
		`assertThat("myValue", allOf(startsWith("my"), containsString("Val")))`.
	**/
	function allOf<T>(first:Dynamic,
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

	/**
		Creates a matcher that matches if the examined object matches *ANY* of the specified matchers.
		
		For example: 
		`assertThat("myValue", anyOf(startsWith("foo"), containsString("Val")))`.
	**/
	function anyOf<T>(first:Dynamic,
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

	/**
		Creates a matcher that matches when both of the specified matchers match the examined object.
		
		For example: 
		`assertThat("fab", both(containsString("a")).and(containsString("b")))`.
	**/
	function both<LHS>(matcher:Matcher<LHS>):CombinableMatcher<LHS>
	{
		return CombinableMatcher.both(matcher);
	}

	/**
		Creates a matcher that matches when either of the specified matchers match the examined object.
		
		For example: 
		`assertThat("fan", either(containsString("a")).or(containsString("b")))`.
	**/
	function either<LHS>(matcher:Matcher<LHS>):CombinableMatcher<LHS>
	{
		return CombinableMatcher.either(matcher);
	}

	/**
		Wraps an existing matcher, overriding its description with that specified.  
		All other functions are delegated to the decorated matcher, including its 
		mismatch description.

		For example:
		`describedAs("an integer equal to %0", equalTo(myInteger), Std.string(myInteger))`.

		@param description the new description for the wrapped matcher
		@param matcher the matcher to wrap
		@param values optional values to insert into the tokenised description
	**/
	function describedAs<T>(description:String, matcher:Matcher<T>, ?values:Array<Dynamic>):Matcher<T>
	{
		return DescribedAs.describedAs(description, matcher, values);
	}

	/**
		Creates a matcher for `Iterable`s that only matches when a single pass over the
		examined `Iterable` yields items that are all matched by the specified `itemMatcher`.

		For example:
		`assertThat(["bar", "baz"], everyItem(startsWith("ba")))`.

		@param itemMatcher the matcher to apply to every item provided by the examined {@link Iterable}
	**/
	function everyItem<T>(itemMatcher:Matcher<T>):Matcher<Iterable<T>>
	{
		return Every.everyItem(itemMatcher);
	}

	/**
		A shortcut to the frequently used `is(equalTo(x))`.
		
		For example:
		`assertThat(cheese, is(smelly))`.
		
		If `value` is a `Matcher` then decorates this Matcher, retaining its behaviour, 
		but allowing tests to be slightly more expressive.
		
		For example:
		`assertThat(cheese, is(equalTo(smelly)))`.
		
		instead of:
		`assertThat(cheese, equalTo(smelly))`.
	**/
	function is<T>(value:Dynamic):Matcher<T>
	{
		return Is.is(value);
	}

	/**
		A shortcut to the frequently used <code>is(instanceOf(SomeClass.class))</code>.
		
		For example:
		`assertThat(cheese, isA(Cheddar.class))`.

		instead of:
		`assertThat(cheese, is(instanceOf(Cheddar.class)))`.
	**/
	function isA<T>(type:Class<Dynamic>):Matcher<T>
	{
		return Is.isA(type);
	}

	/**
		Creates a matcher that always matches, regardless of the examined object.
		
		@param description an optional meaningful description of itself
	**/
	function anything(?description:String):Matcher<Dynamic>
	{
		return IsAnything.anything(description);
	}

	/**
		Creates a matcher for `Iterable`s that only matches when a single pass over the
		examined `Iterable` yields at least one item that is matched by the specified
		`value`. If `value` is a matcher then it will be applied against each element,
		otherwise `value` will be compared with each element. 
		
		Whilst matching, the traversal of the examined `Iterable` will stop as soon as 
		a matching item is found.
		
		For example:
		`assertThat(["foo", "bar"], hasItem(startsWith("ba")))`.
		
		Or:
		`assertThat(["foo", "bar"], hasItem("bar"))`.
		 
		@param value the matcher to apply or value to compare to items provided by the examined `Iterable`
	**/
	function hasItem<T>(value:Dynamic):Matcher<Iterable<T>>
	{
		return IsCollectionContaining.hasItem(value);
	}

	/**
		Creates a matcher for `Iterable`s that matches when consecutive passes over the
		examined `Iterable` yield at least one item that is, a) matched by the `value` when
		`value` is a Matcher, or b) equal to the a corrosponding item from the array of values.
		
		Whilst matching, each traversal of the examined `Iterable` will stop as soon as
		a matching item is found.

		For example:
		`assertThat(["foo", "bar", "baz"], hasItems([endsWith("z"), endsWith("o")]))`.
		
		Or:
		`assertThat(["foo", "bar", "baz"], hasItems(["baz", "foo"]))`.

		@param itemMatchers the matchers to apply to items provided by the examined {@link Iterable}
	**/
	function hasItems<T, U>(values:Array<U>):Matcher<Iterable<T>>
	{
		return IsCollectionContaining.hasItems(values);
	}

	/**
		Creates a matcher that matches when the examined object is logically equal to the specified
		`operand`, as determined by:

		1) If the operand is an enum then `Type.enumEq` is used.
		2) If examined object being compared to `operand` has an `equals` method this is called
			passing the `operand` and expects a boolean outcome. If it doesn't have this method
			but `operand` does then it will be called passing it the examined object.
		3) Direct comparison.

		The created matcher also provides a special behaviour when examining `Array`s, whereby
		it will match if both the operand and the examined object are arrays of the same length
		and contain items that are equal to each other (according to the above rules), in the same
		indexes.

		For example:
		```
		assertThat("foo", equalTo("foo"));
		assertThat(["foo", "bar"], equalTo(["foo", "bar"]));
		```
	**/
	function equalTo<T>(operand:Dynamic):Matcher<T>
	{
		return IsEqual.equalTo(operand);
	}

	/**
		Creates a matcher that matches when the examined object is an instance of the 
		specified `type`, as determined by calling the `Std.is`, passing the examined object.

		The created matcher assumes no relationship between specified type and the examined object.

		For example:
		`assertThat(new Canoe(), instanceOf(Paddlable))`.
	**/
	function instanceOf<T>(type:Dynamic):Matcher<T>
	{
		return IsInstanceOf.instanceOf(type);
	}

	/**
		Creates a matcher that wraps an existing matcher or value, but inverts the logic by which 
		it will match.

		For example:
		`assertThat(cheese, is(not(equalTo(smelly))))`.
		
		Or:
		`assertThat(cheese, is(not(smelly)))`.

		@param matcher the matcher whose sense should be inverted
	**/
	function not<T>(value:Dynamic):Matcher<T>
	{
		return IsNot.not(value);
	}

	/**
		A shortcut to the frequently used `not(nullValue())`.
		
		For example:
		`assertThat(cheese, is(notNullValue()))`.
		
		instead of:
		`assertThat(cheese, is(not(nullValue())))`.
		
		@param type Optional dummy parameter used to infer the generic type of the returned matcher
	**/
	function notNullValue<T>(?type:Class<T>):Matcher<T>
	{
		return IsNull.notNullValue(type);
	}

	/**
		Creates a matcher that matches if examined object is `null`.
		
		For example:
		`assertThat(cheese, is(nullValue())`.
		
		@param type Optional dummy parameter used to infer the generic type of the returned matcher
	**/
	function nullValue<T>(?type:Class<T>):Matcher<T>
	{
		return IsNull.nullValue(type);
	}

	/**
		Creates a matcher that matches only when the examined object is the same instance as
		the specified target object.
		
		For example:
		`assertThat(cheese, is(theInstance(cheese))`.
		
		@param target the target instance against which others should be assessed
	**/
	function theInstance<T>(target:T):Matcher<T>
	{
		return IsSame.theInstance(target);
	}

	/**
		Creates a matcher that matches if the examined `String` contains the specified 
		`String` anywhere.

		For example:
		`assertThat("myStringOfNote", containsString("ring"))`.

		@param substring the substring that the returned matcher will expect to find within any examined string
	**/
	function containsString(substring:String):Matcher<String>
	{
		return StringContains.containsString(substring);
	}

	/**
		Creates a matcher that matches if the examined `String` starts with the specified `String`.
		
		For example:
		`assertThat("myStringOfNote", startsWith("my"))`.
		
		@param prefix the substring that the returned matcher will expect at the 
					start of any examined string
	**/
	function startsWith(prefix:String):Matcher<String>
	{
		return StringStartsWith.startsWith(prefix);
	}

	/**
		Creates a matcher that matches if the examined {@link String} ends with the specified `String`.

		For example:
		`assertThat("myStringOfNote", endsWith("Note"))`.
	
		@param suffix the substring that the returned matcher will expect at the
					end of any examined string
	**/
	function endsWith(suffix:String):Matcher<String>
	{
		return StringEndsWith.endsWith(suffix);
	}

	// Comparison

	/**
		Creates a matcher of comparable object that matches when the examined object is
		equal to the specified value.
		
		Comparison is made by either:
		- `Reflect.compare` for numeric or string primitives
		- If a `Date` then `date.getTime()` will be used to compare. Supports comparison of Dates with Floats.
		- If an object, then a `compareTo` method is checked for. This should take a single parameter and return
		 a signum.

		For example:
		`assertThat(1, comparesEqualTo(1))`.
		
		Or:
		`assertThat(dateOne, comparesEqualTo(dateTwo))`.

		@param value the value which, when passed to the `Reflect.compare` or a `compareTo` 
				method of the examined object, should return zero.
	**/
	function comparesEqualTo(value:Dynamic):Matcher<Dynamic>
	{
		return OrderingComparison.comparesEqualTo(value);
	}

	/**
		Creates a matcher of comparable object that matches when the examined object is
		greater than the specified value.
		
		Comparison is made by either:
		- `Reflect.compare` for numeric or string primitives
		- If a `Date` then `date.getTime()` will be used to compare. Supports comparison of Dates with Floats.
		- If an object, then a `compareTo` method is checked for. This should take a single parameter and return
		 a signum.

		For example:
		`assertThat(2.7, greaterThan(1.9))`.
		
		Or:
		`assertThat(dateOne, greaterThan(dateTwo))`.

		@param value the value which, when passed to the `Reflect.compare` or a `compareTo` 
				method of the examined object, should return greater than zero.
	**/
	function greaterThan(value:Dynamic):Matcher<Dynamic>
	{
		return OrderingComparison.greaterThan(value);
	}

	/**
		Creates a matcher of comparable object that matches when the examined object is
		greater than or equal to the specified value.
		
		Comparison is made by either:
		- `Reflect.compare` for numeric or string primitives
		- If a `Date` then `date.getTime()` will be used to compare. Supports comparison of Dates with Floats.
		- If an object, then a `compareTo` method is checked for. This should take a single parameter and return
		 a signum.

		For example:
		`assertThat("bb", greaterThanOrEqualTo("aa"))`.
		
		Or:
		`assertThat(1, greaterThanOrEqualTo(1))`.

		@param value the value which, when passed to the `Reflect.compare` or a `compareTo` 
				method of the examined object, should return zero or higher.
	**/
	function greaterThanOrEqualTo(value:Dynamic):Matcher<Dynamic>
	{
		return OrderingComparison.greaterThanOrEqualTo(value);
	}

	/**
		Creates a matcher of comparable object that matches when the examined object is
		less than the specified value.
		
		Comparison is made by either:
		- `Reflect.compare` for numeric or string primitives
		- If a `Date` then `date.getTime()` will be used to compare. Supports comparison of Dates with Floats.
		- If an object, then a `compareTo` method is checked for. This should take a single parameter and return
		 a signum.

		For example:
		`assertThat(1.9, lessThan(2.7))`.
		
		Or:
		`assertThat(dateOne, lessThan(dateTwo))`.

		@param value the value which, when passed to the `Reflect.compare` or a `compareTo` 
				method of the examined object, should return less than zero.
	**/
	function lessThan(value:Dynamic):Matcher<Dynamic>
	{
		return OrderingComparison.lessThan(value);
	}

	/**
		Creates a matcher of comparable object that matches when the examined object is
		less or equal than the specified value.
		
		Comparison is made by either:
		- `Reflect.compare` for numeric or string primitives
		- If a `Date` then `date.getTime()` will be used to compare. Supports comparison of Dates with Floats.
		- If an object, then a `compareTo` method is checked for. This should take a single parameter and return
		 a signum.

		For example:
		`assertThat(1.9, lessThanOrEqualTo(2.7))`.
		
		Or:
		`assertThat(dateOne, lessThanOrEqualTo(dateTwo))`.

		@param value the value which, when passed to the `Reflect.compare`, or a `compareTo` 
				method of the examined object, should return zero or lower.
	**/
	function lessThanOrEqualTo(value:Dynamic):Matcher<Dynamic>
	{
		return OrderingComparison.lessThanOrEqualTo(value);
	}

	/**
		Creates a matcher of `Float`s that matches when an examined float is equal
		to the specified `operand`, within a range of +/- `error`.
		
		For example:
		`assertThat(1.03, is(closeTo(1.0, 0.03)))`.
		
		@param operand the expected value of matching floats
		@param error the delta (+/-) within which matches will be allowed
	**/
	function closeTo(operand:Float, error:Float):Matcher<Float>
	{
		return new IsCloseTo(operand, error);
	}

	// Collection

	/**
		Creates a matcher that matches arrays whose elements are satisfied by the specified matchers.
		Matches positively only if the number of matchers specified is equal to the length of the 
		examined array and each matcher[i] is satisfied by array[i].
		
		For example:
		`assertThat([1,2,3], is(array(equalTo(1), equalTo(2), equalTo(3))))`.
		
		Or:
		`assertThat([1,2,3], is(array(1, 2, 3)))`.
		
		@param first Either an array of Matchers or a single Matcher that the elements of examined arrays should satisfy
	**/
	function array<T>(first:Dynamic,
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
		Creates a matcher for `Iterable`s that matches when a single pass over the
		examined `Iterable` yields a series of items, each satisfying the corresponding
		matcher in the specified matchers.  For a positive match, the examined iterable
		must be of the same length as the number of specified matchers.
		
		For example:
		`assertThat(["foo", "bar"], containsInOrder(equalTo("foo"), equalTo("bar")))`.
		
		For convenience you can also pass values instead of matchers when using direct comparison.
		
		For example:
		`assertThat(["foo", "bar"], containsInOrder("foo", "bar"))`.

		instead of:
		`assertThat(["foo", "bar"], containsInOrder(equalTo("foo"), equalTo("bar")))`.
		
		@param first Either a Matcher to match the first element of the iterable, a value to 
					perform direct comparison of first element of iterable, or an array of Matchers
					to match each element of the iterable
		@param second   a Matcher or a value to compare each element of iterable against
		@param third    a Matcher or a value to compare each element of iterable against
		@param fourth   a Matcher or a value to compare each element of iterable against
		@param fifth    a Matcher or a value to compare each element of iterable against
		@param sixth    a Matcher or a value to compare each element of iterable against
		@param seventh  a Matcher or a value to compare each element of iterable against
		@param eighth   a Matcher or a value to compare each element of iterable against
		@param ninth    a Matcher or a value to compare each element of iterable against
		@param tenth    a Matcher or a value to compare each element of iterable against
	**/
	function containsInOrder<T>(first:Dynamic,
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
		return IsIterableContainingInOrder.containsInOrder(first, second, third, fourth, fifth, sixth, seventh, eighth, ninth, tenth);
	}

	/**
		Creates an order agnostic matcher for `Iterable`s that matches when a single pass over
		the examined `Iterable` yields a series of items, each satisfying one matcher anywhere
		in the specified matchers.  For a positive match, the examined iterable must be of the
		same length as the number of specified matchers.
		
		N.B. each of the specified matchers will only be used once during a given examination,
		so be careful when specifying matchers that may be satisfied by more than one entry in
		an examined iterable.
		
		For example:
		`assertThat(["foo", "bar"], containsInAnyOrder(equalTo("bar"), equalTo("foo")))`.
		
		For convenience you can also pass values instead of matchers when using direct comparison.
		
		For example:
		`assertThat(["foo", "bar"], containsInAnyOrder("foo", "bar"))`.

		instead of:
		`assertThat(["foo", "bar"], containsInAnyOrder(equalTo("foo"), equalTo("bar")))`.
		
		@param first Either a Matcher to match an element of the iterable, a value to 
					perform direct comparison of an element of iterable, or an array of Matchers
					to match elements of the iterable
		@param second   a Matcher or a value to compare each element of iterable against
		@param third    a Matcher or a value to compare each element of iterable against
		@param fourth   a Matcher or a value to compare each element of iterable against
		@param fifth    a Matcher or a value to compare each element of iterable against
		@param sixth    a Matcher or a value to compare each element of iterable against
		@param seventh  a Matcher or a value to compare each element of iterable against
		@param eighth   a Matcher or a value to compare each element of iterable against
		@param ninth    a Matcher or a value to compare each element of iterable against
		@param tenth    a Matcher or a value to compare each element of iterable against
	**/
	function containsInAnyOrder<T>(first:Dynamic,
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


	/**
		Creates a matcher for iterables that matches when the `length` of the iterable
		satisfies the specified matcher. An integer may also be used for convenience.
		
		For example:
		`assertThat(["foo", "bar"], hasSize(equalTo(2)))`.
		
		Or:
		`assertThat(["foo", "bar"], hasSize(2))`.
		
		@param value either a size Matcher or integer to compare the length of the iterable
	**/
	function hasSize<T>(value:Dynamic):Matcher<Iterable<T>>
	{
		return IsIterableWithSize.hasSize(value);
	}

	/**
		Creates a matcher for iterables that matches when the `length` of the iterable is 0.
		
		For example:
		`assertThat([], isEmpty())`.
	**/
	function isEmpty<E>():Matcher<Iterable<E>>
	{
		return IsEmptyIterable.isEmpty();
	}

	/**
		Creates a matcher for `Map`s matching when the examined `Map` contains at least one 
		entry whose key satisfies the specified `key` Matcher *and* whose value satisfies the 
		specified `value` Matcher.
		
		For example:
		`assertThat(myMap, hasEntry(equalTo("bar"), equalTo("foo")))`.
		
		For convenience you can provide values instead of matchers for direct equality comparison.
		
		For example:
		`assertThat(myMap, hasEntry("bar", "foo"))`.
		
		@param key a key Matcher that, in combination with the value Matcher, must be satisfied 
					by at least one entry. Can also be an element to compare key against
		@param value the value matcher that, in combination with the key Matcher, must be satisfied
					by at least one entry. Can also be an element to compare value against
	**/
	function hasEntry<K, V>(key:Dynamic, value:Dynamic):Matcher<Map<K, V>>
	{
		return IsHashContaining.hasEntry(key, value);
	}

	/**
		Creates a matcher for `Map`s matching when the examined `Map` contains
		at least one key that satisfies the specified matcher.
		
		For example:
		`assertThat(myMap, hasKey(equalTo("bar")))`.
		
		For convenience you can provide a value instead of a matcher for direct equality comparison.
		
		For example:
		`assertThat(myMap, hasKey("bar"))`.
		
		@param key a key Matcher that must be satisfied by at least one key, or an 
					element to compare each key against
	**/
	function hasKey<K, V>(key:Dynamic):Matcher<Map<K, V>>
	{
		return IsHashContaining.hasKey(key);
	}

	/**
		Creates a matcher for `Map`s matching when the examined `Map` contains
		at least one value that satisfies the specified matcher.
		
		For example:
		`assertThat(myMap, hasValue(equalTo("foo")))`.
		
		For convenience you can provide a value instead of a matcher for direct equality comparison.
		
		For example:
		`assertThat(myMap, hasValue("foo"))`.
		
		@param value a value Matcher that must be satisfied by at least one value, or an 
					element to compare each value against
	**/
	function hasValue<K, V>(value:Dynamic):Matcher<Map<K, V>>
	{
		return IsHashContaining.hasValue(value);
	}
}
