/*  Copyright (c) 2000-2010 hamcrest.org
 */
package org.hamcrest.core;

import org.hamcrest.AbstractMatcherTest;
import org.hamcrest.Matcher;

class AnyOfTest extends AbstractMatcherTest
{
	override function createMatcher():Matcher<Dynamic> 
	{
		return anyOf(equalTo("irrelevant"));
	}

	@Test
    public function testEvaluatesToTheTheLogicalDisjunctionOfTwoOtherMatchers()
    {
        assertThat("good", anyOf(equalTo("bad"), equalTo("good")));
        assertThat("good", anyOf(equalTo("good"), equalTo("good")));
        assertThat("good", anyOf(equalTo("good"), equalTo("bad")));

        assertThat("good", not(anyOf(equalTo("bad"), equalTo("bad"))));
    }

	@Test
    public function testEvaluatesToTheTheLogicalDisjunctionOfManyOtherMatchers()
    {
        assertThat("good", anyOf(equalTo("bad"), equalTo("good"), equalTo("bad"), equalTo("bad"), equalTo("bad")));
        assertThat("good", not(anyOf(equalTo("bad"), equalTo("bad"), equalTo("bad"), equalTo("bad"), equalTo("bad"))));
    }

	@Test
    public function testSupportsMixedTypes() {
        var combined = anyOf(
                equalTo(new SampleBaseClass("bad")),
                equalTo(new SampleBaseClass("good")),
                equalTo(new SampleSubClass("ugly"))
        );
        
        assertThat(new SampleSubClass("good"), combined);
    }    
    
    @Test
    public function testHasAReadableDescription()
    {
        assertDescription("(\"good\" or \"bad\" or \"ugly\")",
                anyOf(equalTo("good"), equalTo("bad"), equalTo("ugly")));
    }
}
