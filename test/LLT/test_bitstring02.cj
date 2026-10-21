// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import asn1.*
import std.io.*
import std.unittest.*
import std.unittest.testmacro.*

main(): Int64 {
    let decodetd: DEREncoder = DEREncoder()
    let wrapped: ByteBuffer = ByteBuffer()
    ASN1OutputStream(decodetd,wrapped)

    BitStringSerializer(decodetd)

    let bytesBuf: Array<Byte> = Array<Byte>(10, repeat: 0)
    ASN1BitString(bytesBuf,6)

    @Assert(bytesBuf.size != 0, true)
    return 0
}
