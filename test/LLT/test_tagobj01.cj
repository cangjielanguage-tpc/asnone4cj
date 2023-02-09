// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from asn1 import asn1.BERDecoder
from asn1 import asn1.types.ASN1Encoding
from asn1 import asn1.ASN1Object
from asn1 import asn1.BooleanParser
from asn1 import asn1.ASN1Tag
from asn1 import asn1.ASN1TaggedObject
from asn1 import asn1.encodingrules.der.*
from std import collection.*

main() {
    var tag = ASN1Tag.BIT_STRING
    var bud: Array<Byte> = [1]
    let dec: BERDecoder = BERDecoder()
    let dec6: DERDecoder = DERDecoder()
    let dec7: DEREncoder = DEREncoder()
    let bitss = BooleanParser(dec)
    let Buf: Array<Byte> = [1]
    let ssc = bitss.parse(tag,Buf)
    let ssc1: ?ASN1Object = ssc
    let asn1 = ASN1TaggedObject(tag, ssc1)

    asn1.getValue()
    try {
        let ssc9 = asn1.iterator()
    } catch (e : Exception){
        println("pass")
    }
    try {
        let ssc8 = asn1.getObject(tag)
    } catch (e : Exception){
        println("pass")
    }
    asn1.getObject()
    
    let src = asn1.isExplicit()
    let src1 = asn1.getTagNo()
    let src2 = asn1.toString()

    let srce = ASN1Encoding.PRIMITIVE(0x0)
    let srce2 = ASN1Encoding.CONSTRUCTED(0x20)
    if (srce != srce2) {
        return 0
    }

    if (!src) {
        return 1
    }
    if (src1 != 3) {
        return 2
    }
    if (src2 != "ASN1TaggedObject[ASN1Tag[UNIVERSAL,CONSTRUCTED,3],ASN1Object[ASN1Tag[UNIVERSAL,PRIMITIVE,1]]]") {
        return 3
    }
    if (srce != srce2) {
        return 0
    }
    return 4
}
