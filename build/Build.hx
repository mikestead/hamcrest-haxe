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
		t.description = "Provides a library of matcher objects (also known as constraints or predicates) allowing 'match' rules to be defined declaratively, to be used in other frameworks. Typical scenarios include testing frameworks, mocking libraries and UI validation rules.";
		t.versionDescription = "Add haxelib.json ready to release to new haxelib.";
		t.username = "mikestead";
		t.addTag("cross");
		t.addTag("unittest");

		t.beforeCompile = function(path:String)
		{
			cp("LICENSE.txt", path);
			cp("src/*", path);
		}
	}
}
