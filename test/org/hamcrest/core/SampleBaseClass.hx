package org.hamcrest.core;

class SampleBaseClass
{
    var value:String;

    public function new(value:String)
    {
        this.value = value;
    }

    public function toString():String
    {
        return value;
    }

    public function equals(obj:Dynamic):Bool
    {
        return Std.isOfType(obj, SampleBaseClass) && value == cast(obj, SampleBaseClass).value;
    }
}
