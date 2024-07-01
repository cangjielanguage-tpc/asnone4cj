// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from std import io.*
from asn1 import asn1.*

main() {
    [127, 127, 127]
    let str = ASN1ObjectIdentifier("2.3.1")
    BERDecoder()
    let decs: DEREncoder = DEREncoder()
    let sc = ObjectIdentifierSerializer(decs)

    let sq = sc.serializedLength(str)

    let wrapped: ByteArrayStream = ByteArrayStream()
    let asn = ASN1OutputStream(decs, wrapped)
    sc.serialize(str, asn)

    let wrapped1: ByteArrayStream = ByteArrayStream()
    let asn1 = ASN1OutputStream(decs, wrapped1)
    asn1.write(6)
    sc.serialize(str, asn1)
    println(sq)
    if (sq != 2) {
        return 1
    }
    return 0
}
