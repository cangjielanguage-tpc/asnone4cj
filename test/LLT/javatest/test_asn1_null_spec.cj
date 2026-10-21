// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import asn1.*
import std.io.*
import std.unittest.*
import std.unittest.testmacro.*

// 数组第一位0x05代表ASN1Null类型
// 数组第二位0x00代表数组长度为0
main(): Int64 {
    var value: Array<Byte> = [0x05, 0x00]
    var byteArrayStream: ByteBuffer = ByteBuffer()
    byteArrayStream.write(value)
    var asn1InputStream: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream)
    var asn1Object: ASN1Object = asn1InputStream.readObject()
    @Assert(asn1Object is ASN1Null, true)
    var object: ASN1Null = (asn1Object as ASN1Null).getOrThrow()
    object.getValue()
    @Assert(object.valueHash(), 0)

    var value1: Array<Byte> = [0x05, 0x00]
    var byteArrayStream1: ByteBuffer = ByteBuffer()
    var asn1OutputStream1: ASN1OutputStream = ASN1OutputStream(DEREncoder(), byteArrayStream1)
    asn1OutputStream1.writeObject(ASN1Null())
    @Assert(byteArrayStream1.bytes(), value1)
    return 0
}
