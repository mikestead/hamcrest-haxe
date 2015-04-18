/****
* Copyright 2011 hamcrest.org. See LICENSE.txt
****/

package org.hamcrest.internal;

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
	
	public static function isComparable(value:Dynamic):Bool
	{
		if (value == null)
			return false;
			
		if (Std.is(value, Float) || Std.is(value, Int) || Std.is(value, String))
			return true;
		
		if (Std.is(value, Date)) // assumes we'll be comparing date.getTime()
			return true;
		
		var field = Reflect.field(value, "compareTo");
		if (Reflect.isFunction(field))
			return true;
		
		return false;
	}
}
