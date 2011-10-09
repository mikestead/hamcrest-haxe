package org.hamcrest.core;

import org.hamcrest.StringDescription;

import massive.munit.Assert;

class EveryTest extends MatcherBuilderBase
{
	@Test
	public function isTrueWhenEveryValueMatches()
	{
		assertThat(["AaA", "BaB", "CaC"], everyItem(containsString("a")));
		assertThat(["AbA", "BbB", "CbC"], not(everyItem(containsString("a"))));
	}
	
	@Test
	public function isAlwaysTrueForEmptyLists()
	{
		assertThat(new Array<String>(), everyItem(containsString("a")));		
	}
	
	@Test
	public function describesItself()
	{
		var each:Every<String> = cast everyItem(containsString("a"));
		Assert.areEqual("every item is a string containing \"a\"", each.toString());
		
		var description = new StringDescription(); 
		each.describeMismatch(["BbB"], description); // no missmatch so should call matchesSafely
		Assert.areEqual("an item was \"BbB\"", description.toString());
	}
}
