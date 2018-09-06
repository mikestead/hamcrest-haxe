/****
* Copyright 2011 hamcrest.org. See LICENSE.txt
****/

package org.hamcrest;
import haxe.PosInfos;

class Exception
{
	public var name(get, null):String;
	function get_name():String { return name; }

	public var message(get, null):String;
	function get_message():String { return message; }

	public var cause(get, null):Dynamic;
	function get_cause():Dynamic { return cause; }

	public var info(default, null):PosInfos;

	public function new(?message:String="", ?cause:Dynamic = null, ?info:PosInfos)
	{
        this.name = Type.getClassName(Type.getClass(this));
        this.message = message;
        this.cause = cause;
        this.info = info;
	}


	public function toString():String
	{
        var str:String = name + ": " + message;
        if (info != null)
        	str += " at " + info.className + "#" + info.methodName + " (" + info.lineNumber + ")";
        if (cause != null)
        	str += "\n\t Caused by: " + cause;
        return str;
	}
}

class IllegalArgumentException extends Exception
{
	public function new(?message:String="Argument could not be processed.", ?cause:Dynamic = null, ?info:PosInfos)
	{
		super(message, cause, info);
	}
}

class MissingImplementationException extends Exception
{
	public function new(?message:String="Abstract method not overridden.", ?cause:Dynamic = null, ?info:PosInfos)
	{
		super(message, cause, info);
	}
}

class UnsupportedOperationException extends Exception
{
	public function new(?message:String="", ?cause:Dynamic = null, ?info:PosInfos)
	{
		super(message, cause, info);
	}
}
