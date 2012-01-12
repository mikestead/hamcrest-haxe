package org.hamcrest;

import massive.munit.Assert;
import haxe.PosInfos;

class ExceptionTest extends MatchersBase
{
	public function new()
	{
		super();
	}

	@Test
	public function shouldAutoSetName()
	{
		var e = new Exception("");
		assertThat("org.hamcrest.Exception", equalTo(e.name)) ;
	}

	@Test
	public function shouldAllowCustomName()
	{
		var e = new CustomException();
		assertThat("custom name", equalTo(e.name));
	}
}

class CustomException extends Exception
{
	public function new()
	{
		super("");
	}

	override function get_name():String
	{
		return "custom name";
	}
}