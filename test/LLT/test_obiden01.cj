// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import asn1.*
import std.io.*
import std.unittest.*
import std.unittest.testmacro.*

main(): Int64 {
    let Buf: Array<Byte> = [1]
    let dec: ASN1ObjectIdentifier = ASN1ObjectIdentifier("ascsc")
    ASN1ObjectIdentifier("ascsc",Buf)
    let src = dec.getValue()
    let src1 = (src as String).getOrThrow()
    println(src1)

    @Assert(src1, "ascsc")
    return 0
}
