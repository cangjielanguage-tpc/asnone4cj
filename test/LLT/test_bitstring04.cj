// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import std.io.*
import asn1.*
import std.unittest.*
import std.unittest.testmacro.*

main(): Int64 {
    let dec: DEREncoder = DEREncoder()

    let tags = INTEGER
    let decz: BERDecoder = BERDecoder()
    let bitss = BooleanParser(decz)
    let Buf: Array<Byte> = [1]
    let ssc = bitss.parse(tags,Buf)

    let enu = EnumeratedSerializer(dec)
    let decodetd: DEREncoder = DEREncoder()
    let wrapped: ByteBuffer = ByteBuffer()
    let asn = ASN1OutputStream(decodetd,wrapped)
    // Boolean 对象传入 Enumerated 序列化器应抛异常
    var caught1: Bool = false
    try {
        enu.serializedLength(ssc)
    } catch (e: Exception) {
        caught1 = true
    }
    @Assert(caught1, true)

    var caught2: Bool = false
    try {
        enu.serialize(ssc,asn)
    } catch (e: Exception) {
        caught2 = true
    }
    @Assert(caught2, true)

    let ssc3 = ASN1Integer(6)
    let ssc4 = ssc3.valueHash()
    let srv = IntegerSerializer(decodetd)
    // Boolean 对象传入 Integer 序列化器应抛异常
    var caught3: Bool = false
    try {
        srv.serializedLength(ssc)
    } catch (e: Exception) {
        caught3 = true
    }
    @Assert(caught3, true)

    var caught4: Bool = false
    try {
        srv.serialize(ssc,asn)
    } catch (e: Exception) {
        caught4 = true
    }
    @Assert(caught4, true)

    let srt = ASN1Null()
    srt.valueHash()
    let srt1 = NullSerializer(decodetd)
    srt1.serializedLength(ssc)
    srt1.serialize(ssc,asn)

    @Assert(ssc4, 6)
    return 0
}
