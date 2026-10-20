// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import std.io.*
import asn1.*
import std.unittest.*
import std.unittest.testmacro.*

main(): Int64 {
    [127, 127, 127]
    let str = ASN1ObjectIdentifier("2.3.1")
    BERDecoder()
    let decs: DEREncoder = DEREncoder()
    let sc = ObjectIdentifierSerializer(decs)

    let sq = sc.serializedLength(str)

    let wrapped: ByteBuffer = ByteBuffer()
    let asn = ASN1OutputStream(decs, wrapped)
    sc.serialize(str, asn)

    let wrapped1: ByteBuffer = ByteBuffer()
    let asn1 = ASN1OutputStream(decs, wrapped1)
    asn1.write(6)
    sc.serialize(str, asn1)
    println(sq)

    @Assert(sq, 2)
    return 0
}
