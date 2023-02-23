// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from asn1 import asn1.ASN1BitString
from asn1 import asn1.BERDecoder
from asn1 import asn1.BitStringParser
from asn1 import asn1.ASN1Tag
from asn1 import asn1.*
from std import io.*

main() {
    let bytesBuf: Array<Byte> = Array<Byte>(10, item: 0)
    let asn = ASN1BitString(bytesBuf,6)
    let arr: Array<Bool> = Array<Bool>(5, item: true)
    let asn1 = ASN1BitString(arr)
    asn.getValue()
    let indd =asn.isSet(2)
    let src =asn.length()

    let tags = INTEGER
    let dec: BERDecoder = BERDecoder()
    let bitss = BitStringParser(dec)
    bitss.parse(tags,bytesBuf)

    if (indd != false) {
        return 1
    }
    if (src != 74) {
        return 2
    }
    return 0
}
