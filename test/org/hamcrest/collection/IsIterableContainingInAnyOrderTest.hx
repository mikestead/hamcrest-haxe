package org.hamcrest.collection;

import org.hamcrest.AbstractMatcherTest;
import org.hamcrest.Matcher;
import org.hamcrest.collection.IsIterableContainingInOrderTest;

class IsIterableContainingInAnyOrderTest extends AbstractMatcherTest
{
    override function createMatcher():Matcher<Dynamic>
    {
        return containsInAnyOrder(1, 2);
    }   

	@Test
    public function testMatchesSingleItemIterable()
    {
      assertMatches("single item", containsInAnyOrder(1), [1]);
    }

	@Test
    public function testDoesNotMatchEmpty()
    {
        assertMismatchDescription("No item matches: <1>, <2> in []", containsInAnyOrder(1, 2), []);
    }
    
	@Test
    public function testMatchesIterableOutOfOrder()
    {
        assertMatches("Out of order", containsInAnyOrder(1, 2), [2, 1]);
    }
    
	@Test
    public function testMatchesIterableInOrder()
    {
        assertMatches("In order", containsInAnyOrder(1, 2), [1, 2]);
    }
    
	@Test
    public function testDoesNotMatchIfOneOfMultipleElementsMismatches()
    {
        assertMismatchDescription("Not matched: <4>", containsInAnyOrder(1, 2, 3), [1, 2, 4]);
    }

	@Test
    public function testDoesNotMatchIfThereAreMoreElementsThanMatchers()
    {
        assertMismatchDescription("Not matched: <WithValue 2>", containsInAnyOrder(value(1), value(3)), [make(1), make(2), make(3)]);
    }
    
	@Test
    public function testDoesNotMatchIfThereAreMoreMatchersThanElements()
    {
        assertMismatchDescription("No item matches: <4> in [<1>, <2>, <3>]", containsInAnyOrder(1, 2, 3, 4), [1, 2, 3]);
    }

	@Test
    public function testHasAReadableDescription()
    {
        assertDescription("iterable over [<1>, <2>] in any order", containsInAnyOrder(1, 2));
    }
    
	@Test
    public function testDoesNotMatchIfSingleItemMismatches()
    {
		assertMismatchDescription("Not matched: <WithValue 3>", containsInAnyOrder(value(4)), [make(3)]);  
	}
	
    public static function make(value:Int):WithValue
    {
    	return IsIterableContainingInOrderTest.make(value);
    }

    public static function value(value:Int):Matcher<WithValue> 
    {
    	return IsIterableContainingInOrderTest.value(value);
    }
}
