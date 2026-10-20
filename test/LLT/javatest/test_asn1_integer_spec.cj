// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import asn1.*
import std.io.*
import std.math.numeric.*
import std.unittest.*
import std.unittest.testmacro.*

// 数组第一位0x02代表ASN1Integer类型
// 数组第二位0x01代表数组长度为1
// 数组第三位开始代表数组内容
main(): Int64 {
    var value: Array<Byte> = [0x02, 0x01, 0x03]
    var byteArrayStream: ByteBuffer = ByteBuffer()
    byteArrayStream.write(value)
    var asn1InputStream: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream)
    var asn1Object: ASN1Object = asn1InputStream.readObject()
    @Assert(asn1Object is ASN1Integer, true)
    var object: ASN1Integer = (asn1Object as ASN1Integer).getOrThrow()
    var anyValue: Any = object.getValue()
    var bigValue: BigInt = (anyValue as BigInt).getOrThrow()
    var intValue: String = bigValue.toString()
    @Assert(intValue, "3")
    var intHashcode: Int64 = object.valueHash()
    @Assert(intHashcode, 3)

    var value0: Array<Byte> = [0x02, 0x01, 0x80]
    var byteArrayStream0: ByteBuffer = ByteBuffer()
    byteArrayStream0.write(value0)
    var asn1InputStream0: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream0)
    var asn1Object0: ASN1Object = asn1InputStream0.readObject()
    @Assert(asn1Object0 is ASN1Integer, true)
    var object0: ASN1Integer = (asn1Object0 as ASN1Integer).getOrThrow()
    var anyValue0: Any = object0.getValue()
    var bigValue0: BigInt = (anyValue0 as BigInt).getOrThrow()
    var intValue0: String = bigValue0.toString()
    @Assert(intValue0, "-128")
    var intHashcode0: Int64 = object0.valueHash()
    @Assert(intHashcode0, -128)

    var value1: Array<Byte> = [0x02, 0x02, 0x00, 0x80]
    var byteArrayStream1: ByteBuffer = ByteBuffer()
    byteArrayStream1.write(value1)
    var asn1InputStream1: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream1)
    var asn1Object1: ASN1Object = asn1InputStream1.readObject()
    @Assert(asn1Object1 is ASN1Integer, true)
    var object1: ASN1Integer = (asn1Object1 as ASN1Integer).getOrThrow()
    var anyValue1: Any = object1.getValue()
    var bigValue1: BigInt = (anyValue1 as BigInt).getOrThrow()
    var intValue1: String = bigValue1.toString()
    @Assert(intValue1, "128")
    var intHashcode1: Int64 = object1.valueHash()
    @Assert(intHashcode1, 128)

    var value2: Array<Byte> = [0x02, 0x01, 0x83]
    var byteArrayStream2: ByteBuffer = ByteBuffer()
    byteArrayStream2.write(value2)
    var asn1InputStream2: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream2)
    var asn1Object2: ASN1Object = asn1InputStream2.readObject()
    @Assert(asn1Object2 is ASN1Integer, true)
    var object2: ASN1Integer = (asn1Object2 as ASN1Integer).getOrThrow()
    var anyValue2: Any = object2.getValue()
    var bigValue2: BigInt = (anyValue2 as BigInt).getOrThrow()
    var intValue2: String = bigValue2.toString()
    @Assert(intValue2, "-125")
    var intHashcode2: Int64 = object2.valueHash()
    @Assert(intHashcode2, -125)

    var value3: Array<Byte> = [0x02, 0x81, 0x81, 0x00, 0x8f, 0xe2, 0x41, 0x2a, 0x08, 0xe8, 0x51, 0xa8, 0x8c, 0xb3, 0xe8,
    0x53, 0xe7, 0xd5, 0x49, 0x50, 0xb3, 0x27, 0x8a, 0x2b, 0xcb, 0xea, 0xb5, 0x42, 0x73, 0xea, 0x02, 0x57, 0xcc, 0x65,
    0x33, 0xee, 0x88, 0x20, 0x61, 0xa1, 0x17, 0x56, 0xc1, 0x24, 0x18, 0xe3, 0xa8, 0x08, 0xd3, 0xbe, 0xd9, 0x31, 0xf3,
    0x37, 0x0b, 0x94, 0xb8, 0xcc, 0x43, 0x08, 0x0b, 0x70, 0x24, 0xf7, 0x9c, 0xb1, 0x8d, 0x5d, 0xd6, 0x6d, 0x82, 0xd0,
    0x54, 0x09, 0x84, 0xf8, 0x9f, 0x97, 0x01, 0x75, 0x05, 0x9c, 0x89, 0xd4, 0xd5, 0xc9, 0x1e, 0xc9, 0x13, 0xd7, 0x2a,
    0x6b, 0x30, 0x91, 0x19, 0xd6, 0xd4, 0x42, 0xe0, 0xc4, 0x9d, 0x7c, 0x92, 0x71, 0xe1, 0xb2, 0x2f, 0x5c, 0x8d, 0xee,
    0xf0, 0xf1, 0x17, 0x1e, 0xd2, 0x5f, 0x31, 0x5b, 0xb1, 0x9c, 0xbc, 0x20, 0x55, 0xbf, 0x3a, 0x37, 0x42, 0x45, 0x75,
    0xdc, 0x90, 0x65]
    var stringValue3: String =
        "101038645214968213029489864879507742420925199145132483818978980455132582258676381289000109319204510275496178360219909358646064503513889573494768497419381751359787623037449375660247011308028102339473875820259375735204357343091558075960601364303443174344509161224592926325506446708043127306053676664799729848421"
    var byteArrayStream3: ByteBuffer = ByteBuffer()
    byteArrayStream3.write(value3)
    var asn1InputStream3: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream3)
    var asn1Object3: ASN1Object = asn1InputStream3.readObject()
    @Assert(asn1Object3 is ASN1Integer, true)
    var object3: ASN1Integer = (asn1Object3 as ASN1Integer).getOrThrow()
    var anyValue3: Any = object3.getValue()
    var bigValue3: BigInt = (anyValue3 as BigInt).getOrThrow()
    var intValue3: String = bigValue3.toString()
    @Assert(intValue3, stringValue3)

    var value4: Array<Byte> = [0x02, 0x01, 0x7F]
    var byteArrayStream4: ByteBuffer = ByteBuffer()
    byteArrayStream4.write(value4)
    var asn1InputStream4: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream4)
    var asn1Object4: ASN1Object = asn1InputStream4.readObject()
    @Assert(asn1Object4 is ASN1Integer, true)
    var object4: ASN1Integer = (asn1Object4 as ASN1Integer).getOrThrow()
    var anyValue4: Any = object4.getValue()
    var bigValue4: BigInt = (anyValue4 as BigInt).getOrThrow()
    var intValue4: String = bigValue4.toString()
    @Assert(intValue4, "127")
    var intHashcode4: Int64 = object4.valueHash()
    @Assert(intHashcode4, 127)

    var value5: Array<Byte> = [0x02, 0x01, 0xFF]
    var byteArrayStream5: ByteBuffer = ByteBuffer()
    byteArrayStream5.write(value5)
    var asn1InputStream5: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream5)
    var asn1Object5: ASN1Object = asn1InputStream5.readObject()
    @Assert(asn1Object5 is ASN1Integer, true)
    var object5: ASN1Integer = (asn1Object5 as ASN1Integer).getOrThrow()
    var anyValue5: Any = object5.getValue()
    var bigValue5: BigInt = (anyValue5 as BigInt).getOrThrow()
    var intValue5: String = bigValue5.toString()
    @Assert(intValue5, "-1")
    var intHashcode5: Int64 = object5.valueHash()
    @Assert(intHashcode5, -1)

    var value6: Array<Byte> = [0x02, 0x02, 0x01, 0x00]
    var byteArrayStream6: ByteBuffer = ByteBuffer()
    byteArrayStream6.write(value6)
    var asn1InputStream6: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream6)
    var asn1Object6: ASN1Object = asn1InputStream6.readObject()
    @Assert(asn1Object6 is ASN1Integer, true)
    var object6: ASN1Integer = (asn1Object6 as ASN1Integer).getOrThrow()
    var anyValue6: Any = object6.getValue()
    var bigValue6: BigInt = (anyValue6 as BigInt).getOrThrow()
    var intValue6: String = bigValue6.toString()
    @Assert(intValue6, "256")
    var intHashcode6: Int64 = object6.valueHash()
    @Assert(intHashcode6, 256)

    var value7: Array<Byte> = [0x02, 0x02, 0xff, 0xff]
    var byteArrayStream7: ByteBuffer = ByteBuffer()
    byteArrayStream7.write(value7)
    var asn1InputStream7: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream7)
    var asn1Object7: ASN1Object = asn1InputStream7.readObject()
    @Assert(asn1Object7 is ASN1Integer, true)
    var object7: ASN1Integer = (asn1Object7 as ASN1Integer).getOrThrow()
    var anyValue7: Any = object7.getValue()
    var bigValue7: BigInt = (anyValue7 as BigInt).getOrThrow()
    var intValue7: String = bigValue7.toString()
    @Assert(intValue7, "-1")
    var intHashcode7: Int64 = object7.valueHash()
    @Assert(intHashcode7, -1)

    var value8: Array<Byte> = [0x02, 0x03, 0x01, 0xff, 0xff]
    var byteArrayStream8: ByteBuffer = ByteBuffer()
    byteArrayStream8.write(value8)
    var asn1InputStream8: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream8)
    var asn1Object8: ASN1Object = asn1InputStream8.readObject()
    @Assert(asn1Object8 is ASN1Integer, true)
    var object8: ASN1Integer = (asn1Object8 as ASN1Integer).getOrThrow()
    var anyValue8: Any = object8.getValue()
    var bigValue8: BigInt = (anyValue8 as BigInt).getOrThrow()
    var intValue8: String = bigValue8.toString()
    @Assert(intValue8, "131071")
    var intHashcode8: Int64 = object8.valueHash()
    @Assert(intHashcode8, 131071)

    var value9: Array<Byte> = [0x02, 0x04, 0x01, 0x01, 0xff, 0xff]
    var byteArrayStream9: ByteBuffer = ByteBuffer()
    byteArrayStream9.write(value9)
    var asn1InputStream9: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream9)
    var asn1Object9: ASN1Object = asn1InputStream9.readObject()
    @Assert(asn1Object9 is ASN1Integer, true)
    var object9: ASN1Integer = (asn1Object9 as ASN1Integer).getOrThrow()
    var anyValue9: Any = object9.getValue()
    var bigValue9: BigInt = (anyValue9 as BigInt).getOrThrow()
    var intValue9: String = bigValue9.toString()
    @Assert(intValue9, "16908287")
    var intHashcode9: Int64 = object9.valueHash()
    @Assert(intHashcode9, 16908287)

    var value10: Array<Byte> = [0x02, 0x01, 0x03]
    var byteArrayStream10: ByteBuffer = ByteBuffer()
    var asn1OutputStream10: ASN1OutputStream = ASN1OutputStream(encode(), byteArrayStream10)
    asn1OutputStream10.writeObject(ASN1Integer(3))
    @Assert(byteArrayStream10.bytes(), value10)

    var value11: Array<Byte> = [0x02, 0x01, 0x80]
    var byteArrayStream11: ByteBuffer = ByteBuffer()
    var asn1OutputStream11: ASN1OutputStream = ASN1OutputStream(encode(), byteArrayStream11)
    asn1OutputStream11.writeObject(ASN1Integer(-128))
    @Assert(byteArrayStream11.bytes(), value11)

    var value12: Array<Byte> = [0x02, 0x02, 0x00, 0x80]
    var byteArrayStream12: ByteBuffer = ByteBuffer()
    var asn1OutputStream12: ASN1OutputStream = ASN1OutputStream(encode(), byteArrayStream12)
    asn1OutputStream12.writeObject(ASN1Integer(128))
    @Assert(byteArrayStream12.bytes(), value12)

    var value13: Array<Byte> = [0x02, 0x01, 0x83]
    var byteArrayStream13: ByteBuffer = ByteBuffer()
    var asn1OutputStream13: ASN1OutputStream = ASN1OutputStream(encode(), byteArrayStream13)
    asn1OutputStream13.writeObject(ASN1Integer(-125))
    @Assert(byteArrayStream13.bytes(), value13)

    var value14: Array<Byte> = [0x02, 0x81, 0x81, 0x00, 0x8f, 0xe2, 0x41, 0x2a, 0x08, 0xe8, 0x51, 0xa8, 0x8c, 0xb3,
    0xe8, 0x53, 0xe7, 0xd5, 0x49, 0x50, 0xb3, 0x27, 0x8a, 0x2b, 0xcb, 0xea, 0xb5, 0x42, 0x73, 0xea, 0x02, 0x57, 0xcc,
    0x65, 0x33, 0xee, 0x88, 0x20, 0x61, 0xa1, 0x17, 0x56, 0xc1, 0x24, 0x18, 0xe3, 0xa8, 0x08, 0xd3, 0xbe, 0xd9, 0x31,
    0xf3, 0x37, 0x0b, 0x94, 0xb8, 0xcc, 0x43, 0x08, 0x0b, 0x70, 0x24, 0xf7, 0x9c, 0xb1, 0x8d, 0x5d, 0xd6, 0x6d, 0x82,
    0xd0, 0x54, 0x09, 0x84, 0xf8, 0x9f, 0x97, 0x01, 0x75, 0x05, 0x9c, 0x89, 0xd4, 0xd5, 0xc9, 0x1e, 0xc9, 0x13, 0xd7,
    0x2a, 0x6b, 0x30, 0x91, 0x19, 0xd6, 0xd4, 0x42, 0xe0, 0xc4, 0x9d, 0x7c, 0x92, 0x71, 0xe1, 0xb2, 0x2f, 0x5c, 0x8d,
    0xee, 0xf0, 0xf1, 0x17, 0x1e, 0xd2, 0x5f, 0x31, 0x5b, 0xb1, 0x9c, 0xbc, 0x20, 0x55, 0xbf, 0x3a, 0x37, 0x42, 0x45,
    0x75, 0xdc, 0x90, 0x65]
    var stringValue14: String =
        "101038645214968213029489864879507742420925199145132483818978980455132582258676381289000109319204510275496178360219909358646064503513889573494768497419381751359787623037449375660247011308028102339473875820259375735204357343091558075960601364303443174344509161224592926325506446708043127306053676664799729848421"
    var byteArrayStream14: ByteBuffer = ByteBuffer()
    var asn1OutputStream14: ASN1OutputStream = ASN1OutputStream(encode(), byteArrayStream14)
    asn1OutputStream14.writeObject(ASN1Integer(BigInt.parse(stringValue14)))
    @Assert(byteArrayStream14.bytes(), value14)

    var value15: Array<Byte> = [0x02, 0x01, 0x7F]
    var byteArrayStream15: ByteBuffer = ByteBuffer()
    var asn1OutputStream15: ASN1OutputStream = ASN1OutputStream(encode(), byteArrayStream15)
    asn1OutputStream15.writeObject(ASN1Integer(127))
    @Assert(byteArrayStream15.bytes(), value15)

    var value16: Array<Byte> = [0x02, 0x01, 0xFF]
    var byteArrayStream16: ByteBuffer = ByteBuffer()
    var asn1OutputStream16: ASN1OutputStream = ASN1OutputStream(encode(), byteArrayStream16)
    asn1OutputStream16.writeObject(ASN1Integer(-1))
    @Assert(byteArrayStream16.bytes(), value16)

    var value17: Array<Byte> = [0x02, 0x02, 0x01, 0x00]
    var byteArrayStream17: ByteBuffer = ByteBuffer()
    var asn1OutputStream17: ASN1OutputStream = ASN1OutputStream(encode(), byteArrayStream17)
    asn1OutputStream17.writeObject(ASN1Integer(256))
    @Assert(byteArrayStream17.bytes(), value17)

    var value18: Array<Byte> = [0x02, 0x03, 0x01, 0xff, 0xff]
    var byteArrayStream18: ByteBuffer = ByteBuffer()
    var asn1OutputStream18: ASN1OutputStream = ASN1OutputStream(encode(), byteArrayStream18)
    asn1OutputStream18.writeObject(ASN1Integer(131071))
    @Assert(byteArrayStream18.bytes(), value18)

    var value19: Array<Byte> = [0x02, 0x04, 0x01, 0x01, 0xff, 0xff]
    var byteArrayStream19: ByteBuffer = ByteBuffer()
    var asn1OutputStream19: ASN1OutputStream = ASN1OutputStream(encode(), byteArrayStream19)
    asn1OutputStream19.writeObject(ASN1Integer(16908287))
    @Assert(byteArrayStream19.bytes(), value19)

    var value20: Array<Byte> = [0x22, 0x01, 0x03]
    var byteArrayStream20: ByteBuffer = ByteBuffer()
    byteArrayStream20.write(value20)
    var asn1InputStream20: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream20)
    // 未知 tag 应抛异常，且异常保留根因信息
    var caught: Bool = false
    try {
        asn1InputStream20.readObject()
    } catch (e: ASN1ParseException) {
        caught = true
        // 修复后异常保留根因信息，message 以原始 cause 前缀开头
        @Assert(e.message.contains("Cannot parse ASN.1 object from stream"), true)
    }
    @Assert(caught, true)
    return 0
}

class encode <: ASN1Encoder {}
