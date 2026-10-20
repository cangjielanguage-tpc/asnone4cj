// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import asn1.*
import std.io.*
import std.collection.*
import std.unittest.*
import std.unittest.testmacro.*

main(): Int64 {
    let SPNEGO_OID: ASN1ObjectIdentifier = ASN1ObjectIdentifier("1.3.6.1.5.5.2")

    var value: Array<Byte> = [0x60, 0x08, 0x06, 0x06, 0x2B, 0x06, 0x01, 0x05, 0x05, 0x02]
    var asn1TsgAll: ASN1Tag = ASN1Tag.forTag(ASN1TagClass.APPLICATION(0x40), 0x0).constructed()
    var byteArrayStream: ByteBuffer = ByteBuffer()
    byteArrayStream.write(value)
    var asn1InputStream: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream)
    var asn1Object: ASN1Object = asn1InputStream.readObject()
    var asn1Tag: ASN1Tag = asn1Object.getTag()
    @Assert(asn1Tag.toString(), asn1TsgAll.toString())
    @Assert(asn1Object is ASN1TaggedObject, true)
    var object: ASN1TaggedObject = (asn1Object as ASN1TaggedObject).getOrThrow()
    @Assert(object.getObject().toString(), SPNEGO_OID.toString())

    var value1: Array<Byte> = [0xa1, 0x08, 0x06, 0x06, 0x2B, 0x06, 0x01, 0x05, 0x05, 0x02]
    var asn1TsgAll1: ASN1Tag = ASN1Tag.forTag(ASN1TagClass.CONTEXT_SPECIFIC(0x80), 0x1).constructed()
    var byteArrayStream1: ByteBuffer = ByteBuffer()
    byteArrayStream1.write(value1)
    var asn1InputStream1: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream1)
    var asn1Object1: ASN1Object = asn1InputStream1.readObject()
    var asn1Tag1: ASN1Tag = asn1Object1.getTag()
    @Assert(asn1Tag1.toString(), asn1TsgAll1.toString())
    @Assert(asn1Object1 is ASN1TaggedObject, true)
    var object1: ASN1TaggedObject = (asn1Object1 as ASN1TaggedObject).getOrThrow()
    @Assert(object1.getObject().toString(), SPNEGO_OID.toString())

    var value2: Array<Byte> = [0x40, 0x06, 0x2B, 0x06, 0x01, 0x05, 0x05, 0x02]
    var asn1TsgAll2: ASN1Tag = ASN1Tag.forTag(ASN1TagClass.APPLICATION(0x40), 0x0).primitive()
    var byteArrayStream2: ByteBuffer = ByteBuffer()
    byteArrayStream2.write(value2)
    var asn1InputStream2: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream2)
    var asn1Object2: ASN1Object = asn1InputStream2.readObject()
    var asn1Tag2: ASN1Tag = asn1Object2.getTag()
    @Assert(asn1Tag2.toString(), asn1TsgAll2.toString())
    @Assert(asn1Object2 is ASN1TaggedObject, true)
    var object2: ASN1TaggedObject = (asn1Object2 as ASN1TaggedObject).getOrThrow()
    @Assert(object2.getObject(OBJECT_IDENTIFIER).toString(), SPNEGO_OID.toString())

    var value3: Array<Byte> = [0x81, 0x06, 0x2B, 0x06, 0x01, 0x05, 0x05, 0x02]
    var asn1TsgAll3: ASN1Tag = ASN1Tag.forTag(ASN1TagClass.CONTEXT_SPECIFIC(0x80), 0x01).primitive()
    var byteArrayStream3: ByteBuffer = ByteBuffer()
    byteArrayStream3.write(value3)
    var asn1InputStream3: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream3)
    var asn1Object3: ASN1Object = asn1InputStream3.readObject()
    var asn1Tag3: ASN1Tag = asn1Object3.getTag()
    @Assert(asn1Tag3.toString(), asn1TsgAll3.toString())
    @Assert(asn1Object3 is ASN1TaggedObject, true)
    var object3: ASN1TaggedObject = (asn1Object3 as ASN1TaggedObject).getOrThrow()
    @Assert(object3.getObject(OBJECT_IDENTIFIER).toString(), SPNEGO_OID.toString())

    var value4: Array<Byte> = [0x40, 0x06, 0x2B, 0x06, 0x01, 0x05, 0x05, 0x02]
    var byteArrayStream4: ByteBuffer = ByteBuffer()
    var asn1OutputStream4: ASN1OutputStream = ASN1OutputStream(DEREncoder(), byteArrayStream4)
    asn1OutputStream4.writeObject(ASN1TaggedObject(ASN1Tag.application(0x0).primitive(), SPNEGO_OID, false))
    @Assert(byteArrayStream4.bytes(), value4)

    var value5: Array<Byte> = [0x60, 0x08, 0x06, 0x06, 0x2B, 0x06, 0x01, 0x05, 0x05, 0x02]
    var byteArrayStream5: ByteBuffer = ByteBuffer()
    var asn1OutputStream5: ASN1OutputStream = ASN1OutputStream(DEREncoder(), byteArrayStream5)
    asn1OutputStream5.writeObject(ASN1TaggedObject(ASN1Tag.application(0x0).constructed(), SPNEGO_OID))
    @Assert(byteArrayStream5.bytes(), value5)

    var value6: Array<Byte> = [0x81, 0x06, 0x2B, 0x06, 0x01, 0x05, 0x05, 0x02]
    var byteArrayStream6: ByteBuffer = ByteBuffer()
    var asn1OutputStream6: ASN1OutputStream = ASN1OutputStream(DEREncoder(), byteArrayStream6)
    asn1OutputStream6.writeObject(ASN1TaggedObject(ASN1Tag.contextSpecific(0x01).primitive(), SPNEGO_OID, false))
    @Assert(byteArrayStream6.bytes(), value6)

    var value7: Array<Byte> = [0xa1, 0x08, 0x06, 0x06, 0x2B, 0x06, 0x01, 0x05, 0x05, 0x02]
    var byteArrayStream7: ByteBuffer = ByteBuffer()
    var asn1OutputStream7: ASN1OutputStream = ASN1OutputStream(DEREncoder(), byteArrayStream7)
    asn1OutputStream7.writeObject(ASN1TaggedObject(ASN1Tag.contextSpecific(0x01).constructed(), SPNEGO_OID))
    @Assert(byteArrayStream7.bytes(), value7)

    var byteArrayStream8: ByteBuffer = ByteBuffer()
    byteArrayStream8.write(value3)
    var asn1InputStream8: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream8)
    var asn1Object8: ASN1Object = asn1InputStream8.readObject()
    // 隐式 TaggedObject 未指定 tag 时 getObject 应抛异常
    var caught: Bool = false
    try {
        var object8: ASN1TaggedObject = (asn1Object8 as ASN1TaggedObject).getOrThrow()
        object8.getObject()
    } catch (e: ASN1ParseException) {
        caught = true
        @Assert(e.message, "Unknown ASN.1 tagUnable to parse the explicit Tagged Object with %s, it might be implicit")
    }
    @Assert(caught, true)
    return 0
}
