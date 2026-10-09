// 3rd_party_lib:asnone4cj/target/release/asn1

import std.io.*
import asn1.*
import std.collection.*

@Test
public class asn_Asn1OutputStream01 {
    @TestCase
    func asn_Asn1OutputStream_01(): Unit { //class ASN1Boolean

        var returnFlag: Int64 = 0
        try {
            let decodetd: DEREncoder = DEREncoder()
            var output = ByteBuffer()
            var asn1OutputStream: ASN1OutputStream = ASN1OutputStream(decodetd, output)
            var bool = ASN1Boolean(false)
            asn1OutputStream.writeObject(bool)
            var buffer: Array<Byte> = [0x51, 0x02, 0x04, 0x06, 0x10, 0x01, 0x03, 0x05, 0x07, 0x11]
            asn1OutputStream.write(buffer)
            asn1OutputStream.write(10)
        } catch (e: Exception) {
            returnFlag = -1
            @Assert(returnFlag,0)
        }
    }

    @TestCase
    func asn_Asn1OutputStream_02(): Unit { //class ASN1Boolean

        var returnFlag: Int64 = 0
        try {
            let decodetd: DEREncoder = DEREncoder()
            var output = ByteBuffer()
            var asn1OutputStream: ASN1OutputStream = ASN1OutputStream(decodetd, output)
            var bool = ASN1Boolean(false)
            asn1OutputStream.writeObject(bool)
            var buffer: Array<Byte> = [0x01, 0x08, 0x04, 0x06, 0x10, 0x01, 0x03, 0x05, 0x07, 0x11]
            asn1OutputStream.write(buffer)
            asn1OutputStream.write(10)
        } catch (e: Exception) {
            returnFlag = -1
            @Assert(returnFlag,0)
        }
    }

    @TestCase
    func asn_Asn1OutputStream_03(): Unit { //class ASN1Boolean

        try {
            let decodetd: DEREncoder = DEREncoder()
            var output = ByteBuffer()
            var asn1OutputStream: ASN1OutputStream = ASN1OutputStream(decodetd, output)
            asn1OutputStream.write(-2)
        } catch (e: Exception) {
            @Assert(e.toString(),"OverflowException: typecast")
        }
    }

    @TestCase
    func asn_Asn1OutputStream_04(): Unit { //class ASN1Boolean

        var returnFlag: Int64 = 0
        try {
            let decodetd: DEREncoder = DEREncoder()
            var output = ByteBuffer()
            var asn1OutputStream: ASN1OutputStream = ASN1OutputStream(decodetd, output)
            var bool = ASN1Boolean(false)
            asn1OutputStream.writeObject(bool)
            var buffer: Array<Byte> = [0x01, 0x08, 0x04, 0x06, 0x10, 0x01, 0x03, 0x05, 0x07, 0x11]
            asn1OutputStream.write(buffer)
            asn1OutputStream.write(6)
        } catch (e: Exception) {
            returnFlag = -1
            @Assert(returnFlag,0)
        }
    }

    @TestCase
    func asn_Asn1OutputStream_05(): Unit { //class ASN1Boolean

        var returnFlag: Int64 = 0
        try {
            let decodetd: DEREncoder = DEREncoder()
            var output = ByteBuffer()
            var asn1OutputStream: ASN1OutputStream = ASN1OutputStream(decodetd, output)
            var bool = ASN1Boolean(false)
            asn1OutputStream.writeObject(bool)
            var buffer: Array<Byte> = []
            asn1OutputStream.write(buffer)
            asn1OutputStream.write(10)
        } catch (e: Exception) {
            returnFlag = -1
            @Assert(returnFlag,0)
        }
    }

    @TestCase
    func asn_Asn1OutputStream_06(): Unit { //class ASN1Set

        var returnFlag: Int64 = 0
        try {
            let decodetd: DEREncoder = DEREncoder()
            var output = ByteBuffer()
            var asn1OutputStream: ASN1OutputStream = ASN1OutputStream(decodetd, output)
            var arr = HashSet<ASN1Object>()
            var asn1set: ASN1Set = ASN1Set(arr)
            asn1OutputStream.writeObject(asn1set)
            var buffer: Array<Byte> = []
            asn1OutputStream.write(buffer)
            asn1OutputStream.write(10)
        } catch (e: Exception) {
            returnFlag = -1
            @Assert(returnFlag,0)
        }
    }

