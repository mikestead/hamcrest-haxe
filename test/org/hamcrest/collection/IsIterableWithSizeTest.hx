package org.hamcrest.collection;

import org.hamcrest.AbstractMatcherTest;
import org.hamcrest.Matcher;

class IsIterableWithSizeTest extends AbstractMatcherTest
{
    override function createMatcher():Matcher<Dynamic>
    {
        return iterableWithSize(7);
    }

	@Test
    public function testMatchesEmptyIterable()
    {
        assertMatches("Empty iterable", iterableWithSize(0), []);
    }

	@Test
    public function testMatchingSingleItemIterable()
    {
        assertMatches("Single item iterable", iterableWithSize(1), [1]);
    }

	@Test
    public function testMatchingMultipleItemIterable()
    {
        assertMatches("Multiple item iterable", iterableWithSize(3), [1, 2, 3]);
    }

	@Test
    public function testDoesNotMatchIncorrectSize()
    {
        assertDoesNotMatch("Incorrect size", iterableWithSize(3), [1]);
    }

	@Test
    public function testHasAReadableDescription()
    {
        assertDescription("an iterable with size <4>", iterableWithSize(4));
    }
}
