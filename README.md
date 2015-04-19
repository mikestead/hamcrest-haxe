# Hamcrest for Haxe

Port of **[hamcrest](http://code.google.com/p/hamcrest/)** for Haxe. 

Provides a library of matcher objects (also known as constraints or predicates) allowing 'match' rules to be defined declaratively, to be used in other frameworks. Typical scenarios include testing frameworks, mocking libraries and UI validation rules.

Note that hamcrest is not a testing library, it just happens that matchers are very useful for testing.

Tested against js, as3, as2, neko, cpp and php.

## Installation

Install the latest release from haxelib:

	haxelib install hamcrest

Or if you want to install the latest directly from github:

	haxelib git hamcrest https://github.com/mikestead/hamcrest-haxe.git src
	
## Usage

See [org.hamcrest.Matchers](https://github.com/mikestead/hamcrest-haxe/blob/master/src/org/hamcrest/Matchers.hx)
for the complete list of Matchers available.

Examples:

	import org.hamcrest.Matchers.*
	
	assertThat([], isEmpty());
	assertThat("foo", is("foo"));
	assertThat("foo", startsWith("f"));
	assertThat(["foo", "bar"], equalTo(["foo", "bar"]));
	assertThat(["foo", "bar"], hasItems([endsWith("r")]))
