/****
* Copyright 2011 hamcrest.org. See LICENSE.txt
****/

package org.hamcrest.collection;

import org.hamcrest.Description;
import org.hamcrest.Matcher;
import org.hamcrest.TypeSafeMatcher;
import org.hamcrest.internal.VarArgMatchers;

class IsArrayContainingInAnyOrder<T> extends TypeSafeMatcher<Array<T>>
{
    var iterableMatcher:IsIterableContainingInAnyOrder<T>;
    var matchers:Array<Matcher<T>>;

    public function new(matchers:Array<Matcher<T>>)
    {
    	super();
        this.iterableMatcher = new IsIterableContainingInAnyOrder<T>(matchers);
        this.matchers = matchers;
    }

    override function matchesSafely(item:Array<T>):Bool
    {
        return iterableMatcher.matches(item.concat([]));
    }
    
    override function isExpectedType(value:Dynamic):Bool
    {
    	return Std.is(value, Array);
    }
    
    override function describeMismatchSafely(item:Array<T>, mismatchDescription:Description)
    {
    	iterableMatcher.describeMismatch(item, mismatchDescription);
    }

    override function describeTo(description:Description)
    {
        description.appendList("[", ", ", "]", matchers)
            .appendText(" in any order");
    } 

    public static function arrayContainingInAnyOrder<T>(first:Dynamic, ?second:Dynamic, ?third:Dynamic, ?fourth:Dynamic, ?fifth:Dynamic, 
    													?sixth:Dynamic, ?seventh:Dynamic, ?eighth:Dynamic, ?ninth:Dynamic, ?tenth:Dynamic):Matcher<Array<T>>
	{
        return cast VarArgMatchers.newIterable(cast IsArrayContainingInAnyOrder, first, second, third, fourth, fifth, sixth, seventh, eighth, ninth, tenth);
    }
}
