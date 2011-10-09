package org.hamcrest.core;

import org.hamcrest.AbstractMatcherTest;
import org.hamcrest.Matcher;

import massive.munit.Assert;

class IsTest extends AbstractMatcherTest
{
    override function createMatcher():Matcher<Dynamic>
    {
        return is("something");
    }

	@Test
    public function testJustMatchesTheSameWayTheUnderylingMatcherDoes()
    {
        assertMatches("should match", is(equalTo(true)), true);
        assertMatches("should match", is(equalTo(false)), false);
        assertDoesNotMatch("should not match", is(equalTo(true)), false);
        assertDoesNotMatch("should not match", is(equalTo(false)), true);
    }

	@Test
    public function testGeneratesIsPrefixInDescription()
    {
        assertDescription("is <true>", is(equalTo(true)));
    }

	@Test
    public function testProvidesConvenientShortcutForIsEqualTo()
    {
        assertMatches("should match", is("A"), "A");
        assertMatches("should match", is("B"), "B");
        assertDoesNotMatch("should not match", is("A"), "B");
        assertDoesNotMatch("should not match", is("B"), "A");
        assertDescription("is \"A\"", is("A"));
    }

	@Test
    public function testProvidesConvenientShortcutForIsInstanceOf()
    {
        Assert.isTrue(is(String).matches("A"));
        Assert.isFalse(is(Int).matches({}));
        Assert.isFalse(is(Int).matches(null));
    }
}
