// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import asn1.*
import std.io.*
import std.unittest.*
import std.unittest.testmacro.*

main(): Int64 {
    let str = ASN1Enumerated(8)
    let sss6 = str.equals(str)
    println(sss6)
    let dec: DEREncoder = DEREncoder()

    let sc = EnumeratedSerializer(dec)
    let sc1 = sc.serializedLength(str)
    let wrapped: ByteBuffer = ByteBuffer()
    let asn = ASN1OutputStream(dec,wrapped)
    sc.serialize(str,asn)
    println(sc1)

    @Assert(sc1, 1)
    return 0
}
