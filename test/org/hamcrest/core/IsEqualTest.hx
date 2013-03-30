package org.hamcrest.core;

import org.hamcrest.AbstractMatcherTest;
import org.hamcrest.Matcher;

import org.hamcrest.core.SampleEnum;

class IsEqualTest extends AbstractMatcherTest
{
    override function createMatcher():Matcher<Dynamic>
    {
        return equalTo("irrelevant");
    }

	@Test
    public function testComparesObjectsUsingEqualsMethod()
    {
        assertThat("hi", equalTo("hi"));
        assertThat("bye", not(equalTo("hi")));

        assertThat(1, equalTo(1));
        assertThat(1, not(equalTo(2)));
    }

    @Test
    public function testCompareEnums()
    {
        assertThat(SampleEmpty,                     equalTo(SampleEmpty));
        assertThat(SampleString("str"),             equalTo(SampleString("str")));
        assertThat(SampleStringAndInt("str", 10),   equalTo(SampleStringAndInt("str", 10)));

        assertThat(SampleInnerEnum(SampleEmpty2),   equalTo(SampleInnerEnum(SampleEmpty2)));
        assertThat(SampleInnerEnum(SampleString2("str")),
            equalTo(SampleInnerEnum(SampleString2("str"))));

        assertThat(SampleEmpty,                     not(equalTo(null)));
        assertThat(null,                            not(equalTo(SampleStringAndInt("str", 10))));
        assertThat(SampleStringAndInt("str", 10),   not(equalTo(SampleStringAndInt("str", 15))));
    }

    @Test
    public function testCompareInnerEnums()
    {
        assertThat(SampleInnerEnum(SampleStringAndInt2("str", 10)),
            not(equalTo(SampleInnerEnum(SampleStringAndInt2("str", 15)))));
    }

	@Test
    public function testCanCompareNullValues()
    {
        assertThat(null, equalTo(null));

        assertThat(null, not(equalTo("hi")));
        assertThat("hi", not(equalTo(null)));
    }

	@Test
    public function testHonoursIsEqualImplementationEvenWithNullValues()
    {
        var alwaysEqual = {
            equals:function(obj:Dynamic):Bool {
                return true;
            }
        };
        var neverEqual = {
            equals:function(obj:Dynamic):Bool {
                return false;
            }
        };

        assertThat(alwaysEqual, equalTo(null));
        assertThat(neverEqual, not(equalTo(null)));
    }
    
	@Test
    public function testComparesTheElementsOfAnObjectArray()
    {
        var s1 = ["a", "b"];
        var s2 = ["a", "b"];
        var s3 = ["c", "d"];
        var s4 = ["a", "b", "c", "d"];

        assertThat(s1, equalTo(s1));
        assertThat(s2, equalTo(s1));
        assertThat(s3, not(equalTo(s1)));
        assertThat(s4, not(equalTo(s1)));
    }

	@Test
    public function testComparesArraysToNull()
    {
        assertThat(["a", "b"], not(equalTo(null)));
        assertThat(null, not(equalTo(["a", "b"])));
    }

	@Test
    public function testComparesTheElementsOfAnArrayOfPrimitiveTypes()
    {
        var i1 = [1, 2];
        var i2 = [1, 2];
        var i3 = [3, 4];
        var i4 = [1, 2, 3, 4];

        assertThat(i1, equalTo(i1));
        assertThat(i2, equalTo(i1));
        assertThat(i3, not(equalTo(i1)));
        assertThat(i4, not(equalTo(i1)));
    }

	@Test
    public function testRecursivelyTestsElementsOfArrays()
    {
        var i1 = [[1, 2], [3, 4]];
        var i2 = [[1, 2], [3, 4]];
        var i3 = [[5, 6], [7, 8]];
        var i4 = [[1, 2, 3, 4], [3, 4]];

        assertThat(i1, equalTo(i1));
        assertThat(i2, equalTo(i1));
        assertThat(i3, not(equalTo(i1)));
        assertThat(i4, not(equalTo(i1)));
    }

	@Test
    public function testIncludesTheResultOfCallingToStringOnItsArgumentInTheDescription()
    {
        var argumentDescription = "ARGUMENT DESCRIPTION";
        var argument = {
             toString:function():String {
                return argumentDescription;
            }
        };
        assertDescription("<" + argumentDescription + ">", equalTo(argument));
    }

	@Test
    public function testReturnsAnObviousDescriptionIfCreatedWithANestedMatcherByMistake()
    {
        var innerMatcher = equalTo("NestedMatcher");
        assertDescription("<" + innerMatcher.toString() + ">", equalTo(innerMatcher));
    }

	@Test
    public function testReturnsGoodDescriptionIfCreatedWithNullReference()
    {
        assertDescription("null", equalTo(null));
    }
}

