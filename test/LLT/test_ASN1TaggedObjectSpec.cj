// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from asn1 import asn1.*
from asn1 import asn1.types.*
from asn1 import asn1.util.*
from asn1 import asn1.encodingrules.*
from asn1 import asn1.encodingrules.der.*
from std import io.*
from std import collection.*

main(): Int64 {
    let SPNEGO_OID: ASN1ObjectIdentifier = ASN1ObjectIdentifier("1.3.6.1.5.5.2")

    var value: Array<Byte> = [0x60, 0x08, 0x06, 0x06, 0x2B, 0x06, 0x01, 0x05, 0x05, 0x02]
    var asn1TsgAll: ASN1Tag = ASN1Tag.forTag(ASN1TagClass.APPLICATION(0x40), 0x0).constructed()
    var byteArrayStream: ByteArrayStream = ByteArrayStream()
    byteArrayStream.write(value)
    var asn1InputStream: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream)
    var asn1Object: ASN1Object = asn1InputStream.readObject()
    var asn1Tag: ASN1Tag = asn1Object.getTag()
    if (asn1Tag.toString() != asn1TsgAll.toString()) {
        return 1
    }
    if (!(asn1Object is ASN1TaggedObject)) {
        return 1
    }
    var object: ASN1TaggedObject = (asn1Object as ASN1TaggedObject).getOrThrow()
    if (object.getObject().toString() != SPNEGO_OID.toString()) {
        return 1
    }

    var value1: Array<Byte> = [0xa1, 0x08, 0x06, 0x06, 0x2B, 0x06, 0x01, 0x05, 0x05, 0x02]
    var asn1TsgAll1: ASN1Tag = ASN1Tag.forTag(ASN1TagClass.CONTEXT_SPECIFIC(0x80), 0x1).constructed()
    var byteArrayStream1: ByteArrayStream = ByteArrayStream()
    byteArrayStream1.write(value1)
    var asn1InputStream1: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream1)
    var asn1Object1: ASN1Object = asn1InputStream1.readObject()
    var asn1Tag1: ASN1Tag = asn1Object1.getTag()
    if (asn1Tag1.toString() != asn1TsgAll1.toString()) {
        return 1
    }
    if (!(asn1Object1 is ASN1TaggedObject)) {
        return 1
    }
    var object1: ASN1TaggedObject = (asn1Object1 as ASN1TaggedObject).getOrThrow()
    if (object1.getObject().toString() != SPNEGO_OID.toString()) {
        return 1
    }

    return 0
}
