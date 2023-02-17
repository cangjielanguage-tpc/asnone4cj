// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from asn1 import asn1.*
from asn1 import asn1.types.*
from asn1 import asn1.util.*
from asn1 import asn1.encodingrules.*
from asn1 import asn1.encodingrules.der.*
from std import io.*

// 数组第一位0x05代表ASN1Null类型
// 数组第二位0x00代表数组长度为0
main(): Int64 {
    var value: Array<Byte> = [0x05, 0x00]
    var byteArrayStream: ByteArrayStream = ByteArrayStream()
    byteArrayStream.write(value)
    var asn1InputStream: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream)
    var asn1Object: ASN1Object = asn1InputStream.readObject()
    if (!(asn1Object is ASN1Null)) {
        return 1
    }
    var object: ASN1Null = (asn1Object as ASN1Null).getOrThrow()
    var anyValue: Any = object.getValue()
    if (object.valueHash() != 0) {
        return 1
    }

    var value1: Array<Byte> = [0x05, 0x00]
    var byteArrayStream1: ByteArrayStream = ByteArrayStream()
    var asn1OutputStream1: ASN1OutputStream = ASN1OutputStream(DEREncoder(), byteArrayStream1)
    asn1OutputStream1.writeObject(ASN1Null())
    if (byteArrayStream1.bytes() != value1) {
        return 1
    }

    return 0
}
