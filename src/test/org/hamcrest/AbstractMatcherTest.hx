package org.hamcrest;

import org.hamcrest.Exception;
import massive.munit.Assert;
import haxe.PosInfos;

class AbstractMatcherTest extends MatchersBase
{
    /**
     * Create an instance of the Matcher so some generic safety-net tests can be run on it.
     */
    function createMatcher():Matcher<Dynamic>
    {
    	throw new MissingImplementationException();
    	return null;
    }

    public function assertMatches<T>(message:String, c:Matcher<T>, arg:T, ?info:PosInfos)
    {
        Assert.isTrue(c.matches(arg), info);
    }

    public function assertDoesNotMatch<T>(message:String, c:Matcher<T>, arg:T, ?info:PosInfos)
    {
        Assert.isFalse(c.matches(arg), info);
    }

    public function assertDescription(expected:String, matcher:Matcher<Dynamic>, ?info:PosInfos)
    {
        var description:Description = new StringDescription();
        description.appendDescriptionOf(matcher);
        Assert.areEqual(expected, description.toString(), info);
    }

    public function assertMismatchDescription<T>(expected:String, matcher:Matcher<T>, arg:T, ?info:PosInfos)
    {
        var description:Description = new StringDescription();
        Assert.isFalse(matcher.matches(arg), info);
        matcher.describeMismatch(arg, description);
        Assert.areEqual(expected, description.toString(), info);
    }

    public function testIsNullSafe()
    {
       // should not throw a NullPointerException
       createMatcher().matches(null);
    }

    public function testCopesWithUnknownTypes()
    {
        // should not throw ClassCastException
        createMatcher().matches(new UnknownType());
    }
}

class UnknownType
{
	public function new()
	{
	}
}

