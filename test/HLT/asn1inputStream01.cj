// 3rd_party_lib:asnone4cj/target/release/asn1

import std.io.*
import asn1.*
import std.collection.*

@Test
public class asn_Asn1InputStream01 {
    @TestCase
    func asn_Asn1InputStream1(): Unit {
        DEREncoder()
        var buffer: Array<Byte> = [0x01, 0x01, 0x0]
        var byteArrayStream: ByteBuffer = ByteBuffer()
        byteArrayStream.write(buffer)
        var asn1inputstream: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream)
        var readtag = asn1inputstream.readTag().getTag()
        println(readtag)
        @Assert(readtag,1)
    }

    @TestCase
    func asn_Asn1InputStream2(): Unit {
        var buffer: Array<Byte> = [0x02, 0x01, 0x0]
        var byteArrayStream: ByteBuffer = ByteBuffer()
        byteArrayStream.write(buffer)
        var asn1inputstream: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream)
        var readtag = asn1inputstream.readTag().getTag()
        println(readtag)
        @Assert(readtag,2)
    }

    @TestCase
    func asn_Asn1InputStream3(): Unit {
        var buffer: Array<Byte> = [0x0A, 0x01, 0x0]
        var byteArrayStream: ByteBuffer = ByteBuffer()
        byteArrayStream.write(buffer)
        var asn1inputstream: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream)
        var readtag = asn1inputstream.readTag().getTag()
        println(readtag)
        @Assert(readtag,10)
    }

    @TestCase
    func asn_Asn1InputStream4(): Unit {
        try {
            var buffer: Array<Byte> = [0x11, 0x01, 0x0]
            var byteArrayStream: ByteBuffer = ByteBuffer()
            byteArrayStream.write(buffer)
            var asn1inputstream: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream)
            asn1inputstream.readObject()
            var readtag = asn1inputstream.readTag().getTag()
            println(readtag)
            @Assert(readtag,10)
        } catch (e: Exception) {
            @Assert(e.toString(),"Exception: Cannot parse ASN.1 object from stream")
        }
    }

    @TestCase
    func asn_Asn1InputStream5(): Unit {
        try {
            var buffer: Array<Byte> = [0x10, 0x01, 0x0]
            var byteArrayStream: ByteBuffer = ByteBuffer()
            byteArrayStream.write(buffer)
            var asn1inputstream: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream)
            var readtag = asn1inputstream.readTag().getTag()
            println(readtag)
            @Assert(readtag,10)
        } catch (e: Exception) {
            @Assert(e.toString(),"IllegalArgumentException: The ASN.1 tag does not support encoding")
        }
    }

    @TestCase
    func asn_Asn1InputStream6(): Unit {
        var buffer: Array<Byte> = [0x06, 0x01, 0x0]
        var byteArrayStream: ByteBuffer = ByteBuffer()
        byteArrayStream.write(buffer)
        var asn1inputstream: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream)
        var readtag = asn1inputstream.readTag().getTag()
        println(readtag)
        @Assert(readtag,6)
    }

    @TestCase
    func asn_Asn1InputStream7(): Unit {
        var buffer: Array<Byte> = [0x05, 0x01, 0x0]
        var byteArrayStream: ByteBuffer = ByteBuffer()
        byteArrayStream.write(buffer)
        var asn1inputstream: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream)
        var readtag = asn1inputstream.readTag().getTag()
        println(readtag)
        @Assert(readtag,5)
    }

    @TestCase
    func asn_Asn1InputStream8(): Unit {
        try {
            var buffer: Array<Byte> = [0x15, 0x01, 0x0]
            var byteArrayStream: ByteBuffer = ByteBuffer()
            byteArrayStream.write(buffer)
            var asn1inputstream: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream)
            var readtag = asn1inputstream.readTag().getTag()
            println(readtag)
            @Assert(readtag,10)
        } catch (e: Exception) {
            @Assert(e.toString(),"Exception: Unknown ASN.1 tag")
        }
    }
}
