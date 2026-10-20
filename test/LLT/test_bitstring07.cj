// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import std.io.*
import asn1.*
import std.collection.*
import std.unittest.*
import std.unittest.testmacro.*

main(): Int64 {
    let dec: DEREncoder = DEREncoder()
    let decz: BERDecoder = BERDecoder()
    let tags = ASN1_BOOLEAN

    let bitss = BooleanParser(decz)
    let Buf: Array<Byte> = [1]
    let ssc = bitss.parse(tags,Buf)

    let decodetd: DEREncoder = DEREncoder()
    let wrapped: ByteBuffer = ByteBuffer()
    let asn9 = ASN1OutputStream(decodetd,wrapped)

    let sp1 = BitStringSerializer(dec)
    // Boolean 对象传入 BitString 序列化器应抛异常
    var caught1: Bool = false
    try {
        sp1.serializedLength(ssc)
    } catch (e: Exception) {
        caught1 = true
    }
    @Assert(caught1, true)

    var caught2: Bool = false
    try {
        sp1.serialize(ssc,asn9)
    } catch (e: Exception) {
        caught2 = true
    }
    @Assert(caught2, true)

    let sle = ASN1TaggedObject(tags,Array<Byte>(),decz)
    var caught3: Bool = false
    try {
        sle.iterator()
    } catch (e: Exception) {
        caught3 = true
    }
    @Assert(caught3, true)

    let tagg1 = ASN1TaggedObjectTag(ASN1TagClass.UNIVERSAL(0),0x03,HashSet<ASN1Encoding>([ASN1Encoding.PRIMITIVE(0x0), ASN1Encoding.CONSTRUCTED(0x20)]))

    let op1 = tagg1.newParser(decz)
    op1.parse(tags,Array<Byte>())
    let op2 = tagg1.newSerializer(dec)
    // Boolean 对象传入 TaggedObject 序列化器应抛异常
    var caught4: Bool = false
    try {
        op2.serializedLength(ssc)
    } catch (e: Exception) {
        caught4 = true
    }
    @Assert(caught4, true)

    var caught5: Bool = false
    try {
        op2.serialize(ssc,asn9)
    } catch (e: Exception) {
        caught5 = true
    }
    @Assert(caught5, true)
    return 0
}
