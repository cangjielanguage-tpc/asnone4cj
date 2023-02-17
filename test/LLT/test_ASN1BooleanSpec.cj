// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from asn1 import asn1.*
from asn1 import asn1.types.*
from asn1 import asn1.util.*
from asn1 import asn1.encodingrules.*
from asn1 import asn1.encodingrules.der.*
from std import io.*

// 数组第一位0x01代表ASN1Boolean类型
// 数组第二位0x01代表数组长度为1
// 数组第三位0x0代表false,0x01代表true,默认值是true
main(): Int64 {
    // false
    var value: Array<Byte> = [0x01, 0x01, 0x0]
    var byteArrayStream: ByteArrayStream = ByteArrayStream()
    byteArrayStream.write(value)
    var asn1InputStream: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream)
    var asn1Object: ASN1Object = asn1InputStream.readObject()
    if (!(asn1Object is ASN1Boolean)) {
        return 1
    }
    var object: ASN1Boolean = (asn1Object as ASN1Boolean).getOrThrow()
    var anyValue: Any = object.getValue()
    var boolValue: Bool = (anyValue as Bool).getOrThrow()
    if (boolValue) {
        return 1
    }
    if (object.valueHash() != 1237) {
        return 1
    }

    // true
    var value1: Array<Byte> = [0x01, 0x01, 0x01]
    var byteArrayStream1: ByteArrayStream = ByteArrayStream()
    byteArrayStream1.write(value1)
    var asn1InputStream1: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream1)
    var asn1Object1: ASN1Object = asn1InputStream1.readObject()
    if (!(asn1Object1 is ASN1Boolean)) {
        return 1
    }
    var object1: ASN1Boolean = (asn1Object1 as ASN1Boolean).getOrThrow()
    var anyValue1: Any = object1.getValue()
    var boolValue1: Bool = (anyValue1 as Bool).getOrThrow()
    if (!boolValue1) {
        return 1
    }
    if (object1.valueHash() != 1231) {
        return 1
    }

    // true
    var value2: Array<Byte> = [0x01, 0x01, 0xFF]
    var byteArrayStream2: ByteArrayStream = ByteArrayStream()
    byteArrayStream2.write(value2)
    var asn1InputStream2: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream2)
    var asn1Object2: ASN1Object = asn1InputStream2.readObject()
    if (!(asn1Object2 is ASN1Boolean)) {
        return 1
    }
    var object2: ASN1Boolean = (asn1Object2 as ASN1Boolean).getOrThrow()
    var anyValue2: Any = object2.getValue()
    var boolValue2: Bool = (anyValue2 as Bool).getOrThrow()
    if (!boolValue2) {
        return 1
    }
    if (object2.valueHash() != 1231) {
        return 1
    }

    var value3: Array<Byte> = [0x01, 0x01, 0x00]
    var byteArrayStream3: ByteArrayStream = ByteArrayStream()
    var asn1OutputStream3: ASN1OutputStream = ASN1OutputStream(DEREncoder(), byteArrayStream3)
    asn1OutputStream3.writeObject(ASN1Boolean(false))
    if (byteArrayStream3.bytes() != value3) {
        return 1
    }

    var value4: Array<Byte> = [0x01, 0x01, 0x01]
    var byteArrayStream4: ByteArrayStream = ByteArrayStream()
    var asn1OutputStream4: ASN1OutputStream = ASN1OutputStream(DEREncoder(), byteArrayStream4)
    asn1OutputStream4.writeObject(ASN1Boolean(true))
    if (byteArrayStream4.bytes() != value4) {
        return 1
    }

    var value5: Array<Byte> = [0x01, 0x01, 0x00]
    var byteArrayStream5: ByteArrayStream = ByteArrayStream()
    var asn1OutputStream5: ASN1OutputStream = ASN1OutputStream(DEREncoder(), byteArrayStream5)
    asn1OutputStream5.writeObject(ASN1Boolean(false, Array<Byte>()))
    if (byteArrayStream5.bytes() != value5) {
        return 1
    }

    var value6: Array<Byte> = [0x01, 0x01, 0x01]
    var byteArrayStream6: ByteArrayStream = ByteArrayStream()
    var asn1OutputStream6: ASN1OutputStream = ASN1OutputStream(DEREncoder(), byteArrayStream6)
    asn1OutputStream6.writeObject(ASN1Boolean(true, Array<Byte>()))
    if (byteArrayStream6.bytes() != value6) {
        return 1
    }

    return 0
}
