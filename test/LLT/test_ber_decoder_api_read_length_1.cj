// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import std.io.*
import std.collection.*
import asn1.*
import std.unittest.*
import std.unittest.testmacro.*

main(): Int64 {
    var array: Array<Byte> = [0x00, 0x02, 0x04, 0x06, 0x10, 0x01, 0x03, 0x05, 0x07, 0x11]
    var berDecoder: BERDecoder = BERDecoder()
    var inputStream: ASN1InputStream = ASN1InputStream(berDecoder, array)
    var buffer: Int64 = berDecoder.readLength(inputStream)
    @Assert(buffer, 0)

    var array_0: Array<Byte> = [0x7f, 0x02, 0x04, 0x06, 0x10, 0x01, 0x03, 0x05, 0x07, 0x11]
    var inputStream_0: ASN1InputStream = ASN1InputStream(berDecoder, array_0)
    var buffer_0: Int64 = berDecoder.readLength(inputStream_0)
    @Assert(buffer_0, 127)

    var array1: Array<Byte> = [0x66, 0x02, 0x04, 0x06, 0x10, 0x01, 0x03, 0x05, 0x07, 0x11]
    var inputStream1: ASN1InputStream = ASN1InputStream(berDecoder, array1)
    var buffer1: Int64 = berDecoder.readLength(inputStream1)
    @Assert(buffer1, 102)

    var array2: Array<Byte> = [0x81, 0x02, 0x04, 0x06, 0x10, 0x01, 0x03, 0x05, 0x07, 0x7f]
    var inputStream2: ASN1InputStream = ASN1InputStream(berDecoder, array2)
    var buffer2: Int64 = berDecoder.readLength(inputStream2)
    @Assert(buffer2, 2)

    // 长度首字节 0xFF 为规范保留值，应拒绝
    var array3: Array<Byte> = [0xFF, 0x02, 0x04, 0x06]
    var inputStream3: ASN1InputStream = ASN1InputStream(berDecoder, array3)
    var caught: Bool = false
    try {
        berDecoder.readLength(inputStream3)
    } catch (e: ASN1ParseException) {
        caught = true
        @Assert(e.message.contains("0xFF"), true)
    }
    @Assert(caught, true)
    return 0
}
