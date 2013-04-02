/****
* Copyright 2011 hamcrest.org. See LICENSE.txt
****/

package org.hamcrest.collection;

import org.hamcrest.Description;
import org.hamcrest.Matcher;
import org.hamcrest.TypeSafeMatcher;
import org.hamcrest.Exception;

import org.hamcrest.core.IsAnything;
import org.hamcrest.core.IsEqual;

import org.hamcrest.internal.StringMap;

import haxe.PosInfos;

class IsHashContaining<V> extends TypeSafeMatcher<StringMap<V>>
{
    var keyMatcher:Matcher<String>;
    var valueMatcher:Matcher<V>;

    public function new(keyMatcher:Matcher<String>, valueMatcher:Matcher<V>)
    {
    	super();
        this.keyMatcher = keyMatcher;
        this.valueMatcher = valueMatcher;
    }

    override function matchesSafely(hash:StringMap<V>):Bool
    {
    	for (key in hash.keys())
    	{
    		if (keyMatcher.matches(key) && valueMatcher.matches(hash.get(key)))
    			return true;
    	}
        return false;
    }
    
    override function isExpectedType(value:Dynamic):Bool
    {
    	return Std.is(value, StringMap);
    }

    override function describeMismatchSafely(hash:StringMap<V>, mismatchDescription:Description)
    {
		mismatchDescription.appendText("hash was ").appendValueList("[", ", ", "]", hashSetAsString(hash));
    }
    
    function hashSetAsString(hash:StringMap<V>):Iterable<Set<String, V>>
    {
    	var keys = hash.keys();
    	return {
    		iterator:function():Iterator<Set<String, V>> {
    			return {
    				hasNext:function():Bool {
    					return keys.hasNext();    				
    				},
    				next:function():Set<String, V> {
    					var key = keys.next();
    					return new Set<String, V>(key, hash.get(key));
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
    
    public static function hasEntry<V>(key:Dynamic, value:Dynamic):Matcher<StringMap<V>>
    {    		
    	var keyMatcher = matcherForKey(key);
    	var valueMatcher = matcherForValue(value);
    	return new IsHashContaining<V>(keyMatcher, valueMatcher);
    }
    
    public static function hasKey(key:Dynamic):Matcher<StringMap<Dynamic>>
    {
    	var keyMatcher = matcherForKey(key);
    	return new IsHashContaining<Dynamic>(keyMatcher, IsAnything.anything());
    }
    
    public static function hasValue<V>(value:Dynamic):Matcher<StringMap<V>>
    {
    	var valueMatcher = matcherForValue(value);
    	return new IsHashContaining<V>(cast IsAnything.anything(), valueMatcher);
    }
    
    static function matcherForKey(key:Dynamic, ?info:PosInfos):Matcher<String>
    {
		var keyMatcher:Matcher<String>;
    	if (Std.is(key, Matcher))
    		keyMatcher = key;
    	else if (Std.is(key, String))
    		keyMatcher = IsEqual.equalTo(key);
    	else
    		throw new IllegalArgumentException("Argument 'key' must be of type String or Matcher<String> [" + key + "]", null, info);

    	return keyMatcher;
    }
    
    static function matcherForValue<V>(value:Dynamic):Matcher<V>
    {    	
    	return (Std.is(value, Matcher)) ? value : IsEqual.equalTo(value);
    }
}

class Set<K, V>
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
