/****
* Copyright 2011 hamcrest.org. See LICENSE.txt
****/

package org.hamcrest.core;

import org.hamcrest.Description;
import org.hamcrest.TypeSafeMatcher;
import org.hamcrest.Exception;

class SubstringMatcher extends TypeSafeMatcher<String>
{
    var substring:String;

    private function new(substring:String)
    {
    	super();
        this.substring = substring;
    }

    override function matchesSafely(item:String):Bool
    {
        return evalSubstringOf(item);
    }
    
    override function describeMismatchSafely(item:String, mismatchDescription:Description):Void
    {
    	mismatchDescription.appendText("was \"").appendText(item).appendText("\"");
    }
    
    override public function describeTo(description:Description):Void
    {
        description.appendText("a string ")
                .appendText(relationship())
                .appendText(" ")
                .appendValue(substring);
    }
    
    override function isExpectedType(value:Dynamic):Bool
    {
    	return Std.is(value, String);    
    }

    function evalSubstringOf(string:String):Bool
    {
    	throw new MissingImplementationException();
    	return false;    
    }

    function relationship():String
    {
    	throw new MissingImplementationException();
    	return "";
    }
}