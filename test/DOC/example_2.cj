// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import asn1.*
import std.io.*

main(): Int64 {
    var value: Array<Byte> = [0x01, 0x01, 0x0]
    var byteArrayStream: ByteArrayStream = ByteArrayStream()
    byteArrayStream.write(value)
    var asn1InputStream: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream)
    var asn1Object: ASN1Object = asn1InputStream.readObject()
    if (asn1Object is ASN1Boolean) {
        println("success")
    }
    var object: ASN1Boolean = (asn1Object as ASN1Boolean).getOrThrow()
    var anyValue: Any = object.getValue()
    var boolValue: Bool = (anyValue as Bool).getOrThrow()
    if (!boolValue) {
        println("success")
    }
    if (object.valueHash() == 1237) {
        println("success")
    }

    var value1: Array<Byte> = [0x01, 0x01, 0x01]
    var byteArrayStream1: ByteArrayStream = ByteArrayStream()
    byteArrayStream1.write(value1)
    var asn1InputStream1: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream1)
    var asn1Object1: ASN1Object = asn1InputStream1.readObject()
    if (asn1Object1 is ASN1Boolean) {
        println("success")
    }
    var object1: ASN1Boolean = (asn1Object1 as ASN1Boolean).getOrThrow()
    var anyValue1: Any = object1.getValue()
    var boolValue1: Bool = (anyValue1 as Bool).getOrThrow()
    if (boolValue1) {
        println("success")
    }
    if (object1.valueHash() == 1231) {
        println("success")
    }

    return 0
}
