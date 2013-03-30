package org.hamcrest.core;

enum SampleEnum
{
	SampleEmpty;
	SampleString(s: String);
	SampleStringAndInt(s: String, i: Int);
	SampleInnerEnum(e: SampleEnum2);
}

enum SampleEnum2
{
	SampleEmpty2;
	SampleString2(s: String);
	SampleStringAndInt2(s: String, i: Int);
}