    @TestCase
    func asn_Asn1OutputStream_07(): Unit { //class ASN1Set

        var returnFlag: Int64 = 0
        try {
            let decodetd: DEREncoder = DEREncoder()
            var output = ByteBuffer()
            var asn1OutputStream: ASN1OutputStream = ASN1OutputStream(decodetd, output)
            var arr: HashSet<ASN1Object> = HashSet<ASN1Object>(
                [ASN1Boolean(true), ASN1Integer(1), ASN1Boolean(false), ASN1Integer(2)])
            var asn1set: ASN1Set = ASN1Set(arr)
            asn1OutputStream.writeObject(asn1set)
            var buffer: Array<Byte> = [0x51, 0x02, 0x04, 0x06, 0x10, 0x01, 0x03, 0x05, 0x07, 0x11]
            asn1OutputStream.write(buffer)
            asn1OutputStream.write(10)
        } catch (e: Exception) {
            returnFlag = -1
            @Assert(returnFlag,0)
        }
    }

    @TestCase
    func asn_Asn1OutputStream_08(): Unit { //class ASN1Set

        var returnFlag: Int64 = 0
        try {
            let decodetd: DEREncoder = DEREncoder()
            var output = ByteBuffer()
            var asn1OutputStream: ASN1OutputStream = ASN1OutputStream(decodetd, output)
            var arr: HashSet<ASN1Object> = HashSet<ASN1Object>(
                [ASN1Boolean(true), ASN1Integer(1), ASN1Boolean(false), ASN1Integer(2)])
            var asn1set: ASN1Set = ASN1Set(arr)
            asn1OutputStream.writeObject(asn1set)
            var buffer: Array<Byte> = [0x11, 0x08, 0x04, 0x06, 0x10, 0x01, 0x03, 0x05, 0x07, 0x11]
            asn1OutputStream.write(buffer)
            asn1OutputStream.write(10)
        } catch (e: Exception) {
            returnFlag = -1
            @Assert(returnFlag,0)
        }
    }

    @TestCase
    func asn_Asn1OutputStream_09(): Unit { //class ASN1Integer

        var returnFlag: Int64 = 0
        try {
            let decodetd: DEREncoder = DEREncoder()
            var output = ByteBuffer()
            var asn1OutputStream: ASN1OutputStream = ASN1OutputStream(decodetd, output)
            var asn1integer: ASN1Integer = ASN1Integer(10)
            asn1OutputStream.writeObject(asn1integer)
            var buffer: Array<Byte> = [0x10, 0x08, 0x04, 0x06, 0x10, 0x01, 0x03, 0x05, 0x07, 0x11]
            asn1OutputStream.write(buffer)
            asn1OutputStream.write(10)
        } catch (e: Exception) {
            returnFlag = -1
            @Assert(returnFlag,0)
        }
    }

    @TestCase
    func asn_Asn1OutputStream_10(): Unit { //class ASN1Integer

        var returnFlag: Int64 = 0
        try {
            let decodetd: DEREncoder = DEREncoder()
            var output = ByteBuffer()
            var asn1OutputStream: ASN1OutputStream = ASN1OutputStream(decodetd, output)
            var asn1integer: ASN1Integer = ASN1Integer(0)
            asn1OutputStream.writeObject(asn1integer)
            var buffer: Array<Byte> = [0x02, 0x08, 0x04, 0x06, 0x10, 0x01, 0x03, 0x05, 0x07, 0x11]
            asn1OutputStream.write(buffer)
            asn1OutputStream.write(6)
        } catch (e: Exception) {
            returnFlag = -1
            @Assert(returnFlag,0)
        }
    }

