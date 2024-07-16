// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import asn1.*
import std.io.*

main() {
    let Buf: Array<Byte> = [1]
    let dec: ASN1ObjectIdentifier = ASN1ObjectIdentifier("ascsc")
    ASN1ObjectIdentifier("ascsc",Buf)
    let src = dec.getValue()
    let src1 = (src as String).getOrThrow()
    println(src1)
    if (src1 != "ascsc") {
        return 1
    }
    return 0
}
