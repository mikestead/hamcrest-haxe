/****
* Copyright 2011 hamcrest.org. See LICENSE.txt
****/

package org.hamcrest.core;

import org.hamcrest.BaseMatcher;
import org.hamcrest.Description;
import org.hamcrest.Matcher;

using StringTools;

/**
 * Provides a custom description to another matcher.
 */
class DescribedAs<T> extends BaseMatcher<T>
{
    var descriptionTemplate:String;
    var matcher:Matcher<T>;
    var values:Array<Dynamic>;
    
    public function new(descriptionTemplate:String, matcher:Matcher<T>, ?values:Array<Dynamic>)
    {
    	super();
        this.descriptionTemplate = descriptionTemplate;
        this.matcher = matcher;
        if (values == null) values = [];
        this.values = values.concat([]);
    }
    
    override public function matches(value:Dynamic):Bool
    {
        return matcher.matches(value);
    }

    override public function describeTo(description:Description):Void
    {
    	// regex not supported by all platforms so parsing manually
     	var parts = descriptionTemplate.split("%");
     	description.appendText(parts.shift());
     	
     	while (parts.length > 0)
     	{
     		var part = parts.shift();
	        var j = 0;
     		var istr:String = part.charAt(j++);
	        var i:Null<Int> = Std.parseInt(istr);
	        var value:String = "";
	        
	        while (i != null && !(i == 0 && istr != "0"))
	        {
	        	value += istr;
	        	
	        	if (j >= part.length)
	        		break;
	        		
	     		istr = part.charAt(j++);
		        i = Std.parseInt(istr);
	        }
	        
	        if (value == "")
	        {
		    	description.appendText("$" + part);
		    }
		    else
		    {
		        var index = Std.parseInt(value);
		        description.appendValue(values[index]);
		        
		        if (part.length > value.length)
		        	description.appendText(part.substr(value.length));
		    }
		}
    }
    
//    function describeTo(description:Description)
//    {
//		var str = descriptionTemplate;
//		var regex = ~/\$[0-9]+/;
//		while (regex.match(str))
//		{
//			var start = regex.matchedPos().pos;
//			var length = regex.matchedPos().len;
//			var textStart = str.substr(0, start);
//			var index = Std.parseInt(str.substr(start + 1, length - 1));
//			
//			description.appendText(textStart);
//			description.appendValue(values[index]);
//			
//			str = str.substr(start + length);
//		}
//		
//		if (str.length > 0)
//			description.appendText(str);
//    }
    
    override public function describeMismatch(item:Dynamic, description:Description)
    {
        matcher.describeMismatch(item, description);
    }

    /**
     * Wraps an existing matcher and overrides the description when it fails.
     */
    public static function describedAs<T>(description:String, matcher:Matcher<T>, ?values:Array<Dynamic>):Matcher<T> 
    {
        return new DescribedAs<T>(description, matcher, values);
    }
}
