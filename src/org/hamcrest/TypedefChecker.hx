/****
* Copyright 2011 hamcrest.org. See LICENSE.txt
****/

package org.hamcrest;

class TypedefChecker
{
	private function new()
	{}
	
	public static function isIterable(value:Dynamic):Bool
	{
		if (value == null)
			return false;
			
		if (Std.is(value, Array))
			return true;

		if (hasField(value, "iterator") && Reflect.isFunction(Reflect.field(value, "iterator")))
			return true;
		
		if (hasField(value, "hasNext") && hasField(value, "next") &&
				Reflect.isFunction(Reflect.field(value, "hasNext")) && 
				Reflect.isFunction(Reflect.field(value, "next")))
			return true;
		
		return false;
	}
	
	// workaround for bug http://code.google.com/p/haxe/issues/detail?id=535
	static function hasField(value:Dynamic, fieldName:String):Bool
	{
		var type = Type.getClass(value);
		if (type != null)
		{
			var fieldNames = Type.getInstanceFields(type);
			for (field in fieldNames)
				if (field == fieldName)
				{
					return true;
				}
			
			return false;
		}
		return Reflect.hasField(value, fieldName);
	}
	
	public static function isComparable(value:Dynamic):Bool
	{
		if (value == null)
			return false;
			
		if (Std.is(value, Float) || Std.is(value, Int) || Std.is(value, String))
			return true;
			
		if (hasField(value, "compareTo") && Reflect.isFunction(Reflect.field(value, "compareTo")))
			return true;
		
		if (hasField(value, "__compare") && Reflect.isFunction(Reflect.field(value, "__compare")))
			return true;
		
		return false;
	}
}