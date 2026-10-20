// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import asn1.*
import std.io.*
import std.collection.*
import std.unittest.*
import std.unittest.testmacro.*

main(): Int64 {
    let dec: DEREncoder = DEREncoder()
    let tags = INTEGER
    let decz: BERDecoder = BERDecoder()

    let bitss = BooleanParser(decz)
    let Buf: Array<Byte> = [1]
    let ssc = bitss.parse(tags,Buf)

    let decodetd: DEREncoder = DEREncoder()
    let wrapped: ByteBuffer = ByteBuffer()
    let asn9 = ASN1OutputStream(decodetd,wrapped)

    let tags1 = SEQUENCE
    let src = tags1.newParser(decz)
    let src1 = tags1.newSerializer(dec)
    // 空数组 parse 不抛异常，仅冒烟
    src.parse(tags, Array<Byte>())
    // Boolean 对象传入 Sequence 序列化器应抛异常
    var caught2: Bool = false
    try {
        src1.serializedLength(ssc)
    } catch (e: Exception) {
        caught2 = true
    }
    @Assert(caught2, true)

    var caught3: Bool = false
    try {
        src1.serialize(ssc,asn9)
    } catch (e: Exception) {
        caught3 = true
    }
    @Assert(caught3, true)

    let resu = tags1.getTag()
    println(resu)

    let tags2 = SET
    let rel = tags2.newParser(decz)
    let rel1 = tags2.newSerializer(dec)
    // 空数组 parse 不抛异常，仅冒烟
    rel.parse(tags, Array<Byte>())
    // Boolean 对象传入 Set 序列化器应抛异常
    var caught5: Bool = false
    try {
        rel1.serializedLength(ssc)
    } catch (e: Exception) {
        caught5 = true
    }
    @Assert(caught5, true)

    var caught6: Bool = false
    try {
        rel1.serialize(ssc,asn9)
    } catch (e: Exception) {
        caught6 = true
    }
    @Assert(caught6, true)

    @Assert(resu, 16)
    return 0
}
