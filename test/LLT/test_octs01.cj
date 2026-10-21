// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import std.io.*
import asn1.*
import std.unittest.*
import std.unittest.testmacro.*

main(): Int64 {
    let Buf: Array<Byte> = [1]
    let decs: ASN1OctetString = ASN1OctetString(Buf)
    let tags = INTEGER

    ASN1OctetString(tags,Buf)
    let src2 = decs.valueString()
    let src3 = decs.length()
    println(src2)
    println(src3)

    @Assert(src3, 1)
    return 0
}
