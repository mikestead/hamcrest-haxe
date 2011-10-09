package org.hamcrest.core;

import org.hamcrest.AbstractMatcherTest;
import org.hamcrest.Matcher;

class IsNotTest extends AbstractMatcherTest
{
	override function createMatcher():Matcher<Dynamic>
	{
		return not("something");
	}

	@Test
	public function testEvaluatesToTheTheLogicalNegationOfAnotherMatcher()
	{
		assertMatches("should match", not(equalTo("A")), "B");
		assertDoesNotMatch("should not match", not(equalTo("B")), "B");
	}

	@Test
	public function testProvidesConvenientShortcutForNotEqualTo()
	{
	    assertMatches("should match", not("A"), "B");
	    assertMatches("should match", not("B"), "A");
	    assertDoesNotMatch("should not match", not("A"), "A");
	    assertDoesNotMatch("should not match", not("B"), "B");
	}
	
	@Test
	public function testUsesDescriptionOfNegatedMatcherWithPrefix()
	{
		assertDescription("not a value greater than <2>", not(greaterThan(2)));
		assertDescription("not \"A\"", not("A"));
	}
}
