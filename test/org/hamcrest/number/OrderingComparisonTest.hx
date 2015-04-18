package org.hamcrest.number;

import org.hamcrest.AbstractMatcherTest;
import org.hamcrest.Matcher;

class OrderingComparisonTest extends AbstractMatcherTest
{
	static var DATE:Float = 1428353816414.0;

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
		var dateOne = Date.fromTime(DATE + 1000);
		var dateTwo = Date.fromTime(DATE);
	
		assertThat(2, greaterThan(1));
		assertThat(2.7, greaterThan(1.9));
		assertThat("cc", greaterThan("bb"));
		assertThat(0, not(greaterThan(1)));
		assertThat(dateOne, greaterThan(dateTwo));
		assertThat(new ComparatorEg(3), greaterThan(new ComparatorEg(2)));
	}

	@Test
	public function testComparesObjectsForLessThan()
	{
		var dateOne = Date.fromTime(DATE);
		var dateTwo = Date.fromTime(DATE + 1000);

		assertThat(2, lessThan(3));
		assertThat(2.3, lessThan(4.5));
		assertThat("bb", lessThan("cc"));
		assertThat(dateOne, lessThan(dateTwo));
		assertThat(new ComparatorEg(1), lessThan(new ComparatorEg(2)));
	}

	@Test
	public function testComparesObjectsForEquality()
	{
		var dateOne = Date.fromTime(DATE);
		var dateTwo = Date.fromTime(DATE);
		assertThat(3, comparesEqualTo(3));
		assertThat(3.3, comparesEqualTo(3.3));
		assertThat("aa", comparesEqualTo("aa"));
		assertThat(dateOne, comparesEqualTo(dateTwo));
		assertThat(new ComparatorEg(1), comparesEqualTo(new ComparatorEg(1)));
	}

	@Test
	public function testAllowsForInclusiveComparisons()
	{
		assertThat(1, lessThanOrEqualTo(1), "less");
		assertThat(1, greaterThanOrEqualTo(1), "greater");
	}
}

private class ComparatorEg
{
	public var value:Int;

	public function new(value:Int)
	{
		this.value = value;
	}

	public function compareTo(data:Dynamic):Int
	{
		var expected = -1;
		if (Std.is(data, ComparatorEg))
			expected = data.value;
		else if (Std.is(data, Int) || Std.is(data, Float))
			expected = data;
		return Reflect.compare(value, expected);
	}
}
