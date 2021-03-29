/****
* Copyright 2011 hamcrest.org. See LICENSE.txt
****/

package org.hamcrest.collection;

import haxe.Constraints.IMap;
import org.hamcrest.Description;
import org.hamcrest.Matcher;
import org.hamcrest.TypeSafeMatcher;
import org.hamcrest.core.IsAnything;
import org.hamcrest.core.IsEqual;


class IsHashContaining<K, V> extends TypeSafeMatcher<Map<K, V>>
{
    var keyMatcher:Matcher<K>;
    var valueMatcher:Matcher<V>;

    public function new(keyMatcher:Matcher<K>, valueMatcher:Matcher<V>)
    {
    	super();
        this.keyMatcher = keyMatcher;
        this.valueMatcher = valueMatcher;
    }

    override function matchesSafely(map:Map<K, V>):Bool
    {
    	for (key in map.keys())
    		if (keyMatcher.matches(key) && valueMatcher.matches(map.get(key)))
    			return true;
        return false;
    }
    
    override function isExpectedType(value:Dynamic):Bool
    {
    	return Std.is(value, IMap);
    }

    override function describeMismatchSafely(hash:Map<K, V>, mismatchDescription:Description)
    {
		mismatchDescription.appendText("hash was ").appendValueList("[", ", ", "]", hashSetAsString(hash));
    }
    
    function hashSetAsString(hash:Map<K, V>):Iterable<Entry<K, V>>
    {
    	var keys = hash.keys();
    	return {
    		iterator:function():Iterator<Entry<K, V>> {
    			return {
    				hasNext:function():Bool {
    					return keys.hasNext();    				
    				},
    				next:function():Entry<K, V> {
    					var key = keys.next();
    					return new Entry<K, V>(key, hash.get(key));
    				}
    			}	
    		}
    	}
    }

    override public function describeTo(description:Description):Void
    {
        description.appendText("hash containing [")
                   .appendDescriptionOf(keyMatcher)
                   .appendText("->")
                   .appendDescriptionOf(valueMatcher)
                   .appendText("]");
    }
    
    public static function hasEntry<K, V>(key:K, value:V):Matcher<Map<K, V>>
    {    		
    	var keyMatcher = getMatcher(key);
    	var valueMatcher = getMatcher(value);
    	return new IsHashContaining<K, V>(keyMatcher, valueMatcher);
    }
    
    public static function hasKey<K, V>(key:K):Matcher<Map<K, V>>
    {
    	var keyMatcher = getMatcher(key);
    	return new IsHashContaining<K, V>(keyMatcher, IsAnything.anything());
    }
    
    public static function hasValue<K, V>(value:V):Matcher<Map<K, V>>
    {
    	var valueMatcher = getMatcher(value);
    	return new IsHashContaining<K, V>(cast IsAnything.anything(), valueMatcher);
    }
    
    static function getMatcher<T>(value:Dynamic):Matcher<T>
    {    	
    	return Std.is(value, Matcher) ? value : IsEqual.equalTo(value);
    }
}

private class Entry<K, V>
{
	var key:K;
	var value:V;
	
	public function new(key:K, value:V)
	{
		this.key = key;
		this.value = value;
	}
	
	public function toString():String
	{
		return key + "=" + value;
	}
}
