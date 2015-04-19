package org.hamcrest.collection;

import org.hamcrest.AbstractMatcherTest;
import org.hamcrest.Matcher;
import org.hamcrest.collection.IsArrayContainingInOrder.*;

class IsArrayContainingInOrderTest extends AbstractMatcherTest
{
    override function createMatcher():Matcher<Dynamic>
    {
        return arrayContaining(equalTo(1), equalTo(2));
    }

	@Test
    public function testHasAReadableDescription()
    {
        assertDescription("[<1>, <2>]", arrayContaining(equalTo(1), equalTo(2)));
    }
    
	@Test
    public function testMatchesItemsInOrder()
    {
		assertMatches("in order", arrayContaining(1, 2, 3), [1, 2, 3]);
		assertMatches("single", arrayContaining(1), [1]);
    }

	@Test
    public function testAppliesMatchersInOrder()
    {
		assertMatches("in order", arrayContaining(equalTo(1), equalTo(2), equalTo(3)), [1, 2, 3]);
		assertMatches("single", arrayContaining(equalTo(1)), [1]);
    }
    
	@Test
    public function testMismatchesItemsInOrder()
    {
		var matcher:Matcher<Array<Int>>  = arrayContaining(1, 2, 3);
		assertMismatchDescription("was null", matcher, null);
		assertMismatchDescription("No item matched: <1>", matcher, new Array<Int>());
		assertMismatchDescription("No item matched: <2>", matcher, [1]);
		assertMismatchDescription("item 0: was <4>", matcher, [4,3,2,1]);
		assertMismatchDescription("item 2: was <4>", matcher, [1,2, 4]);
    }
}
