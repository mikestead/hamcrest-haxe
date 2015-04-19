package org.hamcrest.core;

import org.hamcrest.AbstractMatcherTest;
import org.hamcrest.Matcher;
import org.hamcrest.core.IsInstanceOf.*;

class IsInstanceOfTest extends AbstractMatcherTest
{
    override function createMatcher():Matcher<Dynamic>
    {
        return instanceOf(Int);
    }

	@Test
    public function testEvaluatesToTrueIfArgumentIsInstanceOfASpecificClass()
    {
        assertThat(1, instanceOf(Int));
        assertThat(1.0, instanceOf(Float));
        assertThat(null, not(instanceOf(Int)));
        assertThat({}, not(instanceOf(Int)));
    }
	
	@Test
    public function testHasAReadableDescription()
    {
        assertDescription("an instance of Int", instanceOf(Int));
    }

	@Test
    public function testDecribesActualClassInMismatchMessage()
    {
    	assertMismatchDescription("\"some text\" is a String", instanceOf(Int), "some text");
    }
    
    @Test
    public function testMatchesPrimitiveTypes()
    {
    	assertThat("", any(String));
    	assertThat(1, any(Int));
    	assertThat(1.2, any(Float));
    }
}
