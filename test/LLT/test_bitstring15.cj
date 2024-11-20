// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import std.io.*
import asn1.*
import std.collection.*

main() {
    let dec: BERDecoder = BERDecoder()
    let wrapped: ByteArrayStream = ByteArrayStream()
    var buf = Array<Byte>(10, item: 63)
    wrapped.write(buf)

    let tag = SET
    let str = ASN1TaggedObject(tag,ASN1Boolean(true))
    let decs: DEREncoder = DEREncoder()
    let arr = HashSet<ASN1Encoding>([ASN1Encoding.PRIMITIVE(0x0), ASN1Encoding.CONSTRUCTED(0x20)])
    let tagss = ASN1TaggedObjectTag(ASN1TagClass.UNIVERSAL(0),0x0A,arr)
    let sc  = tagss.newSerializer(decs)
    let result = sc.serializedLength(str)
    println(result)
    try {
        dec.readTag(wrapped)
    }catch(e: Exception) {
        return 0
    }
    return 1  
}
