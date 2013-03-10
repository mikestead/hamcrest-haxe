package org.hamcrest;

import org.hamcrest.MatcherAssert;
import org.hamcrest.core.IsEqual;

import massive.munit.Assert;

using StringTools;

class MatcherAssertTest
{
	@Test
    public function testIncludesDescriptionOfTestedValueInErrorMessage()
    {
        var expected = "expected";
        var actual = "actual";
        
        var expectedMessage = "identifier\nExpected: \"expected\"\n     but: was \"actual\"";
        
        try
        {
            MatcherAssert.assertThat("identifier", actual, IsEqual.equalTo(expected));
        }
        catch (e:AssertionException) 
        {
            Assert.isTrue(e.message.startsWith(expectedMessage));
            return;
        }
        
        Assert.fail("should have failed");
    }

	@Test
    public function testDescriptionCanBeElided()
    {
        var expected = "expected";
        var actual = "actual";
        
        var expectedMessage = "\nExpected: \"expected\"\n     but: was \"actual\"";
        
        try
        {
            MatcherAssert.assertThat(actual, IsEqual.equalTo(expected));
        }
        catch (e:AssertionException)
        {
            Assert.isTrue(e.message.startsWith(expectedMessage));
            return;
        }
        
        Assert.fail("should have failed");
    }
    
    @Test
    public function testCanTestBooleanDirectly()
    {
        MatcherAssert.assertThat("success reason message", true);
        
        try
        {
            MatcherAssert.assertThat("failing reason message", false);
        }
        catch (e:AssertionException)
        {
        	Assert.areEqual("failing reason message", e.message);
            return;
        }
        
        Assert.fail("should have failed");
    }

	@Test
    public function testIncludesMismatchDescription()
    {
		var matcherWithCustomMismatchDescription = new SomeMatcher<String>();
		
		var expectedMessage = "\nExpected: Something cool\n     but: Not cool";
		
		try
		{ 
			MatcherAssert.assertThat("Value", matcherWithCustomMismatchDescription);
			Assert.fail("should have failed");
		}
		catch (e:AssertionException)
		{
			Assert.areEqual(expectedMessage, e.message);
		}
    }
}

private class SomeMatcher<T> extends BaseMatcher<T>
{
	public function new()
	{
		super();
	}
	
	override public function matches(item:Dynamic):Bool
	{
		return false;
	}
	
	override public function describeTo(description:Description)
	{
		description.appendText("Something cool");
	}
	
	override public function describeMismatch(item:Dynamic, mismatchDescription:Description)
	{
		mismatchDescription.appendText("Not cool");
	}
}
