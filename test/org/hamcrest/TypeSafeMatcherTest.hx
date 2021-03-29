package org.hamcrest;

import massive.munit.Assert;

class TypeSafeMatcherTest
{
    var matcher:Matcher<String>;
    
    @Before
    public function setUp()
    {
    	matcher = new TypeSafeMatcherSubclass();
    }
    
    @Test
    public function testCanDetermineMatcherTypeFromProtectedMatchesSafelyMethod()
    {
        Assert.isFalse(matcher.matches(null));
        Assert.isFalse(matcher.matches(10));
    }
    
    @Test
//    @TestDebug
    public function testDescribesMismatches()
    {
		assertMismatchDescription("was null", null);
		assertMismatchDescription("was a org.hamcrest.TestValue (<3>)", new TestValue(3));
		assertMismatchDescription("The mismatch", "a string");
    }

    function assertMismatchDescription(expectedDescription:String, actual:Dynamic)
    {
		var description = new StringDescription();
		matcher.describeMismatch(actual, description);
		Assert.areEqual(expectedDescription, description.toString());
    }
}

class TypeSafeMatcherSubclass extends TypeSafeMatcher<String>
{
	public function new()
	{
		super();
	}
	
    override function matchesSafely(item:String):Bool
    {
        return false;
    }

    override function describeMismatchSafely(item:String, mismatchDescription:Description)
    {
    	mismatchDescription.appendText("The mismatch");
    }

    override public function describeTo(description:Description):Void
    {
    }
    
    override function isExpectedType(type:Dynamic):Bool
    {
    	return Std.isOfType(type, String);    
    }
}


class TestValue
{
	var i:Int;
	public function new(i:Int)
	{
		this.i = i;
	}
	
	public function toString():String
	{
		return "" + i;
	}
}