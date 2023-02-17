// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from cryptocj import bignumcj.*
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
    var bigValue: CPointer<BIGNUM> = (anyValue as CPointer<BIGNUM>).getOrThrow()
    var intValue: UInt64 = bnGetWord(bigValue)
    if (intValue != 3) {
        return 1
    }
    var intHashcode: Int64 = object.valueHash()
    if (intHashcode != 3) {
        return 1
    }

    var value0: Array<Byte> = [0x02, 0x01, 0x33]
    var byteArrayStream0: ByteArrayStream = ByteArrayStream()
    byteArrayStream0.write(value0)
    var asn1InputStream0: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream0)
    var asn1Object0: ASN1Object = asn1InputStream0.readObject()
    if (!(asn1Object0 is ASN1Integer)) {
        return 1
    }
    var object0: ASN1Integer = (asn1Object0 as ASN1Integer).getOrThrow()
    var anyValue0: Any = object0.getValue()
    var bigValue0: CPointer<BIGNUM> = (anyValue0 as CPointer<BIGNUM>).getOrThrow()
    var intValue0: UInt64 = bnGetWord(bigValue0)
    if (intValue0 != 51) {
        return 1
    }
    var intHashcode0: Int64 = object0.valueHash()
    if (intHashcode0 != 51) {
        return 1
    }

    var value1: Array<Byte> = [0x02, 0x01, 0x44]
    var byteArrayStream1: ByteArrayStream = ByteArrayStream()
    byteArrayStream1.write(value1)
    var asn1InputStream1: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream1)
    var asn1Object1: ASN1Object = asn1InputStream1.readObject()
    if (!(asn1Object1 is ASN1Integer)) {
        return 1
    }
    var object1: ASN1Integer = (asn1Object1 as ASN1Integer).getOrThrow()
    var anyValue1: Any = object1.getValue()
    var bigValue1: CPointer<BIGNUM> = (anyValue1 as CPointer<BIGNUM>).getOrThrow()
    var intValue1: UInt64 = bnGetWord(bigValue1)
    if (intValue1 != 68) {
        return 1
    }
    var intHashcode1: Int64 = object1.valueHash()
    if (intHashcode1 != 68) {
        return 1
    }

    var value2: Array<Byte> = [0x02, 0x01, 0x55]
    var byteArrayStream2: ByteArrayStream = ByteArrayStream()
    byteArrayStream2.write(value2)
    var asn1InputStream2: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream2)
    var asn1Object2: ASN1Object = asn1InputStream2.readObject()
    if (!(asn1Object2 is ASN1Integer)) {
        return 1
    }
    var object2: ASN1Integer = (asn1Object2 as ASN1Integer).getOrThrow()
    var anyValue2: Any = object2.getValue()
    var bigValue2: CPointer<BIGNUM> = (anyValue2 as CPointer<BIGNUM>).getOrThrow()
    var intValue2: UInt64 = bnGetWord(bigValue2)
    if (intValue2 != 85) {
        return 1
    }
    var intHashcode2: Int64 = object2.valueHash()
    if (intHashcode2 != 85) {
        return 1
    }

    var value3: Array<Byte> = [0x02, 0x01, 0x66]
    var byteArrayStream3: ByteArrayStream = ByteArrayStream()
    byteArrayStream3.write(value3)
    var asn1InputStream3: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream3)
    var asn1Object3: ASN1Object = asn1InputStream3.readObject()
    if (!(asn1Object3 is ASN1Integer)) {
        return 1
    }
    var object3: ASN1Integer = (asn1Object3 as ASN1Integer).getOrThrow()
    var anyValue3: Any = object3.getValue()
    var bigValue3: CPointer<BIGNUM> = (anyValue3 as CPointer<BIGNUM>).getOrThrow()
    var intValue3: UInt64 = bnGetWord(bigValue3)
    if (intValue3 != 102) {
        return 1
    }
    var intHashcode3: Int64 = object3.valueHash()
    if (intHashcode3 != 102) {
        return 1
    }

    var value4: Array<Byte> = [0x02, 0x01, 0x7F]
    var byteArrayStream4: ByteArrayStream = ByteArrayStream()
    byteArrayStream4.write(value4)
    var asn1InputStream4: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream4)
    var asn1Object4: ASN1Object = asn1InputStream4.readObject()
    if (!(asn1Object4 is ASN1Integer)) {
        return 1
    }
    var object4: ASN1Integer = (asn1Object4 as ASN1Integer).getOrThrow()
    var anyValue4: Any = object4.getValue()
    var bigValue4: CPointer<BIGNUM> = (anyValue4 as CPointer<BIGNUM>).getOrThrow()
    var intValue4: UInt64 = bnGetWord(bigValue4)
    if (intValue4 != 127) {
        return 1
    }
    var intHashcode4: Int64 = object4.valueHash()
    if (intHashcode4 != 127) {
        return 1
    }

    var value5: Array<Byte> = [0x02, 0x01, 0xFF]
    var byteArrayStream5: ByteArrayStream = ByteArrayStream()
    byteArrayStream5.write(value5)
    var asn1InputStream5: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream5)
    var asn1Object5: ASN1Object = asn1InputStream5.readObject()
    if (!(asn1Object5 is ASN1Integer)) {
        return 1
    }
    var object5: ASN1Integer = (asn1Object5 as ASN1Integer).getOrThrow()
    var anyValue5: Any = object5.getValue()
    var bigValue5: CPointer<BIGNUM> = (anyValue5 as CPointer<BIGNUM>).getOrThrow()
    var intValue5: UInt64 = bnGetWord(bigValue5)
    if (intValue5 != 255) {
        return 1
    }
    var intHashcode5: Int64 = object5.valueHash()
    if (intHashcode5 != 255) {
        return 1
    }

    var value6: Array<Byte> = [0x02, 0x02, 0x01, 0x00]
    var byteArrayStream6: ByteArrayStream = ByteArrayStream()
    byteArrayStream6.write(value5)
    var asn1InputStream6: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream6)
    var asn1Object6: ASN1Object = asn1InputStream6.readObject()
    if (!(asn1Object6 is ASN1Integer)) {
        return 1
    }
    var object6: ASN1Integer = (asn1Object6 as ASN1Integer).getOrThrow()
    var anyValue6: Any = object6.getValue()
    var bigValue6: CPointer<BIGNUM> = (anyValue6 as CPointer<BIGNUM>).getOrThrow()
    var intValue6: UInt64 = bnGetWord(bigValue6)
    if (intValue6 != 256) {
        // return 1
    }
    var intHashcode6: Int64 = object6.valueHash()
    if (intHashcode6 != 256) {
        // return 1
    }

    var value7: Array<Byte> = [0x02, 0x02, 0xff, 0xff]
    var byteArrayStream7: ByteArrayStream = ByteArrayStream()
    byteArrayStream7.write(value7)
    var asn1InputStream7: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream7)
    var asn1Object7: ASN1Object = asn1InputStream7.readObject()
    if (!(asn1Object7 is ASN1Integer)) {
        return 1
    }
    var object7: ASN1Integer = (asn1Object7 as ASN1Integer).getOrThrow()
    var anyValue7: Any = object7.getValue()
    var bigValue7: CPointer<BIGNUM> = (anyValue7 as CPointer<BIGNUM>).getOrThrow()
    var intValue7: UInt64 = bnGetWord(bigValue7)
    if (intValue7 != 65535) {
        // return 1
    }
    var intHashcode7: Int64 = object7.valueHash()
    if (intHashcode7 != 65535) {
        // return 1
    }

    var value8: Array<Byte> = [0x02, 0x03, 0x01, 0xff, 0xff]
    var byteArrayStream8: ByteArrayStream = ByteArrayStream()
    byteArrayStream8.write(value8)
    var asn1InputStream8: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream8)
    var asn1Object8: ASN1Object = asn1InputStream8.readObject()
    if (!(asn1Object8 is ASN1Integer)) {
        return 1
    }
    var object8: ASN1Integer = (asn1Object8 as ASN1Integer).getOrThrow()
    var anyValue8: Any = object8.getValue()
    var bigValue8: CPointer<BIGNUM> = (anyValue8 as CPointer<BIGNUM>).getOrThrow()
    var intValue8: UInt64 = bnGetWord(bigValue8)
    if (intValue8 != 131071) {
        // return 1
    }
    var intHashcode8: Int64 = object8.valueHash()
    if (intHashcode8 != 131071) {
        // return 1
    }

    var value9: Array<Byte> = [0x02, 0x04, 0x01, 0x01, 0xff, 0xff]
    var byteArrayStream9: ByteArrayStream = ByteArrayStream()
    byteArrayStream9.write(value9)
    var asn1InputStream9: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream9)
    var asn1Object9: ASN1Object = asn1InputStream9.readObject()
    if (!(asn1Object9 is ASN1Integer)) {
        return 1
    }
    var object9: ASN1Integer = (asn1Object9 as ASN1Integer).getOrThrow()
    var anyValue9: Any = object9.getValue()
    var bigValue9: CPointer<BIGNUM> = (anyValue9 as CPointer<BIGNUM>).getOrThrow()
    var intValue9: UInt64 = bnGetWord(bigValue9)
    if (intValue9 != 16908287) {
        // return 1
    }
    var intHashcode9: Int64 = object9.valueHash()
    if (intHashcode9 != 16908287) {
        // return 1
    }

    var value10: Array<Byte> = [0x02, 0x01, 0x03]
    var byteArrayStream10: ByteArrayStream = ByteArrayStream()
    var asn1OutputStream10: ASN1OutputStream = ASN1OutputStream(encode(), byteArrayStream10)
    asn1OutputStream10.writeObject(ASN1Integer(3))
    if (byteArrayStream10.bytes() != value10) {
        return 1
    }

    var value11: Array<Byte> = [0x02, 0x01, 0x03]
    var byteArrayStream11: ByteArrayStream = ByteArrayStream()
    var asn1OutputStream11: ASN1OutputStream = ASN1OutputStream(encode(), byteArrayStream11)
    var bigValue11: CPointer<BIGNUM> = bnNew()
    bnSetWord(bigValue11, 3)
    asn1OutputStream11.writeObject(ASN1Integer(bigValue11))
    if (byteArrayStream11.bytes() != value11) {
        return 1
    }

    var value12: Array<Byte> = [0x02, 0x01, 0x33]
    var byteArrayStream12: ByteArrayStream = ByteArrayStream()
    var asn1OutputStream12: ASN1OutputStream = ASN1OutputStream(encode(), byteArrayStream12)
    asn1OutputStream12.writeObject(ASN1Integer(51))
    if (byteArrayStream12.bytes() != value12) {
        return 1
    }

    var value13: Array<Byte> = [0x02, 0x01, 0x33]
    var byteArrayStream13: ByteArrayStream = ByteArrayStream()
    var asn1OutputStream13: ASN1OutputStream = ASN1OutputStream(encode(), byteArrayStream13)
    var bigValue13: CPointer<BIGNUM> = bnNew()
    bnSetWord(bigValue13, 51)
    asn1OutputStream13.writeObject(ASN1Integer(bigValue13))
    if (byteArrayStream13.bytes() != value13) {
        return 1
    }

    var value14: Array<Byte> = [0x02, 0x01, 0x44]
    var byteArrayStream14: ByteArrayStream = ByteArrayStream()
    var asn1OutputStream14: ASN1OutputStream = ASN1OutputStream(encode(), byteArrayStream14)
    asn1OutputStream14.writeObject(ASN1Integer(68))
    if (byteArrayStream14.bytes() != value14) {
        return 1
    }

    var value15: Array<Byte> = [0x02, 0x01, 0x44]
    var byteArrayStream15: ByteArrayStream = ByteArrayStream()
    var asn1OutputStream15: ASN1OutputStream = ASN1OutputStream(encode(), byteArrayStream15)
    var bigValue15: CPointer<BIGNUM> = bnNew()
    bnSetWord(bigValue15, 68)
    asn1OutputStream15.writeObject(ASN1Integer(bigValue15))
    if (byteArrayStream15.bytes() != value15) {
        return 1
    }

    var value16: Array<Byte> = [0x02, 0x01, 0x55]
    var byteArrayStream16: ByteArrayStream = ByteArrayStream()
    var asn1OutputStream16: ASN1OutputStream = ASN1OutputStream(encode(), byteArrayStream16)
    asn1OutputStream16.writeObject(ASN1Integer(85))
    if (byteArrayStream16.bytes() != value16) {
        return 1
    }

    var value17: Array<Byte> = [0x02, 0x01, 0x55]
    var byteArrayStream17: ByteArrayStream = ByteArrayStream()
    var asn1OutputStream17: ASN1OutputStream = ASN1OutputStream(encode(), byteArrayStream17)
    var bigValue17: CPointer<BIGNUM> = bnNew()
    bnSetWord(bigValue17, 85)
    asn1OutputStream17.writeObject(ASN1Integer(bigValue17))
    if (byteArrayStream17.bytes() != value17) {
        return 1
    }

    var value18: Array<Byte> = [0x02, 0x01, 0x66]
    var byteArrayStream18: ByteArrayStream = ByteArrayStream()
    var asn1OutputStream18: ASN1OutputStream = ASN1OutputStream(encode(), byteArrayStream18)
    asn1OutputStream18.writeObject(ASN1Integer(102))
    if (byteArrayStream18.bytes() != value18) {
        return 1
    }

    var value19: Array<Byte> = [0x02, 0x01, 0x66]
    var byteArrayStream19: ByteArrayStream = ByteArrayStream()
    var asn1OutputStream19: ASN1OutputStream = ASN1OutputStream(encode(), byteArrayStream19)
    var bigValue19: CPointer<BIGNUM> = bnNew()
    bnSetWord(bigValue19, 102)
    asn1OutputStream19.writeObject(ASN1Integer(bigValue19))
    if (byteArrayStream19.bytes() != value19) {
        return 1
    }

    var value20: Array<Byte> = [0x02, 0x01, 0x7F]
    var byteArrayStream20: ByteArrayStream = ByteArrayStream()
    var asn1OutputStream20: ASN1OutputStream = ASN1OutputStream(encode(), byteArrayStream20)
    asn1OutputStream20.writeObject(ASN1Integer(127))
    if (byteArrayStream20.bytes() != value20) {
        return 1
    }

    var value21: Array<Byte> = [0x02, 0x01, 0x7F]
    var byteArrayStream21: ByteArrayStream = ByteArrayStream()
    var asn1OutputStream21: ASN1OutputStream = ASN1OutputStream(encode(), byteArrayStream21)
    var bigValue21: CPointer<BIGNUM> = bnNew()
    bnSetWord(bigValue21, 127)
    asn1OutputStream21.writeObject(ASN1Integer(bigValue21))
    if (byteArrayStream21.bytes() != value21) {
        return 1
    }

    var value22: Array<Byte> = [0x02, 0x01, 0xFF]
    var byteArrayStream22: ByteArrayStream = ByteArrayStream()
    var asn1OutputStream22: ASN1OutputStream = ASN1OutputStream(encode(), byteArrayStream22)
    asn1OutputStream22.writeObject(ASN1Integer(255))
    if (byteArrayStream22.bytes() != value22) {
        return 1
    }

    var value23: Array<Byte> = [0x02, 0x01, 0xFF]
    var byteArrayStream23: ByteArrayStream = ByteArrayStream()
    var asn1OutputStream23: ASN1OutputStream = ASN1OutputStream(encode(), byteArrayStream23)
    var bigValue23: CPointer<BIGNUM> = bnNew()
    bnSetWord(bigValue23, 255)
    asn1OutputStream23.writeObject(ASN1Integer(bigValue23))
    if (byteArrayStream23.bytes() != value23) {
        return 1
    }

    var value24: Array<Byte> = [0x02, 0x02, 0x01, 0x00]
    var byteArrayStream24: ByteArrayStream = ByteArrayStream()
    var asn1OutputStream24: ASN1OutputStream = ASN1OutputStream(encode(), byteArrayStream24)
    asn1OutputStream24.writeObject(ASN1Integer(256))
    if (byteArrayStream24.bytes() != value24) {
        return 1
    }

    var value25: Array<Byte> = [0x02, 0x02, 0x01, 0x00]
    var byteArrayStream25: ByteArrayStream = ByteArrayStream()
    var asn1OutputStream25: ASN1OutputStream = ASN1OutputStream(encode(), byteArrayStream25)
    var bigValue25: CPointer<BIGNUM> = bnNew()
    bnSetWord(bigValue25, 256)
    asn1OutputStream25.writeObject(ASN1Integer(bigValue25))
    if (byteArrayStream25.bytes() != value25) {
        return 1
    }

    var value26: Array<Byte> = [0x02, 0x02, 0xff, 0xff]
    var byteArrayStream26: ByteArrayStream = ByteArrayStream()
    var asn1OutputStream26: ASN1OutputStream = ASN1OutputStream(encode(), byteArrayStream26)
    asn1OutputStream26.writeObject(ASN1Integer(65535))
    if (byteArrayStream26.bytes() != value26) {
        return 1
    }

    var value27: Array<Byte> = [0x02, 0x02, 0xff, 0xff]
    var byteArrayStream27: ByteArrayStream = ByteArrayStream()
    var asn1OutputStream27: ASN1OutputStream = ASN1OutputStream(encode(), byteArrayStream27)
    var bigValue27: CPointer<BIGNUM> = bnNew()
    bnSetWord(bigValue27, 65535)
    asn1OutputStream27.writeObject(ASN1Integer(bigValue27))
    if (byteArrayStream27.bytes() != value27) {
        return 1
    }

    var value28: Array<Byte> = [0x02, 0x03, 0x01, 0xff, 0xff]
    var byteArrayStream28: ByteArrayStream = ByteArrayStream()
    var asn1OutputStream28: ASN1OutputStream = ASN1OutputStream(encode(), byteArrayStream28)
    asn1OutputStream28.writeObject(ASN1Integer(131071))
    if (byteArrayStream28.bytes() != value28) {
        return 1
    }

    var value29: Array<Byte> = [0x02, 0x03, 0x01, 0xff, 0xff]
    var byteArrayStream29: ByteArrayStream = ByteArrayStream()
    var asn1OutputStream29: ASN1OutputStream = ASN1OutputStream(encode(), byteArrayStream29)
    var bigValue29: CPointer<BIGNUM> = bnNew()
    bnSetWord(bigValue29, 131071)
    asn1OutputStream29.writeObject(ASN1Integer(bigValue29))
    if (byteArrayStream29.bytes() != value29) {
        return 1
    }

    var value30: Array<Byte> = [0x02, 0x04, 0x01, 0x01, 0xff, 0xff]
    var byteArrayStream30: ByteArrayStream = ByteArrayStream()
    var asn1OutputStream30: ASN1OutputStream = ASN1OutputStream(encode(), byteArrayStream30)
    asn1OutputStream30.writeObject(ASN1Integer(16908287))
    if (byteArrayStream30.bytes() != value30) {
        return 1
    }

    var value31: Array<Byte> = [0x02, 0x04, 0x01, 0x01, 0xff, 0xff]
    var byteArrayStream31: ByteArrayStream = ByteArrayStream()
    var asn1OutputStream31: ASN1OutputStream = ASN1OutputStream(encode(), byteArrayStream31)
    var bigValue31: CPointer<BIGNUM> = bnNew()
    bnSetWord(bigValue31, 16908287)
    asn1OutputStream31.writeObject(ASN1Integer(bigValue31))
    if (byteArrayStream31.bytes() != value31) {
        return 1
    }

    return 0
}

class encode <: ASN1Encoder {}
