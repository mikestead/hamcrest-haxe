/****
* Copyright 2011 hamcrest.org. See LICENSE.txt
****/

package org.hamcrest;

import org.hamcrest.internal.SelfDescribingValueIterator;
import org.hamcrest.Exception;

using org.hamcrest.TypedefChecker;

/**
 * A {@link Description} that is stored as a string.
 */
class BaseDescription implements Description
{
	private function new()
	{}
	
    public function appendText(text:String):Description
    {
        append(text);
        return this;
    }
    
    public function appendDescriptionOf(value:SelfDescribing):Description
    {
        value.describeTo(this);
        return this;
    }
    
    public function appendValue(value:Dynamic):Description
    {
        if (value == null)
        {
            append("null");
        }
        else if (Std.is(value, String))
        {
            escapeAndAppend(cast(value, String));
        }
        else if (value.isIterable())
        {
           appendValueList("[",", ","]", value); 
        }
        // would like to do seperate check for float value an ensure it has decimal place printed
        // but platform limitation / bug mean not possible.
        // See http://code.google.com/p/haxe/issues/detail?id=536
        else
        {
            append('<');
            append(objectAsString(value));
            append('>');
        }
        return this;
    }
    
    public function appendValueList<T>(start:String, separator:String, end:String, values:Iterable<T>):Description
    {
        return appendList(start, separator, end, new SelfDescribingValueIterator<T>(values.iterator()));
    }
        
    public function appendList(start:String, separator:String, end:String, values:Iterable<SelfDescribing>):Description
    {
     	var separate = false;
        
        append(start);
        for (value in values)
        {
            if (separate) 
            	append(separator);
            
            appendDescriptionOf(value);
            separate = true;
        }
        append(end);
        
        return this;
    }
    
    /**
     * Append the String <var>str</var> to the description.  
     */
    function append(str:String)
    {
    	throw new MissingImplementationException();
    }

    function escapeAndAppend(unformatted:String)
    {
        append('"');
        for (i in 0...unformatted.length)
        {
        	var ch = unformatted.charAt(i);
		    switch (ch)
		    {
		        case '"':
		            append("\\\"");
		        case '\n':
		            append("\\n");
		        case '\r':
		            append("\\r");
		        case '\t':
		            append("\\t");
		        default:
		            append(ch);
		    }
        }
        append('"');
    }
    
    // workaround for bug http://code.google.com/p/haxe/issues/detail?id=533
    function objectAsString(value:Dynamic):String
    {
    	var field = Reflect.field(value, "toString");
    	if (field != null && Reflect.isFunction(field))
    		return Reflect.callMethod(value, field, []);
    	return Std.string(value);
    }
    
    public function toString():String
    {
    	return Type.getClassName(Type.getClass(this));
    }
}
