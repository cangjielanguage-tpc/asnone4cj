// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import asn1.*
import std.io.*

main() {
    BERDecoder()
    let decs: DEREncoder = DEREncoder()

    let wrapped: ByteArrayStream = ByteArrayStream()
    let asn = ASN1OutputStream(decs,wrapped)
    let arr =Array<Bool>(1004, repeat: true)
    let str = ASN1BitString(arr)
    asn.writeObject(str)
    println(0x7f)

    let buf = Array<Byte>(10, repeat: 1)
    let strc: ASN1PrimitiveValue = ASN1ObjectIdentifier("3.4.5",buf)
    
    let result = strc.valueHash()
    println(result)
    if(result != 6445174239661554901) {
        return 1
    }
    return 0
}
