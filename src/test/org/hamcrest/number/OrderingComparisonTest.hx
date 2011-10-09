package org.hamcrest.number;

import org.hamcrest.AbstractMatcherTest;
import org.hamcrest.Matcher;

class OrderingComparisonTest extends AbstractMatcherTest
{
    override function createMatcher():Matcher<Dynamic>
    {
        return greaterThan(1);
    }

	@Test
    public function testDescription()
    {
		assertDescription("a value greater than <1>", greaterThan(1));
		assertDescription("a value equal to or greater than <1>", greaterThanOrEqualTo(1));
		assertDescription("a value equal to <1>", comparesEqualTo(1));
		assertDescription("a value less than or equal to <1>", lessThanOrEqualTo(1));
		assertDescription("a value less than <1>", lessThan(1));
    }

	@Test
    public function testMismatchDescriptions()
    {
		assertMismatchDescription("<0> was less than <1>", greaterThan(1), 0);
		assertMismatchDescription("<1> was equal to <1>", greaterThan(1), 1);
		assertMismatchDescription("<1> was greater than <0>", lessThan(0), 1);
    }
    
	@Test
    public function testComparesObjectsForGreaterThan()
    {
        assertThat(2, greaterThan(1));
        assertThat(0, not(greaterThan(1)));
    }

	@Test
    public function testComparesObjectsForLessThan()
    {
        assertThat(2, lessThan(3));
        assertThat(0, lessThan(1));
    }

	@Test
    public function testComparesObjectsForEquality()
    {
		assertThat(3, comparesEqualTo(3));
		assertThat("aa", comparesEqualTo("aa"));
    }

	@Test
    public function testAllowsForInclusiveComparisons()
    {
        assertThat("less", 1, lessThanOrEqualTo(1));
        assertThat("greater", 1, greaterThanOrEqualTo(1));
    }

	@Test
    public function testSupportsDifferentTypesOfComparableObjects()
    {
        assertThat(1.1, greaterThan(1.0));
        assertThat("cc", greaterThan("bb"));
    }    
}
