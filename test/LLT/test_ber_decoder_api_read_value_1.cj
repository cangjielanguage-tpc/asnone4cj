// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import std.io.*
import std.collection.*
import asn1.*
import std.unittest.*
import std.unittest.testmacro.*

main(): Int64 {
    var buffer: Array<Byte> = [0x00, 0x02, 0x04, 0x06, 0x10, 0x01, 0x03, 0x05, 0x07, 0x11]
    var berDecoder: BERDecoder = BERDecoder()
    var inputStream: ASN1InputStream = ASN1InputStream(berDecoder, buffer)
    var buffer_1: Array<Byte> = berDecoder.readValue(0, inputStream)
    @Assert(buffer_1.size, 0)

    var buffer0: Array<Byte> = berDecoder.readValue(5, inputStream)
    @Assert(buffer0.size, 5)
    @Assert(buffer0[0], 0x00)
    @Assert(buffer0[1], 0x02)
    @Assert(buffer0[2], 0x04)
    @Assert(buffer0[3], 0x06)
    @Assert(buffer0[4], 0x10)

    // 流已耗尽，继续读取应抛出异常，而不是静默返回补零数据
    var caught1: Bool = false
    try {
        berDecoder.readValue(10, inputStream)
    } catch (e: ASN1ParseException) {
        caught1 = true
    }
    @Assert(caught1, true)

    var caught2: Bool = false
    try {
        berDecoder.readValue(30, inputStream)
    } catch (e: ASN1ParseException) {
        caught2 = true
    }
    @Assert(caught2, true)

    var caught3: Bool = false
    try {
        berDecoder.readValue(50, inputStream)
    } catch (e: ASN1ParseException) {
        caught3 = true
    }
    @Assert(caught3, true)
    return 0
}
