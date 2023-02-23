// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from numeric import bigint.*
from asn1 import asn1.ASN1Integer
from asn1 import asn1.IntegerParser
from asn1 import asn1.BERDecoder
from asn1 import asn1.ASN1Tag

from std import io.*

main() {
    let bytesBuf: Array<Byte> = Array<Byte>(10, item: 0)
    let sc = ASN1Integer(65)
    var p: BigInt = BigInt(1)
    var d: BigInt = BigInt(2)
    let sc1 = ASN1Integer(d)
    let sc2 = ASN1Integer(d,bytesBuf)
    sc1.getValue()

    let decodetd: BERDecoder = BERDecoder()
    let src =IntegerParser(decodetd)
    let src1 = src.parse(ASN1Tag.INTEGER,bytesBuf)
    println(src1.toString())
    if (src1.toString() != "ASN1Object[ASN1Tag[UNIVERSAL,PRIMITIVE,2]]") {
        return 1
    }
    return 0
}
