/****
* Copyright 2011 hamcrest.org. See LICENSE.txt
****/

package org.hamcrest.core;

import org.hamcrest.BaseMatcher;
import org.hamcrest.Description;
import org.hamcrest.Matcher;
import org.hamcrest.Exception;

class ShortcutCombination<T> extends BaseMatcher<T>
{
    var matchers:Iterable<Matcher<T>>;
    var op:String;
	
    private function new(matchers:Iterable<Matcher<T>>, op:String)
    {
    	super();
        this.matchers = matchers;
        this.op = op;
    }
    
    function doesMatch(value:Dynamic, shortcut:Bool):Bool 
    {
        for (matcher in matchers)
        {
            if (matcher.matches(value) == shortcut)
                return shortcut;
        }
        return !shortcut;
    }
    
    override public function describeTo(description:Description):Void
    {
        description.appendList("(", " " + op + " ", ")", matchers);
    }
}
