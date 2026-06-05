// 3rd_party_lib:asnone4cj/target/release/asn1

import std.io.*
import asn1.*
import std.collection.*

@Test
public class asn_Asn1InputStream01 {
    @TestCase
    func asn_Asn1InputStream01(): Unit {
        var buffer: Array<Byte> = [0x01, 0x01, 0x1]
        var byteArrayStream: ByteBuffer = ByteBuffer()
        byteArrayStream.write(buffer)
        var asn1inputstream: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream)
        var readvalue = asn1inputstream.readValue(2)
        println(readvalue)
        var readlength = asn1inputstream.readLength()
        println(readlength)
        var buffer2: Array<Byte> = [1, 1]
        @Assert(readvalue,buffer2)
        @Assert(readlength,1)
    }

    @TestCase
    func asn_Asn1InputStream02(): Unit {
        var buffer: Array<Byte> = [0x01, 0x01, 0x1]
        var byteArrayStream: ByteBuffer = ByteBuffer()
        byteArrayStream.write(buffer)
        var asn1inputstream: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream)
        var buffer1: Array<Byte> = [0x01, 0x08, 0x04, 0x06, 0x10, 0x01, 0x03, 0x05, 0x07, 0x11]
        var read = asn1inputstream.read(buffer1)
        println(read)
        @Assert(read,3)
    }

    @TestCase
    func asn_Asn1InputStream03(): Unit {
        var buffer: Array<Byte> = [0x01, 0x08]
        var byteArrayStream: ByteBuffer = ByteBuffer()
        byteArrayStream.write(buffer)
        var asn1inputstream: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream)
        var readvalue = asn1inputstream.readValue(10)
        println(readvalue)
        var readlength = asn1inputstream.readLength()
        println(readlength)
        var buffer2: Array<Byte> = [1, 8, 0, 0, 0, 0, 0, 0, 0, 0]
        @Assert(readvalue,buffer2)
        @Assert(readlength,0)
    }

    @TestCase
    func asn_Asn1InputStream04(): Unit {
        var buffer: Array<Byte> = [0x09, 0x08, 0x03, 0x06, 0x10, 0x01]
        var byteArrayStream: ByteBuffer = ByteBuffer()
        byteArrayStream.write(buffer)
        var asn1inputstream: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream)
        var readvalue = asn1inputstream.readValue(0)
        println(readvalue)
        var readlength = asn1inputstream.readLength()
        println(readlength)
        var buffer1: Array<Byte> = [0x01, 0x08, 0x04, 0x06, 0x10, 0x01, 0x03, 0x05, 0x07, 0x11]
        var read = asn1inputstream.read(buffer1)
        println(read)
        var buffer2: Array<Byte> = []
        @Assert(readvalue,buffer2)
        @Assert(readlength,9)
        @Assert(read,5)
    }

    @TestCase
    func asn_Asn1InputStream05(): Unit {
        var buffer: Array<Byte> = []
        var byteArrayStream: ByteBuffer = ByteBuffer()
        byteArrayStream.write(buffer)
        var asn1inputstream: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream)
        var readvalue = asn1inputstream.readValue(10)
        println(readvalue)
        var readlength = asn1inputstream.readLength()
        println(readlength)
        var buffer1: Array<Byte> = [0x01, 0x08, 0x04, 0x06, 0x10, 0x01, 0x03, 0x05, 0x07, 0x11]
        var read = asn1inputstream.read(buffer1)
        println(read)
        var buffer2: Array<Byte> = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        @Assert(readvalue,buffer2)
        @Assert(readlength,0)
        @Assert(read,0)
    }

    @TestCase
    func asn_Asn1InputStream06(): Unit { //readValue

        try {
            var buffer: Array<Byte> = [0x01, 0x01, 0x0]
            var byteArrayStream: ByteBuffer = ByteBuffer()
            byteArrayStream.write(buffer)
            var asn1inputstream: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream)
            var readvalue = asn1inputstream.readValue(-8)
            println(readvalue)
            var readlength = asn1inputstream.readLength()
            println(readlength)
            var buffer1: Array<Byte> = [0x01, 0x08, 0x04, 0x06, 0x10, 0x01, 0x03, 0x05, 0x07, 0x11]
            var read = asn1inputstream.read(buffer1)
            println(read)
            var buffer2: Array<Byte> = []
            @Assert(readvalue,buffer2)
            @Assert(readlength,1)
            @Assert(read,2)
        } catch (e: Exception) {
            @Assert(e.toString(),"NegativeArraySizeException")
        }
    }

    @TestCase
    func asn_Asn1InputStream07(): Unit { //readValue

        var buffer: Array<Byte> = [0x01, 0x01, 0x0]
        var byteArrayStream: ByteBuffer = ByteBuffer()
        byteArrayStream.write(buffer)
        var asn1inputstream: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream)
        var readvalue = asn1inputstream.readValue(0)
        println(readvalue)
        var readlength = asn1inputstream.readLength()
        println(readlength)
        var buffer1: Array<Byte> = [0x01, 0x08, 0x04, 0x06, 0x10, 0x01, 0x03, 0x05, 0x07, 0x11]
        var read = asn1inputstream.read(buffer1)
        println(read)
        var buffer2: Array<Byte> = []
        @Assert(readvalue,buffer2)
        @Assert(readlength,1)
        @Assert(read,2)
    }

    @TestCase
    func asn_Asn1InputStream08(): Unit {
        var buffer: Array<Byte> = [0x01, 0x01, 0x0]
        var byteArrayStream: ByteBuffer = ByteBuffer()
        byteArrayStream.write(buffer)
        var asn1inputstream: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream)
        var readvalue = asn1inputstream.readValue(0)
        println(readvalue)
        var readlength = asn1inputstream.readLength()
        println(readlength)
        var buffer1: Array<Byte> = [0x01, 0x08, 0x00]
        var read = asn1inputstream.read(buffer1)
        println(read)
        var buffer2: Array<Byte> = []
        @Assert(readvalue,buffer2)
        @Assert(readlength,1)
        @Assert(read,2)
    }

    @TestCase
    func asn_Asn1InputStream09(): Unit {
        try {
            var buffer: Array<Byte> = [0x01, 0x01, 0x0]
            var byteArrayStream: ByteBuffer = ByteBuffer()
            byteArrayStream.write(buffer)
            var asn1inputstream: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream)
            var readvalue = asn1inputstream.readValue(0)
            println(readvalue)
            var readlength = asn1inputstream.readLength()
            println(readlength)
            var buffer1: Array<Byte> = []
            asn1inputstream.read(buffer1)
        } catch (e: Exception) {
            @Assert(e.toString(),"IllegalArgumentException: The buffer is empty.")
        }
    }

    @TestCase
    func asn_Asn1InputStream10(): Unit {
        var buffer: Array<Byte> = [0x01, 0x01, 0x0]
        var byteArrayStream: ByteBuffer = ByteBuffer()
        byteArrayStream.write(buffer)
        var asn1inputstream: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream)
        var readvalue = asn1inputstream.readValue(0)
        println(readvalue)
        var readlength = asn1inputstream.readLength()
        println(readlength)
        var buffer1: Array<Byte> = [0x056, 0x08, 0x02]
        var read = asn1inputstream.read(buffer1)
        println(read)
        var buffer2: Array<Byte> = []
        @Assert(readvalue,buffer2)
        @Assert(readlength,1)
        @Assert(read,2)
    }

    @TestCase
    func asn_Asn1InputStream11(): Unit {
        var buffer: Array<Byte> = [0x01, 0x01, 0x0]
        var asn1inputstream: ASN1InputStream = ASN1InputStream(BERDecoder(), buffer)
        var readvalue = asn1inputstream.readValue(0)
        println(readvalue)
        var readlength = asn1inputstream.readLength()
        println(readlength)
        var buffer1: Array<Byte> = [0x056, 0x08, 0x02]
        var read = asn1inputstream.read(buffer1)
        println(read)
        var buffer2: Array<Byte> = []
        @Assert(readvalue,buffer2)
        @Assert(readlength,1)
        @Assert(read,2)
    }

    @TestCase
    func asn_Asn1InputStream12(): Unit {
        var buffer: Array<Byte> = [0x01, 0x01, 0x0]
        var asn1inputstream: ASN1InputStream = ASN1InputStream(BERDecoder(), buffer)
        var readvalue = asn1inputstream.readValue(0)
        println(readvalue)
        var readlength = asn1inputstream.readLength()
        println(readlength)
        var buffer1: Array<Byte> = [0x056, 0x08, 0x02]
        var read = asn1inputstream.read(buffer1)
        println(read)
        var buffer2: Array<Byte> = []
        @Assert(readvalue,buffer2)
        @Assert(readlength,1)
        @Assert(read,2)
    }
}
