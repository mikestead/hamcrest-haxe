import massive.munit.Assert;

class TypeParamTest
{
//	@TestDebug
//	public function shouldBeOfTypeFloat()
//	{
//		var x = 2.0;
//		trace(Std.is(x, Float));
//		trace(Std.is(x, Int));
//	}

//	@TestDebug
//	public function shouldCallToStringOnAnonObject()
//	{
//        var anon = {
//             toString:function():String {
//                return "foo";
//            }
//        };
//        
//        Assert.areEqual("foo", Std.string(anon));
//	}
	
	//@Test
	public function shouldPassSubtypeToGeneric()
	{
		Foo.call(new A(), new B()); // passes
//		Foo.call(new B(), new A()); // fails with error: A should be B
	}
	
	//@Test
	public function shouldPassSubtypeIndirectlyToGeneric()
	{
//		abstractCall(new A(), new B());
		abstractCall(new B(), new A());
	}
	
	function abstractCall(first:A, second:A)
	{
	    // should I be expected to check here which is the more deeply inherited?
		Foo.call(first, second);
	}
}
 
class Foo
{
	public static function call<T>(a:T, b:T)
	{
	}
}

class A
{
	public function new()
	{}
}

class B extends A
{
	public function new()
	{
		super();
	}
}

