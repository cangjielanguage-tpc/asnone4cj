// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from asn1 import asn1.ASN1BitString
from asn1 import asn1.ASN1Tag
from asn1 import asn1.BitStringParser
from asn1 import asn1.BitStringSerializer
from asn1 import asn1.BERDecoder
from asn1 import asn1.ASN1Boolean
from asn1 import asn1.encodingrules.der.DEREncoder
from asn1 import asn1.*
from std import io.*

main() {

    let arr: Array<Bool> = Array<Bool>(5, item: true)
    let asn1 = ASN1BitString(arr)
    let str = asn1.valueString()
    let asse = DEREncoder()
    let str1 = BitStringSerializer(asse)
    
    let tag = BIT_STRING
    let dec: BERDecoder = BERDecoder()
    let buf:  Array<Byte> = [1,1]
    let bitss = BitStringParser(dec)
    bitss.parse(tag,buf)

    let bols = ASN1Boolean(true)
    let bols1 = ASN1Boolean(false)
    bols.valueHash()
    bols1.valueHash()
    if (str.size != 30) {
        return 1
    }
    return 0
}


