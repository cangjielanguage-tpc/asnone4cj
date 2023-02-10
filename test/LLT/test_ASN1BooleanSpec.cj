// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from asn1 import asn1.*
from asn1 import asn1.types.*
from asn1 import asn1.util.*
from asn1 import asn1.encodingrules.*
from asn1 import asn1.encodingrules.der.*
from std import io.*

// 数组第一位0x01代表ASN1Boolean类型
// 数组第二位0x01
// 数组第三位0x0代表false,0x01代表true,默认值是true
main(): Int64 {
    var value: Array<Byte> = [0x01, 0x01, 0x0]
    var byteArrayStream: ByteArrayStream = ByteArrayStream()
    byteArrayStream.write(value)
    var asn1InputStream: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream)
    var asn1Object: ASN1Object = asn1InputStream.readObject()
    if (!(asn1Object is ASN1Boolean)) {
        return 1
    }
    var object: ASN1Boolean = (asn1Object as ASN1Boolean).getOrThrow()
    if (object.valueHash() != 1237) {
        return 1
    }

    var value1: Array<Byte> = [0x01, 0x01, 0x01]
    var byteArrayStream1: ByteArrayStream = ByteArrayStream()
    byteArrayStream1.write(value1)
    var asn1InputStream1: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream1)
    var asn1Object1: ASN1Object = asn1InputStream1.readObject()
    if (!(asn1Object1 is ASN1Boolean)) {
        return 1
    }
    var object1: ASN1Boolean = (asn1Object1 as ASN1Boolean).getOrThrow()
    if (object1.valueHash() != 1231) {
        return 1
    }

    var value2: Array<Byte> = [0x01, 0x01, 0xFF]
    var byteArrayStream2: ByteArrayStream = ByteArrayStream()
    byteArrayStream2.write(value2)
    var asn1InputStream2: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream2)
    var asn1Object2: ASN1Object = asn1InputStream2.readObject()
    if (!(asn1Object2 is ASN1Boolean)) {
        return 1
    }
    var object2: ASN1Boolean = (asn1Object2 as ASN1Boolean).getOrThrow()
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

    return 0
}
