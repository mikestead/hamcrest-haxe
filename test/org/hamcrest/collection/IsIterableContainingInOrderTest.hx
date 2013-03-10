package org.hamcrest.collection;

import org.hamcrest.AbstractMatcherTest;
import org.hamcrest.FeatureMatcher;
import org.hamcrest.Matcher;
import org.hamcrest.core.IsEqual;

class IsIterableContainingInOrderTest extends AbstractMatcherTest
{
    override function createMatcher():Matcher<Dynamic>
    {
        return contains(1, 2);
    }

	@Test
    public function testMatchingSingleItemIterable()
    {
        assertMatches("Single item iterable", contains(1), [1]);
    }

	@Test
    public function testMatchingMultipleItemIterable()
    {
        assertMatches("Multiple item iterable", contains(1, 2, 3), [1, 2, 3]);
    }

	@Test
    public function testDoesNotMatchWithMoreElementsThanExpected()
    {
        assertMismatchDescription("Not matched: <4>", contains(1, 2, 3), [1, 2, 3, 4]);
    }

	@Test
    public function testDoesNotMatchWithFewerElementsThanExpected()
    {
        assertMismatchDescription("No item matched: value with <3>", contains(value(1), value(2), value(3)), [make(1), make(2)]);
    }

	@Test
    public function testDoesNotMatchIfSingleItemMismatches()
    {
        assertMismatchDescription("item 0: value was <3>", contains(value(4)), [make(3)]);
    }

	@Test
    public function testDoesNotMatchIfOneOfMultipleItemsMismatch()
    {
        assertMismatchDescription("item 2: value was <4>", contains(value(1), value(2), value(3)), [make(1), make(2), make(4)]);
    }

	@Test
    public function testDoesNotMatchEmptyIterable()
    {
        assertMismatchDescription("No item matched: value with <4>", contains(value(4)), new Array<WithValue>());
    }

	@Test
    public function testHasAReadableDescription()
    {
        assertDescription("iterable containing [<1>, <2>]", contains(1, 2));
    }

    public static function make(value:Int):WithValue
    {
    	return new WithValue(value);
    }

    public static function value(value:Int):Matcher<WithValue> 
    {
    	return new WithValueFeatureMatcher<Int>(IsEqual.equalTo(value), "value with", "value");
    }
}

class WithValue
{
	public var value(default, null):Int;

	public function new(value:Int)
	{
		this.value = value;
	}
	
	public function toString():String
	{
		return "WithValue " + value;
	}
}

class WithValueFeatureMatcher<U> extends FeatureMatcher<WithValue, U>
{
	public function new(subMatcher:Matcher<U>, featureDescription:String, featureName:String)
	{
		super(subMatcher, featureDescription, featureName);
	}
	
	override function featureValueOf(actual:WithValue):U
	{
		return cast actual.value;
	}
    
    override function isExpectedType(value:Dynamic):Bool
    {
    	return Std.is(value, WithValue);
    }
}
