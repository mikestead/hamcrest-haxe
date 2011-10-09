package org.hamcrest.collection;

import org.hamcrest.AbstractMatcherTest;
import org.hamcrest.Matcher;

class IsArrayTest extends AbstractMatcherTest
{
    override function createMatcher():Matcher<Dynamic>
    {
        return array(equalTo("irrelevant"));
    }

	@Test
    public function testMatchesAnArrayThatMatchesAllTheElementMatchers()
    {
        assertMatches("should match array with matching elements",
                array(equalTo("a"), equalTo("b"), equalTo("c")), ["a", "b", "c"]);
    }
    
	@Test
    public function testDoesNotMatchAnArrayWhenElementsDoNotMatch()
    {
        assertDoesNotMatch("should not match array with different elements",
                array(equalTo("a"), equalTo("b")), ["b", "c"]);
    }
    
	@Test
    public function testDoesNotMatchAnArrayOfDifferentSize()
    {
        assertDoesNotMatch("should not match larger array",
                           array(equalTo("a"), equalTo("b")), ["a", "b", "c"]);
        assertDoesNotMatch("should not match smaller array",
                           array(equalTo("a"), equalTo("b")), ["a"]);
    }
    
	@Test
    public function testDoesNotMatchNull()
    {
        assertDoesNotMatch("should not match null",
                array(equalTo("a")), null);
    }
    
	@Test
    public function testHasAReadableDescription()
    {
        assertDescription("[\"a\", \"b\"]", array(equalTo("a"), equalTo("b")));
    }
}
