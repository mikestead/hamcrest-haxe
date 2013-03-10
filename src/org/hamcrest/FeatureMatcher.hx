/****
* Copyright 2011 hamcrest.org. See LICENSE.txt
****/

package org.hamcrest;

import org.hamcrest.Exception;

/**
 * Supporting class for matching a feature of an object. Implement <code>featureValueOf()</code>
 * in a subclass to pull out the feature to be matched against. 
 *
 * @param <T> The type of the object to be matched
 * @param <U> The type of the feature to be matched
 */
class FeatureMatcher<T, U> extends TypeSafeDiagnosingMatcher<T>
{
	var subMatcher:Matcher<U>;
	var featureDescription:String;
	var featureName:String;
  
	/**
	 * Constructor
	 * @param subMatcher The matcher to apply to the feature
	 * @param featureDescription Descriptive text to use in describeTo
	 * @param featureName Identifying text for mismatch message
	 */
	private function new(subMatcher:Matcher<U>, featureDescription:String, featureName:String)
	{
    	super();
    	this.subMatcher = subMatcher;
    	this.featureDescription = featureDescription;
    	this.featureName = featureName;
    }
  
	/**
	 * Implement this to extract the interesting feature.
	 * @param actual the target object
	 * @return the feature to be matched
	 */
	function featureValueOf(actual:T):U
	{
    	throw new MissingImplementationException();
		return null;
	}

	override function matchesSafely(actual:T, mismatchDescription:Description):Bool
	{
		var featureValue = featureValueOf(actual);
		
		if (!subMatcher.matches(featureValue))
		{
			mismatchDescription.appendText(featureName).appendText(" ");
      		subMatcher.describeMismatch(featureValue, mismatchDescription);
      		return false;
      	}
      	return true;
	}
	
	override public function describeTo(description:Description):Void
	{
		description.appendText(featureDescription).appendText(" ")
               .appendDescriptionOf(subMatcher);
	}
}
