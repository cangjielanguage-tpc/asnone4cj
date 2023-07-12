// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from asn1 import asn1.util.BigInt
from asn1 import asn1.ASN1Enumerated
from asn1 import asn1.EnumeratedParser
from asn1 import asn1.BERDecoder
from asn1 import asn1.ASN1Tag
from asn1 import asn1.*
from std import io.*

main() {
    let bytesBuf: Array<Byte> = Array<Byte>(10, item: 0)
    let sc = ASN1Enumerated(65)
    var p: BigInt = BigInt(1)
    ASN1Enumerated(p)
    ASN1Enumerated(p,bytesBuf)
    sc.getValue()
    let decodetd: BERDecoder = BERDecoder()
    let src =EnumeratedParser(decodetd)
    let src1 = src.parse(ENUMERATED,bytesBuf)
    println(src1.toString())
    if (src1.toString() != "ASN1Object[ASN1Tag[UNIVERSAL,PRIMITIVE,10]]") {
        return 1
    }
    return 0
}
