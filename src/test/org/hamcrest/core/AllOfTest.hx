/*  Copyright (c) 2000-2010 hamcrest.org
 */
package org.hamcrest.core;

import org.hamcrest.AbstractMatcherTest;
import org.hamcrest.Matcher;
import org.hamcrest.MatcherAssert;

class AllOfTest extends AbstractMatcherTest 
{
    override function createMatcher():Matcher<Dynamic>
    {
        return allOf(equalTo("irrelevant"));
    }
    
    @Test
    public function testEvaluatesToTheTheLogicalConjunctionOfTwoOtherMatchers()
    {
        assertThat("good", allOf(equalTo("good"), startsWith("good"))); 
        assertThat("good", not(allOf(equalTo("bad"), equalTo("good"))));
        assertThat("good", not(allOf(equalTo("good"), equalTo("bad"))));
        assertThat("good", not(allOf(equalTo("bad"), equalTo("bad")))); 
    }

	@Test
    public function testEvaluatesToTheTheLogicalConjunctionOfManyOtherMatchers()
    {
        assertThat("good", allOf(equalTo("good"), equalTo("good"), equalTo("good"), equalTo("good"), equalTo("good")));
        assertThat("good", not(allOf(equalTo("good"), equalTo("good"), equalTo("bad"), equalTo("good"), equalTo("good"))));
    }
    
    @Test
    public function testSupportsMixedTypes()
    {
        var all = allOf(
                equalTo(new SampleSubClass("bad")),
        		equalTo(new SampleBaseClass("good")),
                is(notNullValue()),
                equalTo(new SampleBaseClass("ugly"))
        );
              
        var negated = not(all);
        
        assertThat(new SampleSubClass("good"), negated);
    }
    
    @Test
    public function testHasAReadableDescription()
    {
        assertDescription("(\"good\" and \"bad\" and \"ugly\")",
                allOf(equalTo("good"), equalTo("bad"), equalTo("ugly")));
    }

	@Test
    public function testMismatchDescriptionDescribesFirstFailingMatch()
    {
    	assertMismatchDescription("\"good\" was \"bad\"", allOf(equalTo("bad"), equalTo("good")), "bad");
	}
}
