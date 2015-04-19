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
		assertThat(dateOne.getTime(), greaterThan(dateTwo));
		assertThat(dateOne, greaterThan(dateTwo.getTime()));
		assertThat(dateOne, greaterThan(new ComparatorEg(dateTwo.getTime())));
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
		assertThat(dateOne.getTime(), lessThan(dateTwo));
		assertThat(dateOne, lessThan(dateTwo.getTime()));
		assertThat(dateOne, lessThan(new ComparatorEg(dateTwo.getTime())));
		assertThat(1, lessThan(new ComparatorEg(2)));
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
		assertThat(dateOne.getTime(), comparesEqualTo(dateTwo));
		assertThat(dateOne, comparesEqualTo(dateTwo.getTime()));
		assertThat(dateOne, comparesEqualTo(new ComparatorEg(dateTwo.getTime())));
		assertThat(1, comparesEqualTo(new ComparatorEg(1)));
		assertThat(new ComparatorEg(1), comparesEqualTo(new ComparatorEg(1)));
	}

	@Test
	public function testAllowsForLessThanInclusiveComparisons()
	{
		var dateOne = Date.fromTime(DATE);
		var dateTwo = Date.fromTime(DATE + 1000);

		assertThat(1, lessThanOrEqualTo(1), "less");
		assertThat(1, lessThanOrEqualTo(2), "less");
		
		assertThat("aa", lessThanOrEqualTo("aa"), "less");
		assertThat("aa", lessThanOrEqualTo("bb"), "less");

		assertThat(DATE, lessThanOrEqualTo(DATE), "less");
		assertThat(dateOne, lessThanOrEqualTo(dateTwo), "less");
		assertThat(dateOne.getTime(), lessThanOrEqualTo(dateTwo), "less");
		
		assertThat(dateOne, lessThanOrEqualTo(dateTwo.getTime()), "less");
		assertThat(dateOne, lessThanOrEqualTo(new ComparatorEg(dateTwo.getTime())), "less");
	}
	
	@Test
	public function testAllowsForGreaterThanInclusiveComparisons()
	{
		var dateOne = Date.fromTime(DATE + 1000);
		var dateTwo = Date.fromTime(DATE);

		assertThat(1, greaterThanOrEqualTo(1), "greater");
		assertThat(2, greaterThanOrEqualTo(1), "greater");

		assertThat("aa", greaterThanOrEqualTo("aa"), "greater");
		assertThat("bb", greaterThanOrEqualTo("aa"), "greater");

		assertThat(DATE, greaterThanOrEqualTo(DATE), "greater");
		assertThat(dateOne, greaterThanOrEqualTo(dateTwo), "greater");
		assertThat(dateOne.getTime(), greaterThanOrEqualTo(dateTwo), "greater");

		assertThat(dateOne, greaterThanOrEqualTo(dateTwo.getTime()), "greater");
		assertThat(dateOne, greaterThanOrEqualTo(new ComparatorEg(dateTwo.getTime())), "greater");
	}
}

private class ComparatorEg
{
	public var value:Float;

	public function new(value:Float)
	{
		this.value = value;
	}

	public function compareTo(data:Dynamic):Int
	{
		var expected:Float = -1;
		if (Std.is(data, ComparatorEg))
			expected = data.value;
		else if (Std.is(data, Int) || Std.is(data, Float))
			expected = data;
		else if (Std.is(data, Date))
			expected = cast(data, Date).getTime();
		
		return Reflect.compare(value, expected);
	}
}
