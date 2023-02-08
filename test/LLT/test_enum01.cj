// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from cryptocj import bignumcj.BIGNUM
from asn1 import asn1.ASN1Enumerated
from asn1 import asn1.EnumeratedParser
from asn1 import asn1.BERDecoder
from asn1 import asn1.ASN1Tag

from std import io.*

main() {
    let bytesBuf: Array<Byte> = Array<Byte>(10, item: 0)
    let sc = ASN1Enumerated(65)
    var p: CPointer<BIGNUM> = CPointer<BIGNUM>()
    let sc1 = ASN1Enumerated(p)
    let sc2 = ASN1Enumerated(p,bytesBuf)
    sc.getValue()
    let decodetd: BERDecoder = BERDecoder()
    let src =EnumeratedParser(decodetd)
    let src1 = src.parse(ASN1Tag.ENUMERATED,bytesBuf)
    println(src1.toString())
    if (src1.toString() != "ASN1Object[ASN1Tag[UNIVERSAL,PRIMITIVE,10]]") {
        return 1
    }
    return 0
}
