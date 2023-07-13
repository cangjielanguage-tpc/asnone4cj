// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from asn1 import asn1.EnumeratedSerializer
from asn1 import asn1.BERDecoder
from asn1 import asn1.ASN1OutputStream
from asn1 import asn1.ASN1Tag
from asn1 import asn1.ASN1ObjectIdentifier
from asn1 import asn1.ASN1BitString
from asn1 import asn1.ASN1PrimitiveValue
from asn1 import asn1.encodingrules.der.DEREncoder
from asn1 import asn1.*
from std import io.*

main() {
    BERDecoder()
    let decs: DEREncoder = DEREncoder()

    let wrapped: ByteArrayStream = ByteArrayStream()
    let asn = ASN1OutputStream(decs,wrapped)
    let arr =Array<Bool>(1004, item: true)
    let str = ASN1BitString(arr)
    asn.writeObject(str)
    println(0x7f)

    let buf = Array<Byte>(10, item: 1)
    let strc: ASN1PrimitiveValue = ASN1ObjectIdentifier("3.4.5",buf)
    
    let result = strc.valueHash()
    println(result)
    if(result != 196345501) {
        return 1
    }
    return 0
}
