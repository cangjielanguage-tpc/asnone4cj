// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from asn1 import asn1.util.BigInt
from asn1 import asn1.*
from asn1 import asn1.types.*
from asn1 import asn1.util.*
from asn1 import asn1.encodingrules.*
from asn1 import asn1.encodingrules.der.*
from std import io.*

// 数组第一位0x02代表ASN1Integer类型
// 数组第二位0x01代表数组长度为1
// 数组第三位开始代表数组内容
main(): Int64 {
    var value: Array<Byte> = [0x02, 0x01, 0x03]
    var byteArrayStream: ByteArrayStream = ByteArrayStream()
    byteArrayStream.write(value)
    var asn1InputStream: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream)
    var asn1Object: ASN1Object = asn1InputStream.readObject()
    if (!(asn1Object is ASN1Integer)) {
        return 1
    }
    var object: ASN1Integer = (asn1Object as ASN1Integer).getOrThrow()
    var anyValue: Any = object.getValue()
    var bigValue: BigInt = (anyValue as BigInt).getOrThrow()
    var intValue: String = bigValue.toStringDec()
    if (!(intValue.equals("3"))) {
        return 2
    }
    var intHashcode: Int64 = object.valueHash()
    if (intHashcode != 3) {
        return 3
    }

    var value0: Array<Byte> = [0x02, 0x01, 0x80]
    var byteArrayStream0: ByteArrayStream = ByteArrayStream()
    byteArrayStream0.write(value0)
    var asn1InputStream0: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream0)
    var asn1Object0: ASN1Object = asn1InputStream0.readObject()
    if (!(asn1Object0 is ASN1Integer)) {
        return 4
    }
    var object0: ASN1Integer = (asn1Object0 as ASN1Integer).getOrThrow()
    var anyValue0: Any = object0.getValue()
    var bigValue0: BigInt = (anyValue0 as BigInt).getOrThrow()
    var intValue0: String = bigValue0.toStringDec()
    if (!(intValue0.equals("-128"))) {
        return 5
    }
    var intHashcode0: Int64 = object0.valueHash()
    if (intHashcode0 != -128) {
        return 6
    }

    var value1: Array<Byte> = [0x02, 0x02, 0x00, 0x80]
    var byteArrayStream1: ByteArrayStream = ByteArrayStream()
    byteArrayStream1.write(value1)
    var asn1InputStream1: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream1)
    var asn1Object1: ASN1Object = asn1InputStream1.readObject()
    if (!(asn1Object1 is ASN1Integer)) {
        return 7
    }
    var object1: ASN1Integer = (asn1Object1 as ASN1Integer).getOrThrow()
    var anyValue1: Any = object1.getValue()
    var bigValue1: BigInt = (anyValue1 as BigInt).getOrThrow()
    var intValue1: String = bigValue1.toStringDec()
    if (!(intValue1.equals("128"))) {
        return 8
    }
    var intHashcode1: Int64 = object1.valueHash()
    if (intHashcode1 != 128) {
        return 9
    }

    var value2: Array<Byte> = [0x02, 0x01, 0x83]
    var byteArrayStream2: ByteArrayStream = ByteArrayStream()
    byteArrayStream2.write(value2)
    var asn1InputStream2: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream2)
    var asn1Object2: ASN1Object = asn1InputStream2.readObject()
    if (!(asn1Object2 is ASN1Integer)) {
        return 10
    }
    var object2: ASN1Integer = (asn1Object2 as ASN1Integer).getOrThrow()
    var anyValue2: Any = object2.getValue()
    var bigValue2: BigInt = (anyValue2 as BigInt).getOrThrow()
    var intValue2: String = bigValue2.toStringDec()
    if (!(intValue2.equals("-125"))) {
        return 11
    }
    var intHashcode2: Int64 = object2.valueHash()
    if (intHashcode2 != -125) {
        return 12
    }

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
    var byteArrayStream3: ByteArrayStream = ByteArrayStream()
    byteArrayStream3.write(value3)
    var asn1InputStream3: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream3)
    var asn1Object3: ASN1Object = asn1InputStream3.readObject()
    if (!(asn1Object3 is ASN1Integer)) {
        return 13
    }
    var object3: ASN1Integer = (asn1Object3 as ASN1Integer).getOrThrow()
    var anyValue3: Any = object3.getValue()
    var bigValue3: BigInt = (anyValue3 as BigInt).getOrThrow()
    var intValue3: String = bigValue3.toStringDec()
    if (!(intValue3.equals(stringValue3))) {
        return 14
    }

    var value4: Array<Byte> = [0x02, 0x01, 0x7F]
    var byteArrayStream4: ByteArrayStream = ByteArrayStream()
    byteArrayStream4.write(value4)
    var asn1InputStream4: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream4)
    var asn1Object4: ASN1Object = asn1InputStream4.readObject()
    if (!(asn1Object4 is ASN1Integer)) {
        return 16
    }
    var object4: ASN1Integer = (asn1Object4 as ASN1Integer).getOrThrow()
    var anyValue4: Any = object4.getValue()
    var bigValue4: BigInt = (anyValue4 as BigInt).getOrThrow()
    var intValue4: String = bigValue4.toStringDec()
    if (!(intValue4.equals("127"))) {
        return 17
    }
    var intHashcode4: Int64 = object4.valueHash()
    if (intHashcode4 != 127) {
        return 18
    }

    var value5: Array<Byte> = [0x02, 0x01, 0xFF]
    var byteArrayStream5: ByteArrayStream = ByteArrayStream()
    byteArrayStream5.write(value5)
    var asn1InputStream5: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream5)
    var asn1Object5: ASN1Object = asn1InputStream5.readObject()
    if (!(asn1Object5 is ASN1Integer)) {
        return 19
    }
    var object5: ASN1Integer = (asn1Object5 as ASN1Integer).getOrThrow()
    var anyValue5: Any = object5.getValue()
    var bigValue5: BigInt = (anyValue5 as BigInt).getOrThrow()
    var intValue5: String = bigValue5.toStringDec()
    if (!(intValue5.equals("-1"))) {
        return 20
    }
    var intHashcode5: Int64 = object5.valueHash()
    if (intHashcode5 != -1) {
        return 21
    }

    var value6: Array<Byte> = [0x02, 0x02, 0x01, 0x00]
    var byteArrayStream6: ByteArrayStream = ByteArrayStream()
    byteArrayStream6.write(value6)
    var asn1InputStream6: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream6)
    var asn1Object6: ASN1Object = asn1InputStream6.readObject()
    if (!(asn1Object6 is ASN1Integer)) {
        return 22
    }
    var object6: ASN1Integer = (asn1Object6 as ASN1Integer).getOrThrow()
    var anyValue6: Any = object6.getValue()
    var bigValue6: BigInt = (anyValue6 as BigInt).getOrThrow()
    var intValue6: String = bigValue6.toStringDec()
    if (!(intValue6.equals("256"))) {
        return 23
    }
    var intHashcode6: Int64 = object6.valueHash()
    if (intHashcode6 != 256) {
        return 24
    }

    var value7: Array<Byte> = [0x02, 0x02, 0xff, 0xff]
    var byteArrayStream7: ByteArrayStream = ByteArrayStream()
    byteArrayStream7.write(value7)
    var asn1InputStream7: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream7)
    var asn1Object7: ASN1Object = asn1InputStream7.readObject()
    if (!(asn1Object7 is ASN1Integer)) {
        return 25
    }
    var object7: ASN1Integer = (asn1Object7 as ASN1Integer).getOrThrow()
    var anyValue7: Any = object7.getValue()
    var bigValue7: BigInt = (anyValue7 as BigInt).getOrThrow()
    var intValue7: String = bigValue7.toStringDec()
    if (!(intValue7.equals("-1"))) {
        return 26
    }
    var intHashcode7: Int64 = object7.valueHash()
    if (intHashcode7 != -1) {
        return 27
    }

    var value8: Array<Byte> = [0x02, 0x03, 0x01, 0xff, 0xff]
    var byteArrayStream8: ByteArrayStream = ByteArrayStream()
    byteArrayStream8.write(value8)
    var asn1InputStream8: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream8)
    var asn1Object8: ASN1Object = asn1InputStream8.readObject()
    if (!(asn1Object8 is ASN1Integer)) {
        return 28
    }
    var object8: ASN1Integer = (asn1Object8 as ASN1Integer).getOrThrow()
    var anyValue8: Any = object8.getValue()
    var bigValue8: BigInt = (anyValue8 as BigInt).getOrThrow()
    var intValue8: String = bigValue8.toStringDec()
    if (!(intValue8.equals("131071"))) {
        return 29
    }
    var intHashcode8: Int64 = object8.valueHash()
    if (intHashcode8 != 131071) {
        return 30
    }

    var value9: Array<Byte> = [0x02, 0x04, 0x01, 0x01, 0xff, 0xff]
    var byteArrayStream9: ByteArrayStream = ByteArrayStream()
    byteArrayStream9.write(value9)
    var asn1InputStream9: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream9)
    var asn1Object9: ASN1Object = asn1InputStream9.readObject()
    if (!(asn1Object9 is ASN1Integer)) {
        return 31
    }
    var object9: ASN1Integer = (asn1Object9 as ASN1Integer).getOrThrow()
    var anyValue9: Any = object9.getValue()
    var bigValue9: BigInt = (anyValue9 as BigInt).getOrThrow()
    var intValue9: String = bigValue9.toStringDec()
    if (!(intValue9.equals("16908287"))) {
        return 32
    }
    var intHashcode9: Int64 = object9.valueHash()
    if (intHashcode9 != 16908287) {
        return 33
    }

    var value10: Array<Byte> = [0x02, 0x01, 0x03]
    var byteArrayStream10: ByteArrayStream = ByteArrayStream()
    var asn1OutputStream10: ASN1OutputStream = ASN1OutputStream(encode(), byteArrayStream10)
    asn1OutputStream10.writeObject(ASN1Integer(3))
    if (byteArrayStream10.bytes() != value10) {
        return 34
    }

    var value11: Array<Byte> = [0x02, 0x01, 0x80]
    var byteArrayStream11: ByteArrayStream = ByteArrayStream()
    var asn1OutputStream11: ASN1OutputStream = ASN1OutputStream(encode(), byteArrayStream11)
    asn1OutputStream11.writeObject(ASN1Integer(-128))
    if (byteArrayStream11.bytes() != value11) {
        return 35
    }

    var value12: Array<Byte> = [0x02, 0x02, 0x00, 0x80]
    var byteArrayStream12: ByteArrayStream = ByteArrayStream()
    var asn1OutputStream12: ASN1OutputStream = ASN1OutputStream(encode(), byteArrayStream12)
    asn1OutputStream12.writeObject(ASN1Integer(128))
    if (byteArrayStream12.bytes() != value12) {
        return 36
    }

    var value13: Array<Byte> = [0x02, 0x01, 0x83]
    var byteArrayStream13: ByteArrayStream = ByteArrayStream()
    var asn1OutputStream13: ASN1OutputStream = ASN1OutputStream(encode(), byteArrayStream13)
    asn1OutputStream13.writeObject(ASN1Integer(-125))
    if (byteArrayStream13.bytes() != value13) {
        return 37
    }

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
    var byteArrayStream14: ByteArrayStream = ByteArrayStream()
    var asn1OutputStream14: ASN1OutputStream = ASN1OutputStream(encode(), byteArrayStream14)
    asn1OutputStream14.writeObject(ASN1Integer(BigInt(stringValue14)))
    if (byteArrayStream14.bytes() != value14) {
        return 38
    }

    var value15: Array<Byte> = [0x02, 0x01, 0x7F]
    var byteArrayStream15: ByteArrayStream = ByteArrayStream()
    var asn1OutputStream15: ASN1OutputStream = ASN1OutputStream(encode(), byteArrayStream15)
    asn1OutputStream15.writeObject(ASN1Integer(127))
    if (byteArrayStream15.bytes() != value15) {
        return 39
    }

    var value16: Array<Byte> = [0x02, 0x01, 0xFF]
    var byteArrayStream16: ByteArrayStream = ByteArrayStream()
    var asn1OutputStream16: ASN1OutputStream = ASN1OutputStream(encode(), byteArrayStream16)
    asn1OutputStream16.writeObject(ASN1Integer(-1))
    if (byteArrayStream16.bytes() != value16) {
        return 40
    }

    var value17: Array<Byte> = [0x02, 0x02, 0x01, 0x00]
    var byteArrayStream17: ByteArrayStream = ByteArrayStream()
    var asn1OutputStream17: ASN1OutputStream = ASN1OutputStream(encode(), byteArrayStream17)
    asn1OutputStream17.writeObject(ASN1Integer(256))
    if (byteArrayStream17.bytes() != value17) {
        return 41
    }

    var value18: Array<Byte> = [0x02, 0x03, 0x01, 0xff, 0xff]
    var byteArrayStream18: ByteArrayStream = ByteArrayStream()
    var asn1OutputStream18: ASN1OutputStream = ASN1OutputStream(encode(), byteArrayStream18)
    asn1OutputStream18.writeObject(ASN1Integer(131071))
    if (byteArrayStream18.bytes() != value18) {
        return 42
    }

    var value19: Array<Byte> = [0x02, 0x04, 0x01, 0x01, 0xff, 0xff]
    var byteArrayStream19: ByteArrayStream = ByteArrayStream()
    var asn1OutputStream19: ASN1OutputStream = ASN1OutputStream(encode(), byteArrayStream19)
    asn1OutputStream19.writeObject(ASN1Integer(16908287))
    if (byteArrayStream19.bytes() != value19) {
        return 43
    }

    var value20: Array<Byte> = [0x22, 0x01, 0x03]
    var byteArrayStream20: ByteArrayStream = ByteArrayStream()
    byteArrayStream20.write(value20)
    var asn1InputStream20: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream20)
    try {
        asn1InputStream20.readObject()
    } catch (e: ASN1ParseException) {
        if (!((e.message).equals("Cannot parse ASN.1 object from stream"))) {
            return 44
        }
    }

    return 0
}

class encode <: ASN1Encoder {}
