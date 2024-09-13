// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import asn1.*
import std.io.*

main() {
    let decodetd: BERDecoder = BERDecoder()
    let wrapped: ByteArrayStream = ByteArrayStream()
    let asn = ASN1InputStream(decodetd,wrapped)
    let bytesBuf: Array<Byte> = Array<Byte>(10, repeat: 0)
    let asn1 = ASN1InputStream(decodetd,bytesBuf)
    let src = asn.readValue(1)
    let src1 = asn.iterator()
    src1.iterator()
    try {
        asn1.readObject()
    } catch (e: Exception) {
        println("case pass")
    }
    try {
        src1.next()
    } catch (e: Exception) {
        println("case pass")
    }
    try {
        asn.readTag()
    } catch (e: Exception) {
        println("case pass")
    }
    
    let src3 = asn.readLength()
    var data: Array<Byte> = Array<Byte>()
    asn.read(data)
    if (src.size != 1) {
        return 1
    }
    if (src3 != 0) {
        return 2
    }
    return 0
}
