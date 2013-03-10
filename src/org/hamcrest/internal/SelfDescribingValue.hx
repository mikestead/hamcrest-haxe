/****
* Copyright 2011 hamcrest.org. See LICENSE.txt
****/

package org.hamcrest.internal;

import org.hamcrest.Description;
import org.hamcrest.SelfDescribing;

class SelfDescribingValue<T> implements SelfDescribing 
{
    var value:T;
    
    public function new(value:T)
    {
        this.value = value;
    }

    public function describeTo(description:Description)
    {
        description.appendValue(value);
    }
    
    public function toString():String
    {
    	return Std.string(value);
    }
}