    @TestCase
    func asn_Asn1OutputStream_11(): Unit { //class ASN1Integer

        var returnFlag: Int64 = 0
        try {
            let decodetd: DEREncoder = DEREncoder()
            var output = ByteBuffer()
            var asn1OutputStream: ASN1OutputStream = ASN1OutputStream(decodetd, output)
            var asn1integer: ASN1Integer = ASN1Integer(0)
            asn1OutputStream.writeObject(asn1integer)
            var buffer: Array<Byte> = []
            asn1OutputStream.write(buffer)
            asn1OutputStream.write(6)
        } catch (e: Exception) {
            returnFlag = -1
            @Assert(returnFlag,0)
        }
    }

    @TestCase
    func asn_Asn1OutputStream_12(): Unit { //class ASN1Null

        var returnFlag: Int64 = 0
        try {
            let decodetd: DEREncoder = DEREncoder()
            var output = ByteBuffer()
            var asn1OutputStream: ASN1OutputStream = ASN1OutputStream(decodetd, output)
            var asn1null: ASN1Null = ASN1Null()
            asn1OutputStream.writeObject(asn1null)
            var buffer: Array<Byte> = [0x02, 0x08, 0x04, 0x06, 0x10, 0x01, 0x03, 0x05, 0x07, 0x11]
            asn1OutputStream.write(buffer)
            asn1OutputStream.write(6)
        } catch (e: Exception) {
            returnFlag = -1
            @Assert(returnFlag,0)
        }
    }

    @TestCase
    func asn_Asn1OutputStream_13(): Unit { //class ASN1Null

        var returnFlag: Int64 = 0
        try {
            let decodetd: DEREncoder = DEREncoder()
            var output = ByteBuffer()
            var asn1OutputStream: ASN1OutputStream = ASN1OutputStream(decodetd, output)
            var asn1null: ASN1Null = ASN1Null()
            asn1OutputStream.writeObject(asn1null)
            var buffer: Array<Byte> = [0x05, 0x08, 0x04, 0x06, 0x10, 0x01, 0x03, 0x05, 0x07, 0x11]
            asn1OutputStream.write(buffer)
            asn1OutputStream.write(6)
        } catch (e: Exception) {
            returnFlag = -1
            @Assert(returnFlag,0)
        }
    }

    @TestCase
    func asn_Asn1OutputStream_14(): Unit { //class ASN1Null

        var returnFlag: Int64 = 0
        try {
            let decodetd: DEREncoder = DEREncoder()
            var output = ByteBuffer()
            var asn1OutputStream: ASN1OutputStream = ASN1OutputStream(decodetd, output)
            var asn1null: ASN1Null = ASN1Null()
            asn1OutputStream.writeObject(asn1null)
            var buffer: Array<Byte> = []
            asn1OutputStream.write(buffer)
            asn1OutputStream.write(6)
        } catch (e: Exception) {
            returnFlag = -1
            @Assert(returnFlag,0)
        }
    }

    @TestCase
    func asn_Asn1OutputStream_15(): Unit { //class ASN1ObjectIdentifier

        var returnFlag: Int64 = 0
        try {
            let decodetd: DEREncoder = DEREncoder()
            var output = ByteBuffer()
            var asn1OutputStream: ASN1OutputStream = ASN1OutputStream(decodetd, output)
            var asn1dentifier: ASN1ObjectIdentifier = ASN1ObjectIdentifier("1.3.4")
            asn1OutputStream.writeObject(asn1dentifier)
            var buffer: Array<Byte> = [0x06, 0x08, 0x04, 0x06, 0x10, 0x01, 0x03, 0x05, 0x07, 0x11]
            asn1OutputStream.write(buffer)
            asn1OutputStream.write(6)
        } catch (e: Exception) {
            returnFlag = -1
            @Assert(returnFlag,0)
        }
    }

