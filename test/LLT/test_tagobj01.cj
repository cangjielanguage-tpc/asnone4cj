// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import std.collection.*
import asn1.*
import std.unittest.*
import std.unittest.testmacro.*

main(): Int64 {
    var tag = BIT_STRING
    let dec: BERDecoder = BERDecoder()
    DERDecoder()
    DEREncoder()
    let bitss = BooleanParser(dec)
    let Buf: Array<Byte> = [1]
    let ssc = bitss.parse(tag,Buf)
    let ssc1: ?ASN1Object = ssc
    let asn1 = ASN1TaggedObject(tag, ssc1)

    asn1.getValue()
    // PRIMITIVE 编码的 TaggedObject 调 iterator/getObject 应抛异常
    var caught1: Bool = false
    try {
        asn1.iterator()
    } catch (e: Exception) {
        caught1 = true
    }
    @Assert(caught1, true)

    var caught2: Bool = false
    try {
        asn1.getObject(tag)
    } catch (e: Exception) {
        caught2 = true
    }
    @Assert(caught2, true)

    asn1.getObject()

    let src = asn1.isExplicit()
    let src1 = asn1.getTagNo()
    let src2 = asn1.toString()

    let srce = ASN1Encoding.PRIMITIVE(0x0)
    let srce2 = ASN1Encoding.CONSTRUCTED(0x20)
    @Assert(srce != srce2, true)

    @Assert(src, true)
    @Assert(src1, 3)
    @Assert(src2, "ASN1TaggedObject[ASN1Tag[UNIVERSAL,CONSTRUCTED,3],ASN1Object[ASN1Tag[UNIVERSAL,PRIMITIVE,1]]]")

    // 空 bytes 也应交给解析器处理（对齐上游语义），不再直接抛异常
    let taggedEmpty: ASN1TaggedObject = ASN1TaggedObject(OCTET_STRING, Array<Byte>(), BERDecoder())
    let gotEmpty: ASN1Object = taggedEmpty.getObject(OCTET_STRING)
    @Assert(gotEmpty is ASN1OctetString, true)
    return 0
}
