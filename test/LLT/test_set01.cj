// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import asn1.*
import std.collection.*
import std.unittest.*
import std.unittest.testmacro.*

main(): Int64 {
    var arr = HashSet<ASN1Object>()
    let buf: Array<Byte> = [1]
    var sets = ASN1Set(arr,buf)
    ASN1Set(arr)

    let src = sets.getValue()
    sets.iterator()

    println(src.size)
    @Assert(src.size, 0)
    return 0
}
