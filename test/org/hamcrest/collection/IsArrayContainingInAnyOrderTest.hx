package org.hamcrest.collection;

import org.hamcrest.AbstractMatcherTest;
import org.hamcrest.Matcher;
import org.hamcrest.collection.IsArrayContainingInAnyOrder.*;

class IsArrayContainingInAnyOrderTest extends AbstractMatcherTest
{
    override function createMatcher():Matcher<Dynamic>
    {
        return arrayContainingInAnyOrder(equalTo(1), equalTo(2));
    }

	@Test
    public function testHasAReadableDescription()
    {
        assertDescription("[<1>, <2>] in any order", arrayContainingInAnyOrder(equalTo(1), equalTo(2)));
        assertDescription("[<1>, <2>] in any order", arrayContainingInAnyOrder(1, 2));
    }
    
	@Test
    public function testMatchesItemsInAnyOrder()
    {
    	assertMatches("in order", arrayContainingInAnyOrder(1, 2, 3), [1, 2, 3]);
		assertMatches("out of order", arrayContainingInAnyOrder(1, 2, 3), [3, 2, 1]);
		assertMatches("single", arrayContainingInAnyOrder(1), [1]);
    }

	@Test
    public function testAppliesMatchersInAnyOrder()
    {
		assertMatches("in order", arrayContainingInAnyOrder(equalTo(1), equalTo(2), equalTo(3)), [1, 2, 3]);
		assertMatches("out of order", arrayContainingInAnyOrder(equalTo(1), equalTo(2), equalTo(3)), [3, 2, 1]);
		assertMatches("single", arrayContainingInAnyOrder(equalTo(1)), [1]);
    }

	@Test
    public function testMismatchesItemsInAnyOrder()
    {
		var matcher = arrayContainingInAnyOrder(1, 2, 3);
		assertMismatchDescription("was null", matcher, null);
		assertMismatchDescription("No item matches: <1>, <2>, <3> in []", matcher, new Array<Int>());
		assertMismatchDescription("No item matches: <2>, <3> in [<1>]", matcher, [1]);
		assertMismatchDescription("Not matched: <4>", matcher, [4, 3, 2, 1]);
    }
}
