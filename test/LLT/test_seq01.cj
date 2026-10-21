// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import asn1.*
import std.collection.*
import std.unittest.*
import std.unittest.testmacro.*

main(): Int64 {
    var arr = ArrayList<ASN1Object>()
    var seq = ASN1Sequence(arr)
    let src = seq.size()
    var es: String = ""
    try {
        seq.get(1)
    } catch (e: Exception) {
        es = e.toString()
    }

    @Assert(src, 0)
    @Assert(es, "IndexOutOfBoundsException: index: 1, size: 0")
    return 0
}
