// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import std.io.*
import asn1.*
import std.collection.*
import std.unittest.*
import std.unittest.testmacro.*

main(): Int64 {
    BERDecoder()
    let tag = SEQUENCE
    let decs: DEREncoder = DEREncoder()

    let str = tag.newSerializer(decs)
    let arr: ArrayList<ASN1Object> = ArrayList<ASN1Object>()
    arr.add(ASN1Boolean(true))
    arr.add(ASN1Boolean(false))
    let sc = ASN1Sequence(arr)
    let resu = str.serializedLength(sc)
    let wrapped: ByteBuffer = ByteBuffer()
    let asn = ASN1OutputStream(decs,wrapped)
    str.serialize(sc,asn)

    let tags = SET
    let str1 = tags.newSerializer(decs)
    let buf = HashSet<ASN1Object>()
    buf.add(ASN1Boolean(false))
    buf.add(ASN1Boolean(true))
    buf.add(ASN1Boolean(true))

    let sc1 = ASN1Set(buf)
    let resu1 = str1.serializedLength(sc1)
    str1.serialize(sc1,asn)

    // equals 修复后 SET 按值去重：{false, true, true} 实际只含 2 个元素，编码长度 6
    @Assert(resu, 6)
    @Assert(resu1, 6)
    return 0
}
