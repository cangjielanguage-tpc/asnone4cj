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
    println(intValue)
    if (intValue != 3) {
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
    println(intValue0)
    if (intValue0 != 51) {
        return 1
    }

    var value1: Array<Byte> = [0x02, 0x01, 0x7F]
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
    println(intValue1)
    if (intValue1 != 127) {
        return 1
    }

    var value2: Array<Byte> = [0x02, 0x05, 0x01, 0x44, 0x44, 0x44, 0x44]
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
    println(intValue2)
    if (intValue2 != 273) {
        return 1
    }

    var value3: Array<Byte> = [0x02, 0x02, 0x01, 0x44]
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
    println(intValue3)
    if (intValue3 != 69) {
        return 1
    }

    var value4: Array<Byte> = [0x02, 0x01, 0x55]
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
    println(intValue4)
    if (intValue4 != 85) {
        return 1
    }

    var value5: Array<Byte> = [0x02, 0x01, 0x66]
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
    println(intValue5)
    if (intValue5 != 102) {
        return 1
    }

    return 0
}
