package org.hamcrest.collection;

import org.hamcrest.AbstractMatcherTest;
import org.hamcrest.Matcher;

class IsEmptyIterableTest extends AbstractMatcherTest
{
    override function createMatcher():Matcher<Dynamic> 
    {
        return isEmpty();
    }

	@Test
    public function testMatchesAnEmptyIterable()
    {
        assertMatches("empty iterable", isEmpty(), []);
    }

	@Test
    public function testDoesNotMatchAnIterableWithItems()
    {
        assertDoesNotMatch("iterable with an item", isEmpty(), [1]);
    }
	
	@Test
    public function testHasAReadableDescription()
    {
        assertDescription("an empty iterable", isEmpty());
    }
}
