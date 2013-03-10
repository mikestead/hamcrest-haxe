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
    var operator:String;
	
    private function new(matchers:Iterable<Matcher<T>>, operator:String)
    {
    	super();
        this.matchers = matchers;
        this.operator = operator;
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
        description.appendList("(", " " + operator + " ", ")", matchers);
    }
}
