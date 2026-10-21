// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import asn1.*
import std.io.*
import std.unittest.*
import std.unittest.testmacro.*

main(): Int64 {
    var value: Array<Byte> = [0x01, 0x01, 0x0]
    var byteArrayStream: ByteBuffer = ByteBuffer()
    byteArrayStream.write(value)
    var asn1InputStream: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream)
    let aSN1ObjectIterator: Iterator<ASN1Object> = asn1InputStream.iterator()
    var aSN1Object: ?ASN1Object = aSN1ObjectIterator.next()
    while (aSN1Object.isSome()) {
        aSN1Object = aSN1ObjectIterator.next()
    }
    @Assert(None, aSN1Object)
    return 0
}
