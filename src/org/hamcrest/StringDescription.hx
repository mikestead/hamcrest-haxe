/****
* Copyright 2011 hamcrest.org. See LICENSE.txt
****/

package org.hamcrest;

/**
 * A {@link Description} that is stored as a string.
 */
class StringDescription extends BaseDescription
{
    var out:StringBuf;

    public function new(?out:StringBuf) 
    {
    	super();
    	if (out == null)
    		out = new StringBuf();
    	
        this.out = out;
    }
    
    /**
     * Return the description of a {@link SelfDescribing} object as a String.
     * 
     * @param selfDescribing
     *   The object to be described.
     * @return
     *   The description of the object.
     */
    public static function asString(selfDescribing:SelfDescribing):String
    {
        return (new StringDescription()).appendDescriptionOf(selfDescribing).toString();
    }

    override function append(str:String)
    {
    	out.add(str);
    }

    /**
     * Returns the description as a string.
     */
    override public function toString():String
    {
        return out.toString();
    }
}
