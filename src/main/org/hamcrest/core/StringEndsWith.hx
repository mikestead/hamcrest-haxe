/****
* Copyright 2011 hamcrest.org. See LICENSE.txt
****/

package org.hamcrest.core;

import org.hamcrest.Matcher;

using StringTools;

/**
 * Tests if the argument is a string that contains a substring.
 */
class StringEndsWith extends SubstringMatcher 
{
    public function new(substring:String)
    {
        super(substring);
    }

    override function evalSubstringOf(s:String):Bool
    {
        return s.endsWith(substring);
    }

    override function relationship():String
    {
        return "ending with";
    }

    public static function endsWith(substring:String):Matcher<String>
    {
        return new StringEndsWith(substring);
    }
}
