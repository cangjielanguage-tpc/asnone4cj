// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import asn1.*
import std.io.*

main() {
    let decodetd: DEREncoder = DEREncoder()
    let wrapped: ByteBuffer = ByteBuffer()
    let asn = ASN1OutputStream(decodetd,wrapped)
    let bytesBuf: Array<Byte> = Array<Byte>(10, repeat: 0)
   
    asn.write(bytesBuf)
    asn.write(6)
    asn.write(6)
    let tags = INTEGER
    let dec: BERDecoder = BERDecoder()
    let bitss = BooleanParser(dec)
    let Buf: Array<Byte> = [1]
    let ssc = bitss.parse(tags,Buf)
    try {
        asn.writeObject(ssc)
    } catch (_: Exception) {
    }
    return 0
}
