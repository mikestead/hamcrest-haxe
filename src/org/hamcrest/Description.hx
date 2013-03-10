/****
* Copyright 2011 hamcrest.org. See LICENSE.txt
****/

package org.hamcrest;

/**
 * A description of a Matcher. A Matcher will describe itself to a description
 * which can later be used for reporting.
 *
 * @see Matcher#describeTo(Description)
 */
interface Description 
{  
    /**
     * Appends some plain text to the description.
     */
    function appendText(text:String):Description;

    /**
     * Appends the description of a {@link SelfDescribing} value to this description.
     */
    function appendDescriptionOf(value:SelfDescribing):Description;

    /**
     * Appends an arbitary value to the description.
     */
    function appendValue(value:Dynamic):Description;

    /**
     * Appends a list of values to the description.
     */
//    function <T> appendValueList(start:String, separator:String, end:String, values:Array<T>):Description;

    /**
     * Appends a list of values to the description.
     */
    function appendValueList<T>(start:String, separator:String, end:String, values:Iterable<T>):Description;

    /**
     * Appends a list of {@link org.hamcrest.SelfDescribing} objects
     * to the description.
     */
    function appendList(start:String, separator:String, end:String, values:Iterable<SelfDescribing>):Description;
    
    function toString():String;
}

class NullDescription implements Description 
{
	/**
	 * A description that consumes input but does nothing.
	 */
	public static var NONE:Description = new NullDescription();
	
	public function new()
	{}

	public function appendDescriptionOf(value:SelfDescribing):Description
	{
		return this;
	}
	
	public function appendList(start:String, separator:String, end:String, values:Iterable<SelfDescribing>):Description
	{
		return this;
	}
	
	public function appendText(text:String):Description
	{
		return this;
	}
	
	public function appendValue(value:Dynamic):Description
	{
		return this;
	}
	
	public function appendValueList<T>(start:String, separator:String, end:String, values:Iterable<T>):Description
	{
		return this;
	}
	
	public function toString():String
	{
		return "";
	}
}

