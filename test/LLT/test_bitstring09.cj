// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import asn1.*
import std.io.* 
import std.collection.*

main() {

    let dec: DEREncoder = DEREncoder()
    let decz: BERDecoder = BERDecoder()
    let tags = ASN1_BOOLEAN

    let bitss = BooleanParser(decz)
    let Buf: Array<Byte> = [1]
    let ssc = bitss.parse(tags,Buf)

    let decodetd: DEREncoder = DEREncoder()
    let wrapped: ByteArrayStream = ByteArrayStream()
    let asn9 = ASN1OutputStream(decodetd,wrapped)
    let sp1 = BitStringSerializer(dec)
    try {
        sp1.serializedLength(ssc)
    }catch(e: Exception) {
        println("pass")
    }
    try {
        sp1.serialize(ssc,asn9)
    }catch(e: Exception) {
        println("pass")
    }

    let sle = ASN1TaggedObject(tags,Array<Byte>(),decz)
    
    try {
        sle.iterator()
    }catch(e: Exception) {
        println("pass")
    }

    let tagg1 = ASN1TaggedObjectTag(ASN1TagClass.UNIVERSAL(0),0x03,HashSet<ASN1Encoding>([ASN1Encoding.PRIMITIVE(0x0), ASN1Encoding.CONSTRUCTED(0x20)]))
    
    let op1 =tagg1.newParser(decz)
    op1.parse(tags,Array<Byte>())
    let op2 =tagg1.newSerializer(dec)
    try {
        op2.serializedLength(ssc)
    }catch(e: Exception) {
        println("pass")
    }
     try {
        op2.serialize(ssc,asn9)
    }catch(e: Exception) {
        println("pass11")
    }
    return 0
}
