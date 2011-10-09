package org.hamcrest;

import org.hamcrest.Exception;
import massive.munit.Assert;

class BaseMatcherTest
{
	public function new()
	{}
	
	@Test
    public function testDescribesItselfWithToStringMethod()
    {
        var someMatcher = new SomeMatcher<Dynamic>();
        Assert.areEqual("SOME DESCRIPTION", someMatcher.toString());
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
	    throw new UnsupportedOperationException();
	    return false;
	}
	
	override public function describeTo(description:Description)
	{
	    description.appendText("SOME DESCRIPTION");
	}
}
