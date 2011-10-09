package org.hamcrest.collection;

import org.hamcrest.AbstractMatcherTest;
import org.hamcrest.Matcher;

class IsHashContainingValueTest extends AbstractMatcherTest
{
    override function createMatcher():Matcher<Dynamic>
    {
        return hasValue("foo");
    }

	@Test
    public function testHasReadableDescription()
    {
        assertDescription("hash containing [ANYTHING->\"a\"]", hasValue("a"));
    }
    
	@Test
    public function testDoesNotMatchEmptyMap()
    {
        var map = new Hash<Int>();
        assertMismatchDescription("hash was []", hasValue(1), map);
    }
    
	@Test
    public function testMatchesSingletonMapContainingValue()
    {
        var map = new Hash<Int>();
        map.set("a", 1);
        
        assertMatches("Singleton hash", hasValue(1), map);
    }

	@Test
    public function testMatchesMapContainingValue() 
    {
        var map = new Hash<Int>();
        map.set("a", 1);
        map.set("b", 2);
        map.set("c", 3);
        
        assertMatches("hasValue 1", hasValue(1), map);      
        assertMatches("hasValue 3", hasValue(3), map);      
    }
}
