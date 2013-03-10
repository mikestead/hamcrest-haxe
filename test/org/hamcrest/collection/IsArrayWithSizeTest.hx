package org.hamcrest.collection;

import org.hamcrest.AbstractMatcherTest;
import org.hamcrest.Matcher;

class IsArrayWithSizeTest extends AbstractMatcherTest
{
    override function createMatcher():Matcher<Dynamic>
    {
        return arrayWithSize(equalTo(2));
    }

	@Test
    public function testMatchesWhenSizeIsCorrect()
    {
        assertMatches("correct size", arrayWithSize(equalTo(3)), [1, 2, 3]);
        assertDoesNotMatch("incorrect size", arrayWithSize(equalTo(2)), [1, 2, 3]);
    }

	@Test
    public function testProvidesConvenientShortcutForArrayWithSizeEqualTo()
    {
        assertMatches("correct size", arrayWithSize(3), [1, 2, 3]);
        assertDoesNotMatch("incorrect size", arrayWithSize(2), [1, 2, 3]);
    }

	@Test
    public function testEmptyArray()
    {
        assertMatches("correct size", emptyArray(), new Array<Int>());
        assertDoesNotMatch("incorrect size", emptyArray(), [1]);
    }

	@Test
    public function testHasAReadableDescription()
    {
        assertDescription("an array with size <3>", arrayWithSize(equalTo(3)));
        assertDescription("an empty array", emptyArray());
    }
}
