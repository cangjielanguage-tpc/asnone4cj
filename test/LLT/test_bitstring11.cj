// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from asn1 import asn1.EnumeratedSerializer
from asn1 import asn1.BERDecoder
from asn1 import asn1.ASN1Enumerated
from asn1 import asn1.ASN1Tag
from asn1 import asn1.ASN1OutputStream
from asn1 import asn1.encodingrules.der.DEREncoder   
from std import io.*

main() {
    Array<Byte>(10, item: 0)
    let str = ASN1Enumerated(8)
    let sss6 = str.equals(str)
    println(sss6)
    let dec: DEREncoder = DEREncoder()

    let sc = EnumeratedSerializer(dec)
    let sc1 = sc.serializedLength(str)
    let wrapped: ByteArrayStream = ByteArrayStream()
    let asn = ASN1OutputStream(dec,wrapped)
    sc.serialize(str,asn)
    println(sc1)
    if (sc1 != 1) {
        return 1
    }
    return 0
}
