package org.hamcrest.collection;

import org.hamcrest.AbstractMatcherTest;
import org.hamcrest.Matcher;

class IsArrayContainingTest extends AbstractMatcherTest
{
    override function createMatcher():Matcher<Dynamic>
    {
        return hasItemInArray("irrelevant");
    }

	@Test
    public function testMatchesAnArrayThatContainsAnElementMatchingTheGivenMatcher()
    {
        assertMatches("should matches array that contains 'a'",
                hasItemInArray("a"), ["a", "b", "c"]);
    }

	@Test
    public function testDoesNotMatchAnArrayThatDoesntContainAnElementMatchingTheGivenMatcher()
    {
        assertDoesNotMatch("should not matches array that doesn't contain 'a'",
                hasItemInArray("a"), ["b", "c"]);
        assertDoesNotMatch("should not matches empty array",
                hasItemInArray("a"), new Array<String>());
    }

	@Test
    public function testDoesNotMatchNull()
    {
        assertDoesNotMatch("should not matches null",
                hasItemInArray("a"), null);
    }

	@Test
    public function testHasAReadableDescription()
    {
        assertDescription("an array containing \"a\"", hasItemInArray("a"));
    }
}
