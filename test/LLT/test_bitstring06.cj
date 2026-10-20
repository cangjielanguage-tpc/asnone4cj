// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import std.io.*
import asn1.*
import std.collection.*
import std.unittest.*
import std.unittest.testmacro.*

main(): Int64 {
    let dec: DEREncoder = DEREncoder()
    let tags = INTEGER
    let decz: BERDecoder = BERDecoder()

    let oc = OctetStringParser(decz)
    oc.parse(tags, Array<Byte>())
    let oc1 = OctetStringSerializer(dec)

    let bitss = BooleanParser(decz)
    let Buf: Array<Byte> = [1]
    let ssc = bitss.parse(tags,Buf)
    // Boolean 对象传入 OctetString 序列化器应抛异常
    var caught1: Bool = false
    try {
        oc1.serializedLength(ssc)
    } catch (e: Exception) {
        caught1 = true
    }
    @Assert(caught1, true)

    let decodetd: DEREncoder = DEREncoder()
    let wrapped: ByteBuffer = ByteBuffer()
    let asn9 = ASN1OutputStream(decodetd,wrapped)

    var caught2: Bool = false
    try {
        oc1.serialize(ssc,asn9)
    } catch (e: Exception) {
        caught2 = true
    }
    @Assert(caught2, true)

    let ssq: Array<ToString> = Array<ToString>(100, repeat: unsafe {zeroValue<ToString>()})
    ASN1ParseException(Exception(), "asdda", ssq)

    let srp: ASN1PrimitiveValue = ASN1Enumerated(6)
    srp.valueHash()
    let objs = ArrayList<ASN1Object>()
    objs.add(ssc)
    let buu: Array<Byte> = [1,6]
    ASN1Sequence(objs,buu)
    return 0
}
