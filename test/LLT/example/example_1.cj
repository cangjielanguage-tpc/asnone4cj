// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from asn1 import asn1.*
from std import io.*

main(): Int64 {
    var value3: Array<Byte> = [0x01, 0x01, 0x00]
    var byteArrayStream3: ByteArrayStream = ByteArrayStream()
    var asn1OutputStream3: ASN1OutputStream = ASN1OutputStream(DEREncoder(), byteArrayStream3)
    asn1OutputStream3.writeObject(ASN1Boolean(false))
    if (byteArrayStream3.bytes() == value3) {
        println("success")
    }

    var value4: Array<Byte> = [0x01, 0x01, 0x01]
    var byteArrayStream4: ByteArrayStream = ByteArrayStream()
    var asn1OutputStream4: ASN1OutputStream = ASN1OutputStream(DEREncoder(), byteArrayStream4)
    asn1OutputStream4.writeObject(ASN1Boolean(true))
    if (byteArrayStream4.bytes() == value4) {
        println("success")
    }

    return 0
}
