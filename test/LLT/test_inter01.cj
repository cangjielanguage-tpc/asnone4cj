// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from asn1 import asn1.*
from std import io.*
from std import math.numeric.*

main() {
    let bytesBuf: Array<Byte> = Array<Byte>(10, item: 0)
    ASN1Integer(65)
    BigInt(1)
    var d: BigInt = BigInt(2)
    let sc1 = ASN1Integer(d)
    ASN1Integer(d,bytesBuf)
    sc1.getValue()

    let decodetd: BERDecoder = BERDecoder()
    let src =IntegerParser(decodetd)
    let src1 = src.parse(INTEGER,bytesBuf)
    println(src1.toString())
    if (src1.toString() != "ASN1Object[ASN1Tag[UNIVERSAL,PRIMITIVE,2]]") {
        return 1
    }
    return 0
}
