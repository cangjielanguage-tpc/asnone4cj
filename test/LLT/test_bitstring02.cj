// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import asn1.*
import std.io.*

main() {

    let decodetd: DEREncoder = DEREncoder()


    let wrapped: ByteArrayStream = ByteArrayStream()
    ASN1OutputStream(decodetd,wrapped)

    BitStringSerializer(decodetd)

    let bytesBuf: Array<Byte> = Array<Byte>(10, item: 0)
    ASN1BitString(bytesBuf,6)

    if (bytesBuf.size != 0) {
        return 0
    }
    return 1
}
