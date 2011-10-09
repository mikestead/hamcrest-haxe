package org.hamcrest.core;

import org.hamcrest.StringDescription;
import org.hamcrest.MatcherBuilderBase;
import massive.munit.Assert;

class CombinableTest extends MatcherBuilderBase
{
    var EITHER_3_OR_4:CombinableMatcher<Dynamic>;
    var NOT_3_AND_NOT_4:CombinableMatcher<Dynamic>;

	@Before
	public function setUp()
	{
		EITHER_3_OR_4 = either(equalTo(3)).or(equalTo(4));
		NOT_3_AND_NOT_4 = both(not(equalTo(3))).and(not(equalTo(4)));
	}
	
    @Test
    public function bothAcceptsAndRejects()
    {
        assertThat(2, NOT_3_AND_NOT_4);
        assertThat(3, not(NOT_3_AND_NOT_4));
    }

    @Test
    public function acceptsAndRejectsThreeAnds()
    {
        var tripleAnd = NOT_3_AND_NOT_4.and(equalTo(2));
        assertThat(2, tripleAnd);
        assertThat(3, not(tripleAnd));
    }


    @Test
    public function bothDescribesItself()
    {
        Assert.areEqual("(not <3> and not <4>)", NOT_3_AND_NOT_4.toString());

        var mismatch = new StringDescription();
        NOT_3_AND_NOT_4.describeMismatch(3, mismatch);
        Assert.areEqual("was <3>", mismatch.toString());
    }

    @Test 
    public function eitherAcceptsAndRejects()
    {
        assertThat(3, EITHER_3_OR_4);
        assertThat(6, not(EITHER_3_OR_4));
    }

    @Test
    public function acceptsAndRejectsThreeOrs()
    {
        var either3or4orGreaterThan10 = EITHER_3_OR_4.or(greaterThan(10));
        assertThat(11, either3or4orGreaterThan10);
        assertThat(9, not(either3or4orGreaterThan10));
    }

    @Test
    public function eitherDescribesItself()
    {
        Assert.areEqual("(<3> or <4>)", EITHER_3_OR_4.toString());
        var mismatch = new StringDescription();

        EITHER_3_OR_4.describeMismatch(6, mismatch);
        Assert.areEqual("was <6>", mismatch.toString());
    }

    @Test
    public function picksUpTypeFromLeftHandSideOfExpression()
    {
        assertThat("yellow", both(equalTo("yellow")).and(notNullValue()));
    }
}
