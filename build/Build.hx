import mtask.target.HaxeLib;

class Build extends mtask.core.BuildBase
{
	public function new()
	{
		super();
	}

	@target function haxelib(t:HaxeLib)
	{
		t.url = "https://github.com/mikestead/hamcrest-haxe";
		t.description = "A library of Matchers (also known as constraints or predicates) allowing 'match' rules to be defined declaratively, to be used in other frameworks. Typical scenarios include testing frameworks, mocking libraries and UI validation rules.";
		t.versionDescription = "See https://github.com/mikestead/hamcrest-haxe/blob/master/CHANGES.md";
		t.username = "mikestead";
		t.license = HaxeLibLicense.BSD;
		t.addTag("cross");
		t.addTag("unit");
		t.addTag("unittest");
		t.addTag("test");
		t.addTag("matchers");

		t.beforeCompile = function(path:String)
		{
			cp("LICENSE.txt", path);
			cp("src/*", path);
		}
	}

	@task function test()
	{
		mtask.tool.HaxeLib.run("munit", ["test", "-coverage"]);
	}
}
