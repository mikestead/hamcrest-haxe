/****
* Copyright 2011 hamcrest.org. See LICENSE.txt
****/

/*  Copyright (c) 2000-2006 hamcrest.org
 */
package org.hamcrest.core;

import org.hamcrest.Description;
import org.hamcrest.DiagnosingMatcher;
import org.hamcrest.Matcher;


/**
 * Tests whether the value is an instance of a class.
 * Classes of basic types will be converted to the relevant "Object" classes
 */
class IsInstanceOf extends DiagnosingMatcher<Dynamic>
{
    var expectedClass:Dynamic;

    /**
     * Creates a new instance of IsInstanceOf
     *
     * @param expectedClass The predicate evaluates to true for instances of this class
     *                 or one of its subclasses.
     */
    public function new(expectedClass:Dynamic)
    {
    	super();
        this.expectedClass = expectedClass;
    }

    override function isMatch(item:Dynamic, mismatchDescription:Description):Bool
    {
    	if (item == null)
		{
			mismatchDescription.appendText("null");
			return false;
		}
      
		if (!Std.is(item, expectedClass))
		{
			var type = Type.getClass(item);
			var className = type != null ? Type.getClassName(type) : "Dynamic";
      		mismatchDescription.appendValue(item).appendText(" is a " + className);
        	return false;
        }
		return true;
    }

    override public function describeTo(description:Description):Void
    {
        description.appendText("an instance of ")
                .appendText(Type.getClassName(expectedClass));
    }

    /**
     * Is the value an instance of a particular type? 
     * This version assumes no relationship between the required type and
     * the signature of the method that sets it up, for example in
     * <code>assertThat(anObject, instanceOf(Thing));</code>
     */
    public static function instanceOf<T>(type:Dynamic):Matcher<T>
    {
        return cast new IsInstanceOf(type);
    }
    
    /**
     * Is the value an instance of a particular type? 
     * Use this version to make generics conform, for example in 
     * the clause <code>with(any(Thing))</code> 
     */
    public static function any<T>(type:Dynamic):Matcher<T>
    {
        return cast new IsInstanceOf(type);
    }
}
