// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import asn1.*
import std.io.*
import std.collection.*
import std.unittest.*
import std.unittest.testmacro.*

main(): Int64 {
    let dec: BERDecoder = BERDecoder()
    let wrapped: ByteBuffer = ByteBuffer()
    var buf = Array<Byte>(10, repeat: 63)
    wrapped.write(buf)

    let tag = SET
    let str = ASN1TaggedObject(tag,ASN1Boolean(true))
    let decs: DEREncoder = DEREncoder()
    let arr = HashSet<ASN1Encoding>([ASN1Encoding.PRIMITIVE(0x0), ASN1Encoding.CONSTRUCTED(0x20)])
    let tagss = ASN1TaggedObjectTag(ASN1TagClass.UNIVERSAL(0),0x0A,arr)
    let sc = tagss.newSerializer(decs)
    let result = sc.serializedLength(str)
    println(result)

    // 空流上 readTag 应抛异常
    var caught: Bool = false
    try {
        dec.readTag(wrapped)
    } catch (e: Exception) {
        caught = true
    }
    @Assert(caught, true)
    return 0
}
