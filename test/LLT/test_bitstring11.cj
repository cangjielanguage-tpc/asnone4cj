// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import asn1.*
import std.io.*

main() {
    let str = ASN1Enumerated(8)
    let sss6 = str.equals(str)
    println(sss6)
    let dec: DEREncoder = DEREncoder()

    let sc = EnumeratedSerializer(dec)
    let sc1 = sc.serializedLength(str)
    let wrapped: ByteBuffer = ByteBuffer()
    let asn = ASN1OutputStream(dec,wrapped)
    sc.serialize(str,asn)
    println(sc1)
    if (sc1 != 1) {
        return 1
    }
    return 0
}
