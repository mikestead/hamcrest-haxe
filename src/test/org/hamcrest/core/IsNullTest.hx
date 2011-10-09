package org.hamcrest.core;

import org.hamcrest.AbstractMatcherTest;
import org.hamcrest.Matcher;


class IsNullTest extends AbstractMatcherTest 
{
    inline static var ANY_NON_NULL_ARGUMENT:Int = 30;

    override function createMatcher():Matcher<Dynamic> 
    {
        return nullValue();
    }

	@Test
    public function testEvaluatesToTrueIfArgumentIsNull()
    {
        assertThat(null, nullValue());
        assertThat(ANY_NON_NULL_ARGUMENT, not(nullValue()));

        assertThat(ANY_NON_NULL_ARGUMENT, notNullValue());
        assertThat(null, not(notNullValue()));
    }

	@Test
    public function testSupportsStaticTyping()
    {
        requiresStringMatcher(nullValue(String));
        requiresStringMatcher(notNullValue(String));
    }

    function requiresStringMatcher(arg:Matcher<String>)
    {
        // no-op
    }    
}
