/****
* Copyright 2011 hamcrest.org. See LICENSE.txt
****/

package org.hamcrest.internal;

import Type.ValueType;
class TypeIdentifier
{
	private function new()
	{}
	
	public static function isIterable(value:Dynamic):Bool
	{
		if (value == null)
			return false;
			
		if (Std.is(value, Array))
			return true;

		var field = Reflect.field(value, "iterator");
		if (field != null && Reflect.isFunction(field))
			return true;
		
		var hasNextField = Reflect.field(value, "hasNext");
		var nextField = Reflect.field(value, "next");
		
		if (hasNextField != null && nextField != null && 
			Reflect.isFunction(hasNextField) && Reflect.isFunction(nextField))
			return true;
		
		return false;
	}
	
	public static function isNumber(value:Dynamic)
	{
		return switch (Type.typeof(value))
		{
			case ValueType.TFloat, ValueType.TInt: true;
			case _: false;
		}
	}
	
	public static function isComparablePrimitive(value:Dynamic):Bool
	{
		return (isNumber(value) || Std.is(value, String));
	}
	
	public static function hasCompareToFunction(value:Dynamic):Bool
	{
		var field = Reflect.field(value, "compareTo");
		return (field != null && Reflect.isFunction(field));
	}
	
	public static function isComparable(value:Dynamic):Bool
	{
		if (value == null)
			return false;
			
		if (isComparablePrimitive(value))
			return true;
		
		if (Std.is(value, Date)) // assumes we'll be comparing date.getTime()
			return true;
		
		if (hasCompareToFunction(value))
			return true;
		
		return false;
	}
}
