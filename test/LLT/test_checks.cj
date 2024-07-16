// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import asn1.*
import std.io.*

main(): Int64 {
    try {
        Checks.checkState(false, "error", Array<ToString>())
    } catch (e: Exception) {
        println(e)
    }
    Checks.checkState(true, "error", Array<ToString>())
    try {
        Checks.checkArgument(false, "error", Array<ToString>())
    } catch (e: Exception) {
        println(e)
    }
    Checks.checkArgument(true, "error", Array<ToString>())
    return 0
}
