package org.hamcrest.core;

import org.hamcrest.AbstractMatcherTest;
import org.hamcrest.Matcher;
import org.hamcrest.StringDescription;

import massive.munit.Assert;

class DescribedAsTest extends AbstractMatcherTest
{
    override function createMatcher():Matcher<Dynamic> 
    {
        return describedAs("irrelevant", anything());
    }

	@Test
    public function testOverridesDescriptionOfOtherMatcherWithThatPassedToConstructor()
    {
        var m1 = describedAs("m1 description", anything());
        var m2 = describedAs("m2 description", not(anything()));

        assertDescription("m1 description", m1);
        assertDescription("m2 description", m2);
    }

	@Test
    public function testAppendsValuesToDescription() 
    {
        var m = describedAs("value 1 = %00, value 2 = %01, value 3 = %2", anything(), [33, 97, -3.1]);
        assertDescription("value 1 = <33>, value 2 = <97>, value 3 = <-3.1>", m);
    }

	@Test
    public function testDelegatesMatchingToAnotherMatcher()
    {
        var m1 = describedAs("irrelevant", anything());
        var m2 = describedAs("irrelevant", not(anything()));

        Assert.isTrue(m1.matches({}));
        Assert.isFalse(m2.matches("hi"));
    }

	@Test
    public function testDelegatesMismatchDescriptionToAnotherMatcher()
    {
        var m1 = describedAs("irrelevant", equalTo(2));

        var description = new StringDescription();
        m1.describeMismatch(1, description);

        Assert.areEqual("was <1>", description.toString());
    }
}
