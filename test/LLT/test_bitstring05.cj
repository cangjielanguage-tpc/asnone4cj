// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import std.io.*
import asn1.*

main() {

    let dec: DEREncoder = DEREncoder()

    let tags = INTEGER
    let decz: BERDecoder = BERDecoder()
    let bitss = BooleanParser(decz)
    let Buf: Array<Byte> = [1]
    let ssc = bitss.parse(tags,Buf)
    let ssc2 = bitss.parse(tags,Buf)
    ssc.equals(ssc2)
    let ssc1 = ssc.hashCode()

    let src = ASN1ObjectIdentifier("a")
    src.valueHash()
    let src1 = ObjectIdentifierParser(decz)
    try {
        let arr: Array<Byte> = [1,2,3,5,6]
        src1.parse(tags, arr)
    }catch(e : Exception){
        println("pass")
    }
    let src2 = ObjectIdentifierSerializer(dec)
    try {
        src2.serializedLength(ssc)
    }catch(e : Exception){
        println("pass")
    }
    
    let decodetd: DEREncoder = DEREncoder()
    let wrapped: ByteBuffer = ByteBuffer()
    let asn9 = ASN1OutputStream(decodetd,wrapped)
    try {
        src2.serialize(ssc,asn9)
    }catch(e : Exception){
        println("pass7")
    }
    let oc = ASN1OctetString(Array<Byte>())
    oc.getValue()
    if (ssc1 != 1) {
        return 1
    }
    return 0
}
