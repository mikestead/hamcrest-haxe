package org.hamcrest;

class CustomTypeSafeMatcherTest extends AbstractMatcherTest
{
    static var STATIC_DESCRIPTION:String = "I match non empty strings";
    var customMatcher:Matcher<String>;

	@Before
    function setUp()
    {
        customMatcher = new SomeCustomTypeSafeMatcher<String>(STATIC_DESCRIPTION);
    }

	@Test
    public function testUsesStaticDescription()
    {
        assertDescription(STATIC_DESCRIPTION, customMatcher);
    }

	@Test
    public function testReportsMismatch()
    {
    	assertMismatchDescription("an item", customMatcher, "item");
    }

    override function createMatcher():Matcher<Dynamic>
    {
        return customMatcher;
    }
}

private class SomeCustomTypeSafeMatcher<T> extends CustomTypeSafeMatcher<T>
{
	public function new(description:String)
	{
		super(description);
	}
    
    override function matchesSafely(item:T):Bool
    {
        return false;
    }

    override function describeMismatchSafely(item:T, mismatchDescription:Description):Void
    {
		mismatchDescription.appendText("an " + item);
    }
    
    override function isExpectedType(type:Dynamic):Bool
    {
    	return Std.is(type, String);    
    }
}
