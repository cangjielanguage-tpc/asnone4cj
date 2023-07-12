// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from asn1 import asn1.ASN1Boolean
from asn1 import asn1.BERDecoder
from asn1 import asn1.BooleanParser
from std import io.*

main() {
    let bytesBuf: Array<Byte> = Array<Byte>(10, item: 0)
    let sc = ASN1Boolean(true)
    ASN1Boolean(true,bytesBuf)
    let fs = sc.getValue()
    var asn1test: Bool = (fs as Bool).getOrThrow()
    println(asn1test)
    let dec: BERDecoder = BERDecoder()
    BooleanParser(dec)
    //sc2.parse(sc,bytesBuf)
    if(asn1test) {
        return 0
    }
    return 1
}