    @TestCase
    func asn_Asn1OutputStream_16(): Unit { //class ASN1ObjectIdentifier

        try {
            let decodetd: DEREncoder = DEREncoder()
            var output = ByteBuffer()
            var asn1OutputStream: ASN1OutputStream = ASN1OutputStream(decodetd, output)
            var asn1dentifier: ASN1ObjectIdentifier = ASN1ObjectIdentifier("")
            asn1OutputStream.writeObject(asn1dentifier)
            var buffer: Array<Byte> = []
            asn1OutputStream.write(buffer)
            asn1OutputStream.write(6)
        } catch (e: Exception) {
            @Assert(e.toString(),"IndexOutOfBoundsException: The length of the array is 0, but the index is 0.")
        }
    }

    @TestCase
    func asn_Asn1OutputStream_17(): Unit { //class ASN1ObjectIdentifier

        var returnFlag: Int64 = 0
        try {
            let decodetd: DEREncoder = DEREncoder()
            var output = ByteBuffer()
            var asn1OutputStream: ASN1OutputStream = ASN1OutputStream(decodetd, output)
            var asn1dentifier: ASN1ObjectIdentifier = ASN1ObjectIdentifier("1.3.4.51.51.67")
            asn1OutputStream.writeObject(asn1dentifier)
            var buffer: Array<Byte> = [0x06, 0x08, 0x04, 0x06, 0x10, 0x01, 0x03, 0x05, 0x07, 0x11]
            asn1OutputStream.write(buffer)
            asn1OutputStream.write(20)
        } catch (e: Exception) {
            returnFlag = -1
            @Assert(returnFlag,0)
        }
    }

    @TestCase
    func asn_Asn1OutputStream_18(): Unit { //class ASN1Sequence

        var returnFlag: Int64 = 0
        try {
            let decodetd: DEREncoder = DEREncoder()
            var output = ByteBuffer()
            var asn1OutputStream: ASN1OutputStream = ASN1OutputStream(decodetd, output)
            var arr = ArrayList<ASN1Object>([ASN1Boolean(true), ASN1Integer(1), ASN1Boolean(false), ASN1Integer(2)])
            var asn1sequence: ASN1Sequence = ASN1Sequence(arr)
            asn1OutputStream.writeObject(asn1sequence)
            var buffer: Array<Byte> = [0x06, 0x08, 0x04, 0x06, 0x10, 0x01, 0x03, 0x05, 0x07, 0x11]
            asn1OutputStream.write(buffer)
            asn1OutputStream.write(20)
        } catch (e: Exception) {
            returnFlag = -1
            @Assert(returnFlag,0)
        }
    }

    @TestCase
    func asn_Asn1OutputStream_19(): Unit { //class ASN1Enumerated

        var returnFlag: Int64 = 0
        try {
            let decodetd: DEREncoder = DEREncoder()
            var output = ByteBuffer()
            var asn1OutputStream: ASN1OutputStream = ASN1OutputStream(decodetd, output)
            var asn1enumerated: ASN1Enumerated = ASN1Enumerated(0)
            asn1OutputStream.writeObject(asn1enumerated)
            var buffer: Array<Byte> = [0x0A, 0x08, 0x04, 0x06, 0x10, 0x01, 0x03, 0x05, 0x07, 0x11]
            asn1OutputStream.write(buffer)
            asn1OutputStream.write(20)
        } catch (e: Exception) {
            returnFlag = -1
            @Assert(returnFlag,0)
        }
    }

    @TestCase
    func asn_Asn1OutputStream_20(): Unit { //class ASN1Enumerated

        var returnFlag: Int64 = 0
        try {
            let decodetd: DEREncoder = DEREncoder()
            var output = ByteBuffer()
            var asn1OutputStream: ASN1OutputStream = ASN1OutputStream(decodetd, output)
            var asn1enumerated: ASN1Enumerated = ASN1Enumerated(999)
            asn1OutputStream.writeObject(asn1enumerated)
            var buffer: Array<Byte> = [0x01, 0x08, 0x04, 0x06, 0x10, 0x01, 0x03, 0x05, 0x07, 0x11]
            asn1OutputStream.write(buffer)
            asn1OutputStream.write(20)
        } catch (e: Exception) {
            returnFlag = -1
            @Assert(returnFlag,0)
        }
    }
}
