// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import asn1.*
import std.io.*
import std.unittest.*
import std.unittest.testmacro.*

main(): Int64 {
    // checkState(false) 应抛异常
    var caught1: Bool = false
    try {
        Checks.checkState(false, "error", Array<ToString>())
    } catch (e: Exception) {
        println(e)
        caught1 = true
    }
    @Assert(caught1, true)

    Checks.checkState(true, "error", Array<ToString>())

    // checkArgument(false) 应抛异常
    var caught2: Bool = false
    try {
        Checks.checkArgument(false, "error", Array<ToString>())
    } catch (e: Exception) {
        println(e)
        caught2 = true
    }
    @Assert(caught2, true)

    Checks.checkArgument(true, "error", Array<ToString>())
    return 0
}
