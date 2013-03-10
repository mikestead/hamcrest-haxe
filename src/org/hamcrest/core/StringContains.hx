/****
* Copyright 2011 hamcrest.org. See LICENSE.txt
****/

package org.hamcrest.core;

import org.hamcrest.Matcher;

/**
 * Tests if the argument is a string that contains a substring.
 */
class StringContains extends SubstringMatcher
{
    public function new(substring:String)
    {
        super(substring);
    }

    override function evalSubstringOf(s:String):Bool
    {
        return s.indexOf(substring) >= 0;
    }

    override function relationship():String
    {
        return "containing";
    }

    public static function containsString(substring:String):Matcher<String>
    {
        return new StringContains(substring);
    }
}
