// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from asn1 import asn1.ASN1Null
from asn1 import asn1.NullParser
from asn1 import asn1.BERDecoder
from asn1 import asn1.ASN1Tag
from asn1 import asn1.*
from std import io.*

main() {
    let bytesBuf: Array<Byte> = Array<Byte>()
    let sc = ASN1Null()
    sc.getValue()
    let deco: BERDecoder = BERDecoder()
    let src = NullParser(deco)
    let src2 = src.parse(ASN1_NULL_TAG,bytesBuf)
    println(src2.toString())
    if (src2.toString() != "ASN1Object[ASN1Tag[UNIVERSAL,PRIMITIVE,5]]") {
        return 1
    }
    return 0
}
