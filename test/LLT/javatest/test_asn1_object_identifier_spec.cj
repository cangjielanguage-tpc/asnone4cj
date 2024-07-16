// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import asn1.*
import std.io.*

// 数组第一位0x06代表ASN1ObjectIdentifier类型
// 数组第二位0x03代表数组长度为3
main(): Int64 {
    var value: Array<Byte> = [0x06, 0x03, 0x55, 0x04, 0x03]
    var byteArrayStream: ByteArrayStream = ByteArrayStream()
    byteArrayStream.write(value)
    var asn1InputStream: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream)
    var asn1Object: ASN1Object = asn1InputStream.readObject()
    if (!(asn1Object is ASN1ObjectIdentifier)) {
        return 1
    }
    var object: ASN1ObjectIdentifier = (asn1Object as ASN1ObjectIdentifier).getOrThrow()
    var anyObject: Any = object.getValue()
    var anyString: String = (anyObject as String).getOrThrow()
    if (anyString!="2.5.4.3") {
        return 2
    }

    var value1: Array<Byte> = [0x06, 0x09, 0x2b, 0x06, 0x01, 0x04, 0x01, 0x82, 0x37, 0x15, 0x14]
    var byteArrayStream1: ByteArrayStream = ByteArrayStream()
    byteArrayStream1.write(value1)
    var asn1InputStream1: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream1)
    var asn1Object1: ASN1Object = asn1InputStream1.readObject()
    if (!(asn1Object1 is ASN1ObjectIdentifier)) {
        return 3
    }
    var object1: ASN1ObjectIdentifier = (asn1Object1 as ASN1ObjectIdentifier).getOrThrow()
    var anyObject1: Any = object1.getValue()
    var anyString1: String = (anyObject1 as String).getOrThrow()
    if (anyString1!="1.3.6.1.4.1.311.21.20") {
        return 4
    }

    var value2: Array<Byte> = [0x06, 0x09, 0x2a, 0x86, 0x48, 0x86, 0xf7, 0x0d, 0x01, 0x07, 0x02]
    var byteArrayStream2: ByteArrayStream = ByteArrayStream()
    byteArrayStream2.write(value2)
    var asn1InputStream2: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream2)
    var asn1Object2: ASN1Object = asn1InputStream2.readObject()
    if (!(asn1Object2 is ASN1ObjectIdentifier)) {
        return 5
    }
    var object2: ASN1ObjectIdentifier = (asn1Object2 as ASN1ObjectIdentifier).getOrThrow()
    var anyObject2: Any = object2.getValue()
    var anyString2: String = (anyObject2 as String).getOrThrow()
    if (anyString2!="1.2.840.113549.1.7.2") {
        return 6
    }

    var value3: Array<Byte> = [0x06, 0x03, 0x55, 0x04, 0x03]
    var byteArrayStream3: ByteArrayStream = ByteArrayStream()
    var asn1OutputStream3: ASN1OutputStream = ASN1OutputStream(DEREncoder(), byteArrayStream3)
    asn1OutputStream3.writeObject(ASN1ObjectIdentifier("2.5.4.3"))
    if (byteArrayStream3.bytes() != value3) {
        return 7
    }

    var value4: Array<Byte> = [0x06, 0x03, 0x55, 0x04, 0x03]
    var byteArrayStream4: ByteArrayStream = ByteArrayStream()
    var asn1OutputStream4: ASN1OutputStream = ASN1OutputStream(DEREncoder(), byteArrayStream4)
    asn1OutputStream4.writeObject(ASN1ObjectIdentifier("2.5.4.3", Array<Byte>([])))
    if (byteArrayStream4.bytes() != value4) {
        return 8
    }

    var value5: Array<Byte> = [0x06, 0x09, 0x2b, 0x06, 0x01, 0x04, 0x01, 0x82, 0x37, 0x15, 0x14]
    var byteArrayStream5: ByteArrayStream = ByteArrayStream()
    var asn1OutputStream5: ASN1OutputStream = ASN1OutputStream(DEREncoder(), byteArrayStream5)
    var aSN1ObjectIdentifier5: ASN1ObjectIdentifier = ASN1ObjectIdentifier("1.3.6.1.4.1.311.21.20")
    asn1OutputStream5.writeObject(aSN1ObjectIdentifier5)
    if (byteArrayStream5.bytes() != value5) {
        return 9
    }

    var value6: Array<Byte> = [0x06, 0x09, 0x2b, 0x06, 0x01, 0x04, 0x01, 0x82, 0x37, 0x15, 0x14]
    var byteArrayStream6: ByteArrayStream = ByteArrayStream()
    var asn1OutputStream6: ASN1OutputStream = ASN1OutputStream(DEREncoder(), byteArrayStream6)
    var aSN1ObjectIdentifier6: ASN1ObjectIdentifier = ASN1ObjectIdentifier("1.3.6.1.4.1.311.21.20", Array<Byte>([]))
    asn1OutputStream6.writeObject(aSN1ObjectIdentifier6)
    if (byteArrayStream6.bytes() != value6) {
        return 10
    }

    var value7: Array<Byte> = [0x06, 0x09, 0x2a, 0x86, 0x48, 0x86, 0xf7, 0x0d, 0x01, 0x07, 0x02]
    var byteArrayStream7: ByteArrayStream = ByteArrayStream()
    var asn1OutputStream7: ASN1OutputStream = ASN1OutputStream(DEREncoder(), byteArrayStream7)
    var aSN1ObjectIdentifier7: ASN1ObjectIdentifier = ASN1ObjectIdentifier("1.2.840.113549.1.7.2")
    asn1OutputStream7.writeObject(aSN1ObjectIdentifier7)
    if (byteArrayStream7.bytes() != value7) {
        return 11
    }

    var value8: Array<Byte> = [0x06, 0x09, 0x2a, 0x86, 0x48, 0x86, 0xf7, 0x0d, 0x01, 0x07, 0x02]
    var byteArrayStream8: ByteArrayStream = ByteArrayStream()
    var asn1OutputStream8: ASN1OutputStream = ASN1OutputStream(DEREncoder(), byteArrayStream8)
    var aSN1ObjectIdentifier8: ASN1ObjectIdentifier = ASN1ObjectIdentifier("1.2.840.113549.1.7.2", Array<Byte>([]))
    asn1OutputStream8.writeObject(aSN1ObjectIdentifier8)
    if (byteArrayStream8.bytes() != value8) {
        return 12
    }

    return 0
}
