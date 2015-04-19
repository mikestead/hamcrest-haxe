package org.hamcrest.core;

import org.hamcrest.AbstractMatcherTest;
import org.hamcrest.Matcher;

class IsSameTest extends AbstractMatcherTest
{
    override function createMatcher():Matcher<Dynamic>
    {
        return theInstance("irrelevant");
    }

	@Test
    public function testEvaluatesToTrueIfArgumentIsReferenceToASpecifiedObject() {
        var o1 = {};
        var o2 = {};

        assertThat(o1, theInstance(o1));
        assertThat(o2, not(theInstance(o1)));
    }

	@Test
    public function testReturnsReadableDescriptionFromToString() 
    {
        assertDescription("sameInstance(\"ARG\")", theInstance("ARG"));
    }

	@Test
    public function testReturnsReadableDescriptionFromToStringWhenInitialisedWithNull()
    {
        assertDescription("sameInstance(null)", theInstance(null));
    }
}
