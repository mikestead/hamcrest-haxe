package org.hamcrest;


class CustomMatcherTest extends AbstractMatcherTest
{
	@Test
    public function testUsesStaticDescription() 
    {
        var matcher = new SomeCustomMatcher<String>("I match strings");

        assertDescription("I match strings", matcher);
    }
}

private class SomeCustomMatcher<T> extends CustomMatcher<T>
{
	public function new(description:String)
	{
		super(description);
	}
	
    override public function matches(item:Dynamic):Bool
    {
        return Std.is(item, String);
    }
}
