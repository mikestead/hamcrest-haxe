/****
* Copyright 2011 hamcrest.org. See LICENSE.txt
****/

package org.hamcrest.internal;

#if haxe3
typedef StringMap<T> = haxe.ds.StringMap<T>;
#else
typedef StringMap<T> = Hash<T>;
#end
