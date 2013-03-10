/****
* Copyright 2011 hamcrest.org. See LICENSE.txt
****/

package org.hamcrest;

import org.hamcrest.Description;
import org.hamcrest.Exception;

/**
 * @param <T>
 */
class DiagnosingMatcher<T> extends BaseMatcher<T>
{
	private function new()
	{
		super();
	}
	
	override public function matches(item:Dynamic):Bool
	{
		return isMatch(item, NullDescription.NONE);
	}

	override public function describeMismatch(item:Dynamic, mismatchDescription:Description)
	{
		isMatch(item, mismatchDescription);
	}

	function isMatch(item:Dynamic, mismatchDescription:Description):Bool
	{
    	throw new MissingImplementationException();
    	return false;
	}
}
