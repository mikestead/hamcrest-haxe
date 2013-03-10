package org.hamcrest.core;

import org.hamcrest.AbstractMatcherTest;
import org.hamcrest.Matcher;

class IsAnythingTest extends AbstractMatcherTest
{
    override function createMatcher():Matcher<Dynamic> 
    {
        return anything();
    }

	@Test
    public function testAlwaysEvaluatesToTrue()
    {
        assertThat(null, anything());
        assertThat({}, anything());
        assertThat("hi", anything());
    }

	@Test
    public function testHasUsefulDefaultDescription()
    {
        assertDescription("ANYTHING", anything());
    }

	@Test
    public function testCanOverrideDescription()
    {
        var description = "description";
        assertDescription(description, anything(description));
    }

}
