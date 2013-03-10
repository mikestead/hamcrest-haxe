/****
* Copyright 2011 hamcrest.org. See LICENSE.txt
****/

package org.hamcrest.core;

import org.hamcrest.BaseMatcher;
import org.hamcrest.Description;
import org.hamcrest.Matcher;

class CombinableMatcher<T> extends BaseMatcher<T>
{
    var matcher:Matcher<T>;

    public function new(matcher:Matcher<T>)
    {
    	super();
        this.matcher = matcher;
    }

    override public function matches(item:Dynamic):Bool
    {
        return matcher.matches(item);
    }

    override public function describeTo(description:Description):Void
    {
        description.appendDescriptionOf(matcher);
    }

    public function and(other:Matcher<T>):CombinableMatcher<T>
    {
        return new CombinableMatcher<T>(new AllOf<T>(templatedListWith(other)));
    }

    public function or(other:Matcher<T>):CombinableMatcher<T>
    {
        return new CombinableMatcher<T>(new AnyOf<T>(templatedListWith(other)));
    }
    
    function templatedListWith(other:Matcher<T>):Array<Matcher<T>>
    {
        var matchers:Array<Matcher<T>> = [];
        matchers.push(matcher);
        matchers.push(other);
        return matchers;
    }

    /**
     * This is useful for fluently combining matchers that must both pass.  For example:
     * <pre>
     *   assertThat(string, both(containsString("a")).and(containsString("b")));
     * </pre>
     */
    public static function both<LHS>(matcher:Matcher<LHS>):CombinableMatcher<LHS> 
    {
        return new CombinableMatcher<LHS>(matcher);
    }

    /**
     * This is useful for fluently combining matchers where either may pass, for example:
     * <pre>
     *   assertThat(string, both(containsString("a")).and(containsString("b")));
     * </pre>
     */
    public static function either<LHS>(matcher:Matcher<LHS>):CombinableMatcher<LHS>  
    {
        return new CombinableMatcher<LHS>(matcher);
    }
}
