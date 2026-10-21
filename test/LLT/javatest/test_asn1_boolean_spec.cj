// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import asn1.*
import std.io.*
import std.unittest.*
import std.unittest.testmacro.*

// 数组第一位0x01代表ASN1Boolean类型
// 数组第二位0x01代表数组长度为1
// 数组第三位0x0代表false,0x01代表true,默认值是true
main(): Int64 {
    // false
    var value: Array<Byte> = [0x01, 0x01, 0x0]
    var byteArrayStream: ByteBuffer = ByteBuffer()
    byteArrayStream.write(value)
    var asn1InputStream: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream)
    var asn1Object: ASN1Object = asn1InputStream.readObject()
    @Assert(asn1Object is ASN1Boolean, true)
    var object: ASN1Boolean = (asn1Object as ASN1Boolean).getOrThrow()
    var anyValue: Any = object.getValue()
    var boolValue: Bool = (anyValue as Bool).getOrThrow()
    @Assert(boolValue, false)
    @Assert(object.valueHash(), 1237)

    // true
    var value1: Array<Byte> = [0x01, 0x01, 0x01]
    var byteArrayStream1: ByteBuffer = ByteBuffer()
    byteArrayStream1.write(value1)
    var asn1InputStream1: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream1)
    var asn1Object1: ASN1Object = asn1InputStream1.readObject()
    @Assert(asn1Object1 is ASN1Boolean, true)
    var object1: ASN1Boolean = (asn1Object1 as ASN1Boolean).getOrThrow()
    var anyValue1: Any = object1.getValue()
    var boolValue1: Bool = (anyValue1 as Bool).getOrThrow()
    @Assert(boolValue1, true)
    @Assert(object1.valueHash(), 1231)

    // true
    var value2: Array<Byte> = [0x01, 0x01, 0xFF]
    var byteArrayStream2: ByteBuffer = ByteBuffer()
    byteArrayStream2.write(value2)
    var asn1InputStream2: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream2)
    var asn1Object2: ASN1Object = asn1InputStream2.readObject()
    @Assert(asn1Object2 is ASN1Boolean, true)
    var object2: ASN1Boolean = (asn1Object2 as ASN1Boolean).getOrThrow()
    var anyValue2: Any = object2.getValue()
    var boolValue2: Bool = (anyValue2 as Bool).getOrThrow()
    @Assert(boolValue2, true)
    @Assert(object2.valueHash(), 1231)

    var value3: Array<Byte> = [0x01, 0x01, 0x00]
    var byteArrayStream3: ByteBuffer = ByteBuffer()
    var asn1OutputStream3: ASN1OutputStream = ASN1OutputStream(DEREncoder(), byteArrayStream3)
    asn1OutputStream3.writeObject(ASN1Boolean(false))
    @Assert(byteArrayStream3.bytes(), value3)

    var value4: Array<Byte> = [0x01, 0x01, 0x01]
    var byteArrayStream4: ByteBuffer = ByteBuffer()
    var asn1OutputStream4: ASN1OutputStream = ASN1OutputStream(DEREncoder(), byteArrayStream4)
    asn1OutputStream4.writeObject(ASN1Boolean(true))
    @Assert(byteArrayStream4.bytes(), value4)

    var value5: Array<Byte> = [0x01, 0x01, 0x00]
    var byteArrayStream5: ByteBuffer = ByteBuffer()
    var asn1OutputStream5: ASN1OutputStream = ASN1OutputStream(DEREncoder(), byteArrayStream5)
    asn1OutputStream5.writeObject(ASN1Boolean(false, Array<Byte>()))
    @Assert(byteArrayStream5.bytes(), value5)

    var value6: Array<Byte> = [0x01, 0x01, 0x01]
    var byteArrayStream6: ByteBuffer = ByteBuffer()
    var asn1OutputStream6: ASN1OutputStream = ASN1OutputStream(DEREncoder(), byteArrayStream6)
    asn1OutputStream6.writeObject(ASN1Boolean(true, Array<Byte>()))
    @Assert(byteArrayStream6.bytes(), value6)
    return 0
}
