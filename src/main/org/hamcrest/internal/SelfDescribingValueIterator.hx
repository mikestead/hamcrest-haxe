/****
* Copyright 2011 hamcrest.org. See LICENSE.txt
****/

package org.hamcrest.internal;

import org.hamcrest.SelfDescribing;

class SelfDescribingValueIterator<T>
{
    var values:Iterator<T>;
    
    public function new(values:Iterator<T>)
    {
        this.values = values;
    }
    
    public function iterator():Iterator<SelfDescribing>
    {
    	var v = values;
    	return {
    		hasNext:v.hasNext, 
    		next:function():SelfDescribing { 
    			return new SelfDescribingValue<T>(v.next());
    		}
    	}
    }
    
    public function remove() 
    {
    	while (values.hasNext())
    		values.next();
    }
}
