package org.hamcrest.collection;

import org.hamcrest.AbstractMatcherTest;
import org.hamcrest.Matcher;

class IsHashContainingKeyTest extends AbstractMatcherTest
{
    override function createMatcher():Matcher<Dynamic>
    {
        return hasKey("foo");
    }

    public function testMatchesSingletonMapContainingKey()
    {
        var map = new StringMap<Int>();
        map.set("a", 1);
        
        assertMatches("Matches single key", hasKey("a"), map);
    }
    
    public function testMatchesMapContainingKey()
    {
        var map = new StringMap<Int>();
        map.set("a", 1);
        map.set("b", 2);
        map.set("c", 3);
        
        assertMatches("Matches a", hasKey("a"), map);
        assertMatches("Matches c", hasKey("c"), map);
    }
    
    public function testHasReadableDescription()
    {
        assertDescription("map containing [\"a\"->ANYTHING]", hasKey("a"));
    }
    
    public function testDoesNotMatchEmptyMap()
    {
        assertMismatchDescription("map was []", hasKey("Foo"), new StringMap<Int>());
    }
    
    public function testDoesNotMatchMapMissingKey() 
    {
        var map = new StringMap<Int>();
        map.set("a", 1);
        map.set("b", 2);
        map.set("c", 3);
        
        assertMismatchDescription("map was [<a=1>, <b=2>, <c=3>]", hasKey("d"), map);
    }
}
