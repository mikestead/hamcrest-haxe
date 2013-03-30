/****
* Copyright 2011 hamcrest.org. See LICENSE.txt
****/

/*  Copyright (c) 2000-2006 hamcrest.org
 */
package org.hamcrest.core;

import org.hamcrest.BaseMatcher;
import org.hamcrest.Description;
import org.hamcrest.Matcher;


/**
 * Is the value equal to another value, as tested by the
 * {@link java.lang.Object#equals} invokedMethod?
 */
class IsEqual<T> extends BaseMatcher<T>
{
    var object:Dynamic;

    public function new(equalArg:T)
    {
    	super();
        object = equalArg;
    }

    override public function matches(arg:Dynamic):Bool
    {
        return areEqual(arg, object);
    }

    override public function describeTo(description:Description)
    {
        description.appendValue(object);
    }
    
    static function areEqual(valueOne:Dynamic, valueTwo:Dynamic):Bool
    {
        if (valueOne == null)
            return valueTwo == null;
        else if (valueTwo != null && isArray(valueOne))
            return isArray(valueTwo) && areArraysEqual(cast valueOne, cast valueTwo);
        else if (valueTwo != null && isEnum(valueOne))
            return isEnum(valueTwo) && areEnumsEqual(valueOne, valueTwo);
        else
        {

        	try
        	{
	        	var field = Reflect.field(valueOne, "equals");
	        	if (field != null && Reflect.isFunction(field))
	        		return valueOne.equals(valueTwo) == true;
	        		
	        	field = Reflect.field(valueTwo, "equals");
	        	if (field != null && Reflect.isFunction(field))
	        		return valueTwo.equals(valueOne) == true;
        	}
        	catch(e:Dynamic)
        	{}
        	
        	return valueOne == valueTwo;
        }
    }

    static function areArraysEqual(valueOne:Dynamic, valueTwo:Dynamic):Bool
    {
        return areArrayLengthsEqual(valueOne, valueTwo) && areArrayElementsEqual(valueOne, valueTwo);
    }

    static function areArrayLengthsEqual(valueOne:Array<Dynamic>, valueTwo:Array<Dynamic>):Bool
    {
        return valueOne.length == valueTwo.length;
    }
	
    static function areArrayElementsEqual(valueOne:Array<Dynamic>, valueTwo:Array<Dynamic>):Bool
    {
    	for (i in 0...valueOne.length)
    		if (!areEqual(valueOne[i], valueTwo[i]))
    			return false;
        
        return true;
    }

    static function areEnumsEqual(valueOne: Dynamic, valueTwo: Dynamic):Bool
    {
        return Type.enumEq(valueOne, valueTwo);
    }

    static function isArray(value:Dynamic):Bool
    {
        return Std.is(value, Array);
    }

    static function isEnum(value: Dynamic):Bool
    {
        return switch(Type.typeof(value))
        {
        #if haxe3
            case TEnum(_): true;
            case _: false;
        #else
            case TEnum(e): true;
            default: false;
        #end
        }
    }

    /**
     * Is the value equal to another value?
     */
    // Bug in haxe generics: http://haxe.1354130.n2.nabble.com/Type-Parameters-in-Static-Methods-td6858405.html
    // public static function equalTo<T>(operand:T):Matcher<T> /
    public static function equalTo<T>(operand:Dynamic):Matcher<T> 
    {
        return new IsEqual<T>(operand);
    }
}
