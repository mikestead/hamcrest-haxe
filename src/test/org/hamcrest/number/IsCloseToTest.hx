package org.hamcrest.number;

import org.hamcrest.AbstractMatcherTest;
import org.hamcrest.Matcher;
import massive.munit.Assert;

class IsCloseToTest extends AbstractMatcherTest
{
    override function createMatcher():Matcher<Dynamic>
    {
        var irrelevant = 0.1;
        return closeTo(irrelevant, irrelevant);
    }

	@Test
//	@TestDebug
    public function testEvaluatesToTrueIfArgumentIsEqualToADoubleValueWithinSomeError()
    {
        var p = closeTo(1.0, 0.5);

        Assert.isTrue(p.matches(1.0));
        Assert.isTrue(p.matches(0.5));
        Assert.isTrue(p.matches(1.5));

        assertDoesNotMatch("too large", p, 2.0);
        assertMismatchDescription("<2> differed by <0.5>", p, 2.0);
        assertDoesNotMatch("number too small", p, 0.0);
        assertMismatchDescription("<0> differed by <0.5>", p, 0.0);
    }

}
