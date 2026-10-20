// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import asn1.*
import std.io.*
import std.unittest.*
import std.unittest.testmacro.*

main(): Int64 {
    let decodetd: BERDecoder = BERDecoder()
    let wrapped: ByteBuffer = ByteBuffer()
    let asn = ASN1InputStream(decodetd,wrapped)
    let bytesBuf: Array<Byte> = Array<Byte>(10, repeat: 0)
    let asn1 = ASN1InputStream(decodetd,bytesBuf)
    let src1 = asn.iterator()
    src1.iterator()
    // 空流上各读取操作均应抛异常
    var caught1: Bool = false
    try {
        asn1.readObject()
    } catch (e: Exception) {
        caught1 = true
    }
    @Assert(caught1, true)

    // 空流上 iterator.next() 返回 None，不抛异常
    src1.next()

    var caught3: Bool = false
    try {
        asn.readTag()
    } catch (e: Exception) {
        caught3 = true
    }
    @Assert(caught3, true)

    var caught4: Bool = false
    try {
        asn.readValue(1)
    } catch (e: Exception) {
        caught4 = true
    }
    @Assert(caught4, true)

    var caught5: Bool = false
    try {
        asn.readLength()
    } catch (e: Exception) {
        caught5 = true
    }
    @Assert(caught5, true)

    var data: Array<Byte> = Array<Byte>()
    asn.read(data)
    return 0
}
