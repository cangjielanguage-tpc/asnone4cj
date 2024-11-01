// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import asn1.*
import std.io.*

main(): Int64 {
    var value: Array<Byte> = [0x03, 0x04, 0x02, 0xF0, 0xF0, 0xF4]
    var byteArrayStream: ByteBuffer = ByteBuffer()
    byteArrayStream.write(value)
    var asn1InputStream: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream)
    var asn1Object: ASN1Object = asn1InputStream.readObject()
    if (!(asn1Object is ASN1BitString)) {
        return 1
    }
    var object: ASN1BitString = (asn1Object as ASN1BitString).getOrThrow()
    var anyValue: Any = object.getValue()
    var boolValue: Array<Bool> = (anyValue as Array<Bool>).getOrThrow()
    if (boolValue.size != 22) {
        return 2
    }
    var valueInt: Array<Int64> = [1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 1, 0, 1]
    for (i in 0..boolValue.size) {
        if (boolValue[i] != (valueInt[i] == 1)) {
            return 3
        }
    }

    var value1: Array<Byte> = [0x03, 0x04, 0x06, 0x6E, 0x5D, 0xC0]
    var byteArrayStream1: ByteBuffer = ByteBuffer()
    byteArrayStream1.write(value1)
    var asn1InputStream1: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream1)
    var asn1Object1: ASN1Object = asn1InputStream1.readObject()
    if (!(asn1Object1 is ASN1BitString)) {
        return 4
    }
    var object1: ASN1BitString = (asn1Object1 as ASN1BitString).getOrThrow()
    var anyValue1: Any = object1.getValue()
    var boolValue1: Array<Bool> = (anyValue1 as Array<Bool>).getOrThrow()
    if (boolValue1.size != 18) {
        return 5
    }
    var valueInt1: Array<Int64> = [0, 1, 1, 0, 1, 1, 1, 0, 0, 1, 0, 1, 1, 1, 0, 1, 1, 1]
    for (i in 0..boolValue1.size) {
        if (boolValue1[i] != (valueInt1[i] == 1)) {
            return 6
        }
    }

    var value2: Array<Byte> = [0x03, 0x04, 0x02, 0xF0, 0xF0, 0xF4]
    var byteArrayStream2: ByteBuffer = ByteBuffer()
    byteArrayStream2.write(value2)
    var asn1InputStream2: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream2)
    var asn1Object2: ASN1Object = asn1InputStream2.readObject()
    if (!(asn1Object2 is ASN1BitString)) {
        return 7
    }
    var object2: ASN1BitString = (asn1Object2 as ASN1BitString).getOrThrow()
    var anyValue2: Any = object2.getValue()
    var boolValue2: Array<Bool> = (anyValue2 as Array<Bool>).getOrThrow()
    if (boolValue2.size != 22) {
        return 8
    }
    var bitString2: ASN1BitString = ASN1BitString(boolValue2)
    if (bitString2.length() != 22) {
        return 9
    }
    if (bitString2.getValueBytes() != object2.getValueBytes()) {
        return 10
    }
    for (i in 0..bitString2.length()) {
        if (object2.isSet(i) != bitString2.isSet(i)) {
            return 11
        }
    }

    var value3: Array<Byte> = [0x03, 0x04, 0x06, 0x6E, 0x5D, 0xC0]
    var byteArrayStream3: ByteBuffer = ByteBuffer()
    byteArrayStream3.write(value3)
    var asn1InputStream3: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream3)
    var asn1Object3: ASN1Object = asn1InputStream3.readObject()
    if (!(asn1Object3 is ASN1BitString)) {
        return 7
    }
    var object3: ASN1BitString = (asn1Object3 as ASN1BitString).getOrThrow()
    var anyValue3: Any = object3.getValue()
    var boolValue3: Array<Bool> = (anyValue3 as Array<Bool>).getOrThrow()
    if (boolValue3.size != 18) {
        return 8
    }
    var bitString3: ASN1BitString = ASN1BitString(boolValue3)
    if (bitString3.length() != 18) {
        return 9
    }
    if (bitString3.getValueBytes() != object3.getValueBytes()) {
        return 10
    }
    for (i in 0..bitString3.length()) {
        if (object3.isSet(i) != bitString3.isSet(i)) {
            return 11
        }
    }

    var value4: Array<Bool> = [true, true, true, true, false, false, false, false, true, true, true, true, false, false,
    false, false, true, true, true, true, false, true]
    var bitString4: ASN1BitString = ASN1BitString(value4)
    var valueInt4: Array<Int64> = [1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 1, 0, 1]
    for (i in 0..valueInt4.size) {
        if (bitString4.isSet(i) != (valueInt4[i] == 1)) {
            return 12
        }
    }

    var value5: Array<Bool> = [false, true, true, false, true, true, true, false, false, true, false, true, true, true,
    false, true, true, true]
    var bitString5: ASN1BitString = ASN1BitString(value5)
    var valueInt5: Array<Int64> = [0, 1, 1, 0, 1, 1, 1, 0, 0, 1, 0, 1, 1, 1, 0, 1, 1, 1]
    for (i in 0..valueInt5.size) {
        if (bitString5.isSet(i) != (valueInt5[i] == 1)) {
            return 13
        }
    }

    var value6: Array<Byte> = [0x03, 0x04, 0x02, 0xF0, 0xF0, 0xF4]
    var byteArrayStream6: ByteBuffer = ByteBuffer()
    var asn1OutputStream6: ASN1OutputStream = ASN1OutputStream(DEREncoder(), byteArrayStream6)
    var valueBool6: Array<Bool> = [true, true, true, true, false, false, false, false, true, true, true, true, false,
    false, false, false, true, true, true, true, false, true]
    var bitString6: ASN1BitString = ASN1BitString(valueBool6)
    asn1OutputStream6.writeObject(bitString6)
    if (byteArrayStream6.bytes() != value6) {
        return 14
    }

    var value7: Array<Byte> = [0x03, 0x04, 0x06, 0x6e, 0x5d, 0xc0]
    var byteArrayStream7: ByteBuffer = ByteBuffer()
    var asn1OutputStream7: ASN1OutputStream = ASN1OutputStream(DEREncoder(), byteArrayStream7)
    var valueBool7: Array<Bool> = [false, true, true, false, true, true, true, false, false, true, false, true, true,
    true, false, true, true, true]
    var bitString7: ASN1BitString = ASN1BitString(valueBool7)
    asn1OutputStream7.writeObject(bitString7)
    if (byteArrayStream7.bytes() != value7) {
        return 15
    }

    var value8: Array<Byte> = [0x23, 0x09, 0x03, 0x03, 0x0, 0xF0, 0xF0, 0x03, 0x02, 0x02, 0xF4]
    var asn1InputStream8: ASN1InputStream = ASN1InputStream(BERDecoder(), value8)
    var asn1Object8: ASN1Object = asn1InputStream8.readObject()
    var object8: ASN1BitString = (asn1Object8 as ASN1BitString).getOrThrow()
    if (object8.getTag().getAsn1Encoding() != ASN1Encoding.CONSTRUCTED(0x20)) {
        return 16
    }
    if (object8.length() != 22) {
        return 17
    }

    return 0
}
