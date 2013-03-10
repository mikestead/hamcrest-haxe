/****
* Copyright 2011 hamcrest.org. See LICENSE.txt
****/

package org.hamcrest;

import org.hamcrest.Exception;

/**
 * Utility class for writing one off matchers.
 * For example:
 * <pre>
 * Matcher&lt;String&gt; aNonEmptyString = new CustomTypeSafeMatcher&lt;String&gt;("a non empty string") {
 *   public boolean matchesSafely(String string) {
 *     return !string.isEmpty();
 *   }
 *   public void describeMismatchSafely(String string, Description mismatchDescription) {
 *     mismatchDescription.appendText("was empty");
 *   }
 * };
 * </pre>
 * This is a variant of {@link CustomMatcher} that first type checks
 * the argument being matched. By the time {@link #matchesSafely(T)}
 * is called the argument is guaranteed to be non-null and of the correct
 * type.
 *
 * @author Neil Dunn
 * @param <T> The type of object being matched
 */
class CustomTypeSafeMatcher<T> extends TypeSafeMatcher<T>
{
    var fixedDescription:String;

	/**
     * @param type The expected type. Forced to pass this in manually as can't find type of generic at runtime.
	 */
    private function new(description:String)
    {
    	super();
    	
        if (description == null)
            throw new IllegalArgumentException("Description must not be null.");
        
        this.fixedDescription = description;
    }

    override public function describeTo(description:Description)
    {
        description.appendText(fixedDescription);
    }
}
