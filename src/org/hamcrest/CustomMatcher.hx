/****
* Copyright 2011 hamcrest.org. See LICENSE.txt
****/

package org.hamcrest;

import org.hamcrest.Exception;

/**
 * Utility class for writing one off matchers.
 * For example:
 * <pre>
 * Matcher&lt;String&gt; aNonEmptyString = new CustomMatcher&lt;String&gt;("a non empty string") {
 *   public boolean matches(Object object) {
 *     return ((object instanceof String) && !((String) object).isEmpty();
 *   }
 * };
 * </pre>
 * <p>
 * This class is designed for scenarios where an anonymous inner class
 * matcher makes sense. It should not be used by API designers implementing
 * matchers.
 *
 * @see CustomTypeSafeMatcher for a type safe variant of this class that you probably
 *  want to use.
 * @param <T> The type of object being matched.
 */
class CustomMatcher<T> extends BaseMatcher<T>
{
    var fixedDescription:String;

    public function new(description:String)
    {
    	super();
    	
        if (description == null)
            throw new IllegalArgumentException("Description must not be null.");
        
        this.fixedDescription = description;
    }

    override public function describeTo(description:Description):Void
    {
        description.appendText(fixedDescription);
    }
}
