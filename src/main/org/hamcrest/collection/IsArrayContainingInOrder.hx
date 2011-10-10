/****
* Copyright 2011 hamcrest.org. See LICENSE.txt
****/

package org.hamcrest.collection;

import org.hamcrest.Description;
import org.hamcrest.Matcher;
import org.hamcrest.TypeSafeMatcher;
import org.hamcrest.internal.VarArgMatchers;

class IsArrayContainingInOrder<E> extends TypeSafeMatcher<Array<E>>
{
    var matchers:Array<Matcher<E>>;
    var iterableMatcher:IsIterableContainingInOrder<E>;

    public function new(matchers:Array<Matcher<E>>)
    {
    	super();
        this.iterableMatcher = new IsIterableContainingInOrder<E>(matchers);
        this.matchers = matchers;
    }

    override function matchesSafely(item:Array<E>):Bool
    {
        return iterableMatcher.matches(item);
    }
    
    override function isExpectedType(value:Dynamic):Bool
    {
    	return Std.is(value, Array);
    }
    
    override function describeMismatchSafely(item:Array<E>, mismatchDescription:Description)
    {
		iterableMatcher.describeMismatch(item, mismatchDescription);
    }

    override public function describeTo(description:Description)
    {
        description.appendList("[", ", ", "]", matchers);
    }
    
    public static function arrayContaining<T>(first:Dynamic, ?second:Dynamic, ?third:Dynamic, ?fourth:Dynamic, ?fifth:Dynamic, 
    										   ?sixth:Dynamic, ?seventh:Dynamic, ?eighth:Dynamic, ?ninth:Dynamic, ?tenth:Dynamic):Matcher<Array<T>>
	{
        return cast VarArgMatchers.newIterable(cast IsArrayContainingInOrder, first, second, third, fourth, fifth, sixth, seventh, eighth, ninth, tenth);
    }
}
