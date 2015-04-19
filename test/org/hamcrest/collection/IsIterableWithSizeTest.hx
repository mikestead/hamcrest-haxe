package org.hamcrest.collection;

import org.hamcrest.AbstractMatcherTest;
import org.hamcrest.Matcher;
import org.hamcrest.Matchers.*;

class IsIterableWithSizeTest extends AbstractMatcherTest
{
    override function createMatcher():Matcher<Dynamic>
    {
        return hasSize(7);
    }

	@Test
    public function testMatchesEmptyIterable()
    {
        assertMatches("Empty iterable", hasSize(0), []);
    }

	@Test
    public function testMatchingSingleItemIterable()
    {
        assertMatches("Single item iterable", hasSize(1), [1]);
    }

	@Test
    public function testMatchingMultipleItemIterable()
    {
        assertMatches("Multiple item iterable", hasSize(3), [1, 2, 3]);
    }

	@Test
    public function testDoesNotMatchIncorrectSize()
    {
        assertDoesNotMatch("Incorrect size", hasSize(3), [1]);
    }

	@Test
    public function testHasAReadableDescription()
    {
        assertDescription("an iterable with size <4>", hasSize(4));
    }
}
