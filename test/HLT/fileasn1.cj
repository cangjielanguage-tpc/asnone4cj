// 3rd_party_lib:asn-one/build/asn1
//data_file:file/encoded_tc1.ber:file/encoded_tc2.ber:file/encoded_tc3.ber:file/encoded_tc4.ber:file/encoded_tc5.ber:file/encoded_tc6.ber:file/encoded_tc7.ber:file/encoded_tc8.ber:file/encoded_tc9.ber:file/encoded_tc10.ber
//data_file:file/encoded_tc11.ber:file/encoded_tc12.ber:file/encoded_tc13.ber:file/encoded_tc14.ber:file/encoded_tc15.ber:file/encoded_tc16.ber:file/encoded_tc17.ber:file/encoded_tc18.ber:file/encoded_tc19.ber:file/encoded_tc20.ber
//data_file:file/encoded_tc21.ber:file/encoded_tc22.ber:file/encoded_tc23.ber:file/encoded_tc24.ber:file/encoded_tc25.ber:file/encoded_tc26.ber:file/encoded_tc27.ber:file/encoded_tc28.ber:file/encoded_tc29.ber:file/encoded_tc30.ber
//data_file:file/encoded_tc31.ber:file/encoded_tc32.ber:file/encoded_tc33.ber:file/encoded_tc34.ber:file/encoded_tc35.ber:file/encoded_tc36.ber:file/encoded_tc37.ber:file/encoded_tc38.ber:file/encoded_tc39.ber:file/encoded_tc40.ber
//data_file:file/encoded_tc41.ber:file/encoded_tc42.ber:file/encoded_tc43.ber:file/encoded_tc44.ber:file/encoded_tc45.ber:file/encoded_tc46.ber:file/encoded_tc47.ber:file/encoded_tc48.ber
//data_file:file/tc1.ber:file/tc2.ber:file/tc3.ber:file/tc4.ber:file/tc5.ber:file/tc6.ber:file/tc7.ber:file/tc8.ber:file/tc9.ber:file/tc10.ber
//data_file:file/tc11.ber:file/tc12.ber:file/tc13.ber:file/tc14.ber:file/tc15.ber:file/tc16.ber:file/tc17.ber:file/tc18.ber:file/tc19.ber:file/tc20.ber
//data_file:file/tc21.ber:file/tc22.ber:file/tc23.ber:file/tc24.ber:file/tc25.ber:file/tc26.ber:file/tc27.ber:file/tc28.ber:file/tc29.ber:file/tc30.ber
//data_file:file/tc31.ber:file/tc32.ber:file/tc33.ber:file/tc34.ber:file/tc35.ber:file/tc36.ber:file/tc37.ber:file/tc38.ber:file/tc39.ber:file/tc40.ber
//data_file:file/tc41.ber:file/tc42.ber:file/tc43.ber:file/tc44.ber:file/tc45.ber:file/tc46.ber:file/tc47.ber:file/tc48.ber
from asn1 import asn1.EnumeratedSerializer
from asn1 import asn1.BERDecoder
from asn1 import asn1.ASN1Tag
from asn1 import asn1.ASN1Null
from asn1 import asn1.ASN1Integer
from asn1 import asn1.NullSerializer
from asn1 import asn1.IntegerSerializer
from asn1 import asn1.BooleanParser
from asn1 import asn1.ASN1OutputStream
from asn1 import asn1.encodingrules.der.DEREncoder
from asn1 import asn1.ASN1TaggedObject
from std import io.*
from asn1 import asn1.ASN1ParseException
from asn1 import asn1.ASN1Object
from asn1 import asn1.ASN1Sequence
from asn1 import asn1.BitStringParser
from asn1 import asn1.*
from asn1 import asn1.types.*
from asn1 import asn1.util.*
from asn1 import asn1.encodingrules.*
from asn1 import asn1.encodingrules.der.*
from std import collection.*
from std import os.posix.*
from std import fs.*
from encoding import json.*
from std import unittest.*
from std import unittest.testmacro.*
@Test
public class asn_Asn1OutputStream01{    


    @TestCase
    func AsnOne1(): Unit {
            let pathname1: String = "file/encoded_tc2.ber"
            println(pathname1)
            var fs1: File = File(pathname1, Open(true, true))
            var res1: Array<Byte> = fs1.readToEnd()
            println(res1)
            let decodetd: DEREncoder = DEREncoder()
            //var res1: Array<Byte> = [2,1]
            var byteArrayStream: ByteArrayStream = ByteArrayStream()
            byteArrayStream.write(res1)
            var asn1inputstream:ASN1InputStream=ASN1InputStream(BERDecoder(),byteArrayStream)
            println(asn1inputstream.readLength())
            @Assert(asn1inputstream.readLength(),0)
    }

    @TestCase
    func AsnOne2(): Unit {

            let pathname1: String = "file/encoded_tc3.ber"
            println(pathname1)
            var fs1: File = File(pathname1, Open(true, true))
            var res1: Array<Byte> = fs1.readToEnd()
            println(res1)
            let decodetd: DEREncoder = DEREncoder()
            var byteArrayStream: ByteArrayStream = ByteArrayStream()
            byteArrayStream.write(res1)
            var asn1inputstream:ASN1InputStream=ASN1InputStream(BERDecoder(),byteArrayStream)
            println(asn1inputstream.readLength())
            @Assert(asn1inputstream.readLength(),0)
    }


    @TestCase
    func AsnOne3(): Unit {

            let pathname1: String = "file/encoded_tc3.ber"
            println(pathname1)
            var fs1: File = File(pathname1, Open(true, true))
            var res1: Array<Byte> = fs1.readToEnd()
            println(res1)
            let decodetd: DEREncoder = DEREncoder()
            var byteArrayStream: ByteArrayStream = ByteArrayStream()
            byteArrayStream.write(res1)
            var asn1inputstream:ASN1InputStream=ASN1InputStream(BERDecoder(),byteArrayStream)
            println(asn1inputstream.readLength())
            @Assert(asn1inputstream.readLength(),0)
    }

    @TestCase
    func AsnOne4(): Unit {

            let pathname1: String = "file/encoded_tc4.ber"
            println(pathname1)
            var fs1: File = File(pathname1, Open(true, true))
            var res1: Array<Byte> = fs1.readToEnd()
            println(res1)
            let decodetd: DEREncoder = DEREncoder()
            var byteArrayStream: ByteArrayStream = ByteArrayStream()
            byteArrayStream.write(res1)
            var asn1inputstream:ASN1InputStream=ASN1InputStream(BERDecoder(),byteArrayStream)
            println(asn1inputstream.readLength())
            @Assert(asn1inputstream.readLength(),0)
    }


    @TestCase
    func AsnOne5(): Unit {

            let pathname1: String = "file/encoded_tc6.ber"
            println(pathname1)
            var fs1: File = File(pathname1, Open(true, true))
            var res1: Array<Byte> = fs1.readToEnd()
            println(res1)
            let decodetd: DEREncoder = DEREncoder()
            var byteArrayStream: ByteArrayStream = ByteArrayStream()
            byteArrayStream.write(res1)
            var asn1inputstream:ASN1InputStream=ASN1InputStream(BERDecoder(),byteArrayStream)
            @Assert(asn1inputstream.readLength(),9)
    }
 

    @TestCase
    func AsnOne6(): Unit {

            let pathname1: String = "file/encoded_tc7.ber"
            println(pathname1)
            var fs1: File = File(pathname1, Open(true, true))
            var res1: Array<Byte> = fs1.readToEnd()
            println(res1)
            let decodetd: DEREncoder = DEREncoder()
            var byteArrayStream: ByteArrayStream = ByteArrayStream()
            byteArrayStream.write(res1)
            var asn1inputstream:ASN1InputStream=ASN1InputStream(BERDecoder(),byteArrayStream)
            @Assert(asn1inputstream.readLength(),9)
    }


    @TestCase
    func AsnOne7(): Unit {

            let pathname1: String = "file/encoded_tc8.ber"
            println(pathname1)
            var fs1: File = File(pathname1, Open(true, true))
            var res1: Array<Byte> = fs1.readToEnd()
            println(res1)
            let decodetd: DEREncoder = DEREncoder()
            var byteArrayStream: ByteArrayStream = ByteArrayStream()
            byteArrayStream.write(res1)
            var asn1inputstream:ASN1InputStream=ASN1InputStream(BERDecoder(),byteArrayStream)
            var leng=asn1inputstream.readLength()
            println(leng)
            @Assert(leng,9)
    }


    @TestCase
    func AsnOne8(): Unit {

            let pathname1: String = "file/encoded_tc9.ber"
            println(pathname1)
            var fs1: File = File(pathname1, Open(true, true))
            var res1: Array<Byte> = fs1.readToEnd()
            println(res1)
            let decodetd: DEREncoder = DEREncoder()
            var byteArrayStream: ByteArrayStream = ByteArrayStream()
            byteArrayStream.write(res1)
            var asn1inputstream:ASN1InputStream=ASN1InputStream(BERDecoder(),byteArrayStream)
            var leng=asn1inputstream.readLength()
            println(leng)
            @Assert(leng,9)
    }



    @TestCase
    func AsnOne9(): Unit {

            let pathname1: String = "file/encoded_tc11.ber"
            println(pathname1)
            var fs1: File = File(pathname1, Open(true, true))
            var res1: Array<Byte> = fs1.readToEnd()
            println(res1)
            let decodetd: DEREncoder = DEREncoder()
            var byteArrayStream: ByteArrayStream = ByteArrayStream()
            byteArrayStream.write(res1)
            var asn1inputstream:ASN1InputStream=ASN1InputStream(BERDecoder(),byteArrayStream)
            var leng=asn1inputstream.readLength()
            println(leng)
            @Assert(leng,9)
    }


    @TestCase
    func AsnOne10(): Unit {

            let pathname1: String = "file/encoded_tc12.ber"
            println(pathname1)
            var fs1: File = File(pathname1, Open(true, true))
            var res1: Array<Byte> = fs1.readToEnd()
            println(res1)
            let decodetd: DEREncoder = DEREncoder()
            var byteArrayStream: ByteArrayStream = ByteArrayStream()
            byteArrayStream.write(res1)
            var asn1inputstream:ASN1InputStream=ASN1InputStream(BERDecoder(),byteArrayStream)
            var leng=asn1inputstream.readLength()
            println(leng)
            @Assert(leng,9)
    }


    @TestCase
    func AsnOne11(): Unit {

            let pathname1: String = "file/encoded_tc19.ber"
            println(pathname1)
            var fs1: File = File(pathname1, Open(true, true))
            var res1: Array<Byte> = fs1.readToEnd()
            println(res1)
            let decodetd: DEREncoder = DEREncoder()
            var byteArrayStream: ByteArrayStream = ByteArrayStream()
            byteArrayStream.write(res1)
            var asn1inputstream:ASN1InputStream=ASN1InputStream(BERDecoder(),byteArrayStream)
            var leng=asn1inputstream.readLength()
            println(leng)
            @Assert(leng,2)
    }


    @TestCase
    func AsnOne12(): Unit {

            let pathname1: String = "file/encoded_tc21.ber"
            println(pathname1)
            var fs1: File = File(pathname1, Open(true, true))
            var res1: Array<Byte> = fs1.readToEnd()
            println(res1)
            let decodetd: DEREncoder = DEREncoder()
            var byteArrayStream: ByteArrayStream = ByteArrayStream()
            byteArrayStream.write(res1)
            var asn1inputstream:ASN1InputStream=ASN1InputStream(BERDecoder(),byteArrayStream)
            var leng=asn1inputstream.readLength()
            println(leng)
            @Assert(leng,6)
    }


    @TestCase
    func AsnOne13(): Unit {

            let pathname1: String = "file/encoded_tc23.ber"
            println(pathname1)
            var fs1: File = File(pathname1, Open(true, true))
            var res1: Array<Byte> = fs1.readToEnd()
            println(res1)
            let decodetd: DEREncoder = DEREncoder()
            var byteArrayStream: ByteArrayStream = ByteArrayStream()
            byteArrayStream.write(res1)
            var asn1inputstream:ASN1InputStream=ASN1InputStream(BERDecoder(),byteArrayStream)
            var leng=asn1inputstream.readLength()
            println(leng)
            @Assert(leng,6)
    }


    @TestCase
    func AsnOne14(): Unit {

            let pathname1: String = "file/encoded_tc25.ber"
            println(pathname1)
            var fs1: File = File(pathname1, Open(true, true))
            var res1: Array<Byte> = fs1.readToEnd()
            println(res1)
            let decodetd: DEREncoder = DEREncoder()
            var byteArrayStream: ByteArrayStream = ByteArrayStream()
            byteArrayStream.write(res1)
            var asn1inputstream:ASN1InputStream=ASN1InputStream(BERDecoder(),byteArrayStream)
            var leng=asn1inputstream.readLength()
            println(leng)
            @Assert(leng,1)
    }

    @TestCase
    func AsnOne15(): Unit {

            let pathname1: String = "file/encoded_tc26.ber"
            println(pathname1)
            var fs1: File = File(pathname1, Open(true, true))
            var res1: Array<Byte> = fs1.readToEnd()
            println(res1)
            let decodetd: DEREncoder = DEREncoder()
            var byteArrayStream: ByteArrayStream = ByteArrayStream()
            byteArrayStream.write(res1)
            var asn1inputstream:ASN1InputStream=ASN1InputStream(BERDecoder(),byteArrayStream)
            var leng=asn1inputstream.readLength()
            println(leng)
            @Assert(leng,1)
    }


    @TestCase
    func AsnOne16(): Unit {

            let pathname1: String = "file/encoded_tc27.ber"
            println(pathname1)
            var fs1: File = File(pathname1, Open(true, true))
            var res1: Array<Byte> = fs1.readToEnd()
            println(res1)
            let decodetd: DEREncoder = DEREncoder()
            var byteArrayStream: ByteArrayStream = ByteArrayStream()
            byteArrayStream.write(res1)
            var asn1inputstream:ASN1InputStream=ASN1InputStream(BERDecoder(),byteArrayStream)
            var leng=asn1inputstream.readLength()
            println(leng)
            @Assert(leng,1)
    }


    @TestCase
    func AsnOne17(): Unit {

            let pathname1: String = "file/encoded_tc29.ber"
            println(pathname1)
            var fs1: File = File(pathname1, Open(true, true))
            var res1: Array<Byte> = fs1.readToEnd()
            println(res1)
            let decodetd: DEREncoder = DEREncoder()
            var byteArrayStream: ByteArrayStream = ByteArrayStream()
            byteArrayStream.write(res1)
            var asn1inputstream:ASN1InputStream=ASN1InputStream(BERDecoder(),byteArrayStream)
            var leng=asn1inputstream.readLength()
            println(leng)
            @Assert(leng,1)
    }


    @TestCase
    func AsnOne18(): Unit {

            let pathname1: String = "file/encoded_tc30.ber"
            println(pathname1)
            var fs1: File = File(pathname1, Open(true, true))
            var res1: Array<Byte> = fs1.readToEnd()
            println(res1)
            let decodetd: DEREncoder = DEREncoder()
            var byteArrayStream: ByteArrayStream = ByteArrayStream()
            byteArrayStream.write(res1)
            var asn1inputstream:ASN1InputStream=ASN1InputStream(BERDecoder(),byteArrayStream)
            var leng=asn1inputstream.readLength()
            println(leng)
            @Assert(leng,5)
    }


    @TestCase
    func AsnOne19(): Unit {

            let pathname1: String = "file/encoded_tc31.ber"
            println(pathname1)
            var fs1: File = File(pathname1, Open(true, true))
            var res1: Array<Byte> = fs1.readToEnd()
            println(res1)
            let decodetd: DEREncoder = DEREncoder()
            var byteArrayStream: ByteArrayStream = ByteArrayStream()
            byteArrayStream.write(res1)
            var asn1inputstream:ASN1InputStream=ASN1InputStream(BERDecoder(),byteArrayStream)
            var leng=asn1inputstream.readLength()
            println(leng)
            @Assert(leng,5)
    }


    @TestCase
    func AsnOne20(): Unit {

            let pathname1: String = "file/encoded_tc32.ber"
            println(pathname1)
            var fs1: File = File(pathname1, Open(true, true))
            var res1: Array<Byte> = fs1.readToEnd()
            println(res1)
            let decodetd: DEREncoder = DEREncoder()
            var byteArrayStream: ByteArrayStream = ByteArrayStream()
            byteArrayStream.write(res1)
            var asn1inputstream:ASN1InputStream=ASN1InputStream(BERDecoder(),byteArrayStream)
            var leng=asn1inputstream.readLength()
            println(leng)
            @Assert(leng,5)
    }


    @TestCase
    func AsnOne21(): Unit {

            let pathname1: String = "file/encoded_tc33.ber"
            println(pathname1)
            var fs1: File = File(pathname1, Open(true, true))
            var res1: Array<Byte> = fs1.readToEnd()
            println(res1)
            let decodetd: DEREncoder = DEREncoder()
            var byteArrayStream: ByteArrayStream = ByteArrayStream()
            byteArrayStream.write(res1)
            var asn1inputstream:ASN1InputStream=ASN1InputStream(BERDecoder(),byteArrayStream)
            var leng=asn1inputstream.readLength()
            println(leng)
            @Assert(leng,3)
    }


    @TestCase
    func AsnOne22(): Unit {

            let pathname1: String = "file/encoded_tc34.ber"
            println(pathname1)
            var fs1: File = File(pathname1, Open(true, true))
            var res1: Array<Byte> = fs1.readToEnd()
            println(res1)
            let decodetd: DEREncoder = DEREncoder()
            var byteArrayStream: ByteArrayStream = ByteArrayStream()
            byteArrayStream.write(res1)
            var asn1inputstream:ASN1InputStream=ASN1InputStream(BERDecoder(),byteArrayStream)
            var leng=asn1inputstream.readLength()
            println(leng)
            @Assert(leng,3)
    }


    @TestCase
    func AsnOne23(): Unit {

            let pathname1: String = "file/encoded_tc37.ber"
            println(pathname1)
            var fs1: File = File(pathname1, Open(true, true))
            var res1: Array<Byte> = fs1.readToEnd()
            println(res1)
            let decodetd: DEREncoder = DEREncoder()
            var byteArrayStream: ByteArrayStream = ByteArrayStream()
            byteArrayStream.write(res1)
            var asn1inputstream:ASN1InputStream=ASN1InputStream(BERDecoder(),byteArrayStream)
            var leng=asn1inputstream.readLength()
            println(leng)
            @Assert(leng,35)
    }


    @TestCase
    func AsnOne24(): Unit {

            let pathname1: String = "file/encoded_tc39.ber"
            println(pathname1)
            var fs1: File = File(pathname1, Open(true, true))
            var res1: Array<Byte> = fs1.readToEnd()
            println(res1)
            let decodetd: DEREncoder = DEREncoder()
            var byteArrayStream: ByteArrayStream = ByteArrayStream()
            byteArrayStream.write(res1)
            var asn1inputstream:ASN1InputStream=ASN1InputStream(BERDecoder(),byteArrayStream)
            var leng=asn1inputstream.readLength()
            println(leng)
            @Assert(leng,35)
    }

    @TestCase
    func AsnOne25(): Unit {

            let pathname1: String = "file/encoded_tc40.ber"
            println(pathname1)
            var fs1: File = File(pathname1, Open(true, true))
            var res1: Array<Byte> = fs1.readToEnd()
            println(res1)
            let decodetd: DEREncoder = DEREncoder()
            var byteArrayStream: ByteArrayStream = ByteArrayStream()
            byteArrayStream.write(res1)
            var asn1inputstream:ASN1InputStream=ASN1InputStream(BERDecoder(),byteArrayStream)
            var leng=asn1inputstream.readLength()
            println(leng)
            @Assert(leng,3)
    }


    @TestCase
    func AsnOne26(): Unit {

            let pathname1: String = "file/encoded_tc43.ber"
            println(pathname1)
            var fs1: File = File(pathname1, Open(true, true))
            var res1: Array<Byte> = fs1.readToEnd()
            println(res1)
            let decodetd: DEREncoder = DEREncoder()
            var byteArrayStream: ByteArrayStream = ByteArrayStream()
            byteArrayStream.write(res1)
            var asn1inputstream:ASN1InputStream=ASN1InputStream(BERDecoder(),byteArrayStream)
            var leng=asn1inputstream.readLength()
            println(leng)
            @Assert(leng,36)
    }

    @TestCase
    func AsnOne27(): Unit {

            let pathname1: String = "file/encoded_tc44.ber"
            println(pathname1)
            var fs1: File = File(pathname1, Open(true, true))
            var res1: Array<Byte> = fs1.readToEnd()
            println(res1)
            let decodetd: DEREncoder = DEREncoder()
            var byteArrayStream: ByteArrayStream = ByteArrayStream()
            byteArrayStream.write(res1)
            var asn1inputstream:ASN1InputStream=ASN1InputStream(BERDecoder(),byteArrayStream)
            var leng=asn1inputstream.readLength()
            println(leng)
            @Assert(leng,4)
    }

    @TestCase
    func AsnOne28(): Unit {

            let pathname1: String = "file/encoded_tc45.ber"
            println(pathname1)
            var fs1: File = File(pathname1, Open(true, true))
            var res1: Array<Byte> = fs1.readToEnd()
            println(res1)
            let decodetd: DEREncoder = DEREncoder()
            var byteArrayStream: ByteArrayStream = ByteArrayStream()
            byteArrayStream.write(res1)
            var asn1inputstream:ASN1InputStream=ASN1InputStream(BERDecoder(),byteArrayStream)
            var leng=asn1inputstream.readLength()
            println(leng)
            @Assert(leng,36)
    }


    @TestCase
    func AsnOne29(): Unit {

            let pathname1: String = "file/encoded_tc46.ber"
            println(pathname1)
            var fs1: File = File(pathname1, Open(true, true))
            var res1: Array<Byte> = fs1.readToEnd()
            println(res1)
            let decodetd: DEREncoder = DEREncoder()
            var byteArrayStream: ByteArrayStream = ByteArrayStream()
            byteArrayStream.write(res1)
            var asn1inputstream:ASN1InputStream=ASN1InputStream(BERDecoder(),byteArrayStream)
            var leng=asn1inputstream.readLength()
            println(leng)
            @Assert(leng,0)
    }


    @TestCase
    func AsnOne30(): Unit {

            let pathname1: String = "file/encoded_tc47.ber"
            println(pathname1)
            var fs1: File = File(pathname1, Open(true, true))
            var res1: Array<Byte> = fs1.readToEnd()
            println(res1)
            let decodetd: DEREncoder = DEREncoder()
            var byteArrayStream: ByteArrayStream = ByteArrayStream()
            byteArrayStream.write(res1)
            var asn1inputstream:ASN1InputStream=ASN1InputStream(BERDecoder(),byteArrayStream)
            var leng=asn1inputstream.readLength()
            println(leng)
            @Assert(leng,35)
    }


    @TestCase
    func AsnOne31(): Unit {

            let pathname1: String = "file/tc6.ber"
            println(pathname1)
            var fs1: File = File(pathname1, Open(true, true))
            var res1: Array<Byte> = fs1.readToEnd()
            println(res1)
            let decodetd: DEREncoder = DEREncoder()
            var byteArrayStream: ByteArrayStream = ByteArrayStream()
            byteArrayStream.write(res1)
            var asn1inputstream:ASN1InputStream=ASN1InputStream(BERDecoder(),byteArrayStream)
            var leng=asn1inputstream.readLength()
            println(leng)
            @Assert(leng,9)
    }


    @TestCase
    func AsnOne32(): Unit {

            let pathname1: String = "file/tc7.ber"
            println(pathname1)
            var fs1: File = File(pathname1, Open(true, true))
            var res1: Array<Byte> = fs1.readToEnd()
            println(res1)
            let decodetd: DEREncoder = DEREncoder()
            var byteArrayStream: ByteArrayStream = ByteArrayStream()
            byteArrayStream.write(res1)
            var asn1inputstream:ASN1InputStream=ASN1InputStream(BERDecoder(),byteArrayStream)
            var leng=asn1inputstream.readLength()
            println(leng)
            @Assert(leng,9)
    }


    @TestCase
    func AsnOne33(): Unit {

            let pathname1: String = "file/tc8.ber"
            println(pathname1)
            var fs1: File = File(pathname1, Open(true, true))
            var res1: Array<Byte> = fs1.readToEnd()
            println(res1)
            let decodetd: DEREncoder = DEREncoder()
            var byteArrayStream: ByteArrayStream = ByteArrayStream()
            byteArrayStream.write(res1)
            var asn1inputstream:ASN1InputStream=ASN1InputStream(BERDecoder(),byteArrayStream)
            var leng=asn1inputstream.readLength()
            println(leng)
            @Assert(leng,9)
    }

    @TestCase
    func AsnOne34(): Unit {

            let pathname1: String = "file/tc8.ber"
            println(pathname1)
            var fs1: File = File(pathname1, Open(true, true))
            var res1: Array<Byte> = fs1.readToEnd()
            println(res1)
            let decodetd: DEREncoder = DEREncoder()
            var byteArrayStream: ByteArrayStream = ByteArrayStream()
            byteArrayStream.write(res1)
            var asn1inputstream:ASN1InputStream=ASN1InputStream(BERDecoder(),byteArrayStream)
            var leng=asn1inputstream.readLength()
            println(leng)
            @Assert(leng,9)
    }


    @TestCase
    func AsnOne35(): Unit {

            let pathname1: String = "file/tc11.ber"
            println(pathname1)
            var fs1: File = File(pathname1, Open(true, true))
            var res1: Array<Byte> = fs1.readToEnd()
            println(res1)
            let decodetd: DEREncoder = DEREncoder()
            var byteArrayStream: ByteArrayStream = ByteArrayStream()
            byteArrayStream.write(res1)
            var asn1inputstream:ASN1InputStream=ASN1InputStream(BERDecoder(),byteArrayStream)
            var leng=asn1inputstream.readLength()
            println(leng)
            @Assert(leng,9)
    }


    @TestCase
    func AsnOne36(): Unit {

            let pathname1: String = "file/tc12.ber"
            println(pathname1)
            var fs1: File = File(pathname1, Open(true, true))
            var res1: Array<Byte> = fs1.readToEnd()
            println(res1)
            let decodetd: DEREncoder = DEREncoder()
            var byteArrayStream: ByteArrayStream = ByteArrayStream()
            byteArrayStream.write(res1)
            var asn1inputstream:ASN1InputStream=ASN1InputStream(BERDecoder(),byteArrayStream)
            var leng=asn1inputstream.readLength()
            println(leng)
            @Assert(leng,9)
    }


    @TestCase
    func AsnOne37(): Unit {

            let pathname1: String = "file/tc19.ber"
            println(pathname1)
            var fs1: File = File(pathname1, Open(true, true))
            var res1: Array<Byte> = fs1.readToEnd()
            println(res1)
            let decodetd: DEREncoder = DEREncoder()
            var byteArrayStream: ByteArrayStream = ByteArrayStream()
            byteArrayStream.write(res1)
            var asn1inputstream:ASN1InputStream=ASN1InputStream(BERDecoder(),byteArrayStream)
            var leng=asn1inputstream.readLength()
            println(leng)
            @Assert(leng,2)
    }


    @TestCase
    func AsnOne38(): Unit {

            let pathname1: String = "file/tc25.ber"
            println(pathname1)
            var fs1: File = File(pathname1, Open(true, true))
            var res1: Array<Byte> = fs1.readToEnd()
            println(res1)
            let decodetd: DEREncoder = DEREncoder()
            var byteArrayStream: ByteArrayStream = ByteArrayStream()
            byteArrayStream.write(res1)
            var asn1inputstream:ASN1InputStream=ASN1InputStream(BERDecoder(),byteArrayStream)
            var leng=asn1inputstream.readLength()
            println(leng)
            @Assert(leng,1)
    }


    @TestCase
    func AsnOne39(): Unit {

            let pathname1: String = "file/tc26.ber"
            println(pathname1)
            var fs1: File = File(pathname1, Open(true, true))
            var res1: Array<Byte> = fs1.readToEnd()
            println(res1)
            let decodetd: DEREncoder = DEREncoder()
            var byteArrayStream: ByteArrayStream = ByteArrayStream()
            byteArrayStream.write(res1)
            var asn1inputstream:ASN1InputStream=ASN1InputStream(BERDecoder(),byteArrayStream)
            var leng=asn1inputstream.readLength()
            println(leng)
            @Assert(leng,1)
    }


    @TestCase
    func AsnOne40(): Unit {

            let pathname1: String = "file/tc27.ber"
            println(pathname1)
            var fs1: File = File(pathname1, Open(true, true))
            var res1: Array<Byte> = fs1.readToEnd()
            println(res1)
            let decodetd: DEREncoder = DEREncoder()
            var byteArrayStream: ByteArrayStream = ByteArrayStream()
            byteArrayStream.write(res1)
            var asn1inputstream:ASN1InputStream=ASN1InputStream(BERDecoder(),byteArrayStream)
            var leng=asn1inputstream.readLength()
            println(leng)
            @Assert(leng,1)
    }


    @TestCase
    func AsnOne41(): Unit {

            let pathname1: String = "file/tc29.ber"
            println(pathname1)
            var fs1: File = File(pathname1, Open(true, true))
            var res1: Array<Byte> = fs1.readToEnd()
            println(res1)
            let decodetd: DEREncoder = DEREncoder()
            var byteArrayStream: ByteArrayStream = ByteArrayStream()
            byteArrayStream.write(res1)
            var asn1inputstream:ASN1InputStream=ASN1InputStream(BERDecoder(),byteArrayStream)
            var leng=asn1inputstream.readLength()
            println(leng)
            @Assert(leng,1)
    }


    @TestCase
    func AsnOne42(): Unit {

            let pathname1: String = "file/tc30.ber"
            println(pathname1)
            var fs1: File = File(pathname1, Open(true, true))
            var res1: Array<Byte> = fs1.readToEnd()
            println(res1)
            let decodetd: DEREncoder = DEREncoder()
            var byteArrayStream: ByteArrayStream = ByteArrayStream()
            byteArrayStream.write(res1)
            var asn1inputstream:ASN1InputStream=ASN1InputStream(BERDecoder(),byteArrayStream)
            var leng=asn1inputstream.readLength()
            println(leng)
            @Assert(leng,5)
    }


    @TestCase
    func AsnOne43(): Unit {

            let pathname1: String = "file/tc31.ber"
            println(pathname1)
            var fs1: File = File(pathname1, Open(true, true))
            var res1: Array<Byte> = fs1.readToEnd()
            println(res1)
            let decodetd: DEREncoder = DEREncoder()
            var byteArrayStream: ByteArrayStream = ByteArrayStream()
            byteArrayStream.write(res1)
            var asn1inputstream:ASN1InputStream=ASN1InputStream(BERDecoder(),byteArrayStream)
            var leng=asn1inputstream.readLength()
            println(leng)
            @Assert(leng,5)
    }


    @TestCase
    func AsnOne44(): Unit {

            let pathname1: String = "file/tc32.ber"
            println(pathname1)
            var fs1: File = File(pathname1, Open(true, true))
            var res1: Array<Byte> = fs1.readToEnd()
            println(res1)
            let decodetd: DEREncoder = DEREncoder()
            var byteArrayStream: ByteArrayStream = ByteArrayStream()
            byteArrayStream.write(res1)
            var asn1inputstream:ASN1InputStream=ASN1InputStream(BERDecoder(),byteArrayStream)
            var leng=asn1inputstream.readLength()
            println(leng)
            @Assert(leng,5)
    }


    @TestCase
    func AsnOne45(): Unit {

            let pathname1: String = "file/tc33.ber"
            println(pathname1)
            var fs1: File = File(pathname1, Open(true, true))
            var res1: Array<Byte> = fs1.readToEnd()
            println(res1)
            let decodetd: DEREncoder = DEREncoder()
            var byteArrayStream: ByteArrayStream = ByteArrayStream()
            byteArrayStream.write(res1)
            var asn1inputstream:ASN1InputStream=ASN1InputStream(BERDecoder(),byteArrayStream)
            var leng=asn1inputstream.readLength()
            println(leng)
            @Assert(leng,3)
    }


    @TestCase
    func AsnOne46(): Unit {

            let pathname1: String = "file/tc34.ber"
            println(pathname1)
            var fs1: File = File(pathname1, Open(true, true))
            var res1: Array<Byte> = fs1.readToEnd()
            println(res1)
            let decodetd: DEREncoder = DEREncoder()
            var byteArrayStream: ByteArrayStream = ByteArrayStream()
            byteArrayStream.write(res1)
            var asn1inputstream:ASN1InputStream=ASN1InputStream(BERDecoder(),byteArrayStream)
            var leng=asn1inputstream.readLength()
            println(leng)
            @Assert(leng,3)
    }


    @TestCase
    func AsnOne47(): Unit {

            let pathname1: String = "file/tc37.ber"
            println(pathname1)
            var fs1: File = File(pathname1, Open(true, true))
            var res1: Array<Byte> = fs1.readToEnd()
            println(res1)
            let decodetd: DEREncoder = DEREncoder()
            var byteArrayStream: ByteArrayStream = ByteArrayStream()
            byteArrayStream.write(res1)
            var asn1inputstream:ASN1InputStream=ASN1InputStream(BERDecoder(),byteArrayStream)
            var leng=asn1inputstream.readLength()
            println(leng)
            @Assert(leng,35)
    }



    @TestCase
    func AsnOne48(): Unit {

            let pathname1: String = "file/tc39.ber"
            println(pathname1)
            var fs1: File = File(pathname1, Open(true, true))
            var res1: Array<Byte> = fs1.readToEnd()
            println(res1)
            let decodetd: DEREncoder = DEREncoder()
            var byteArrayStream: ByteArrayStream = ByteArrayStream()
            byteArrayStream.write(res1)
            var asn1inputstream:ASN1InputStream=ASN1InputStream(BERDecoder(),byteArrayStream)
            var leng=asn1inputstream.readLength()
            println(leng)
            @Assert(leng,35)
    }


    @TestCase
    func AsnOne49(): Unit {

            let pathname1: String = "file/tc40.ber"
            println(pathname1)
            var fs1: File = File(pathname1, Open(true, true))
            var res1: Array<Byte> = fs1.readToEnd()
            println(res1)
            let decodetd: DEREncoder = DEREncoder()
            var byteArrayStream: ByteArrayStream = ByteArrayStream()
            byteArrayStream.write(res1)
            var asn1inputstream:ASN1InputStream=ASN1InputStream(BERDecoder(),byteArrayStream)
            var leng=asn1inputstream.readLength()
            println(leng)
            @Assert(leng,3)
    }


    @TestCase
    func AsnOne50(): Unit {

            let pathname1: String = "file/tc43.ber"
            println(pathname1)
            var fs1: File = File(pathname1, Open(true, true))
            var res1: Array<Byte> = fs1.readToEnd()
            println(res1)
            let decodetd: DEREncoder = DEREncoder()
            var byteArrayStream: ByteArrayStream = ByteArrayStream()
            byteArrayStream.write(res1)
            var asn1inputstream:ASN1InputStream=ASN1InputStream(BERDecoder(),byteArrayStream)
            var leng=asn1inputstream.readLength()
            println(leng)
            @Assert(leng,36)
    }


    @TestCase
    func AsnOne51(): Unit {

            let pathname1: String = "file/tc44.ber"
            println(pathname1)
            var fs1: File = File(pathname1, Open(true, true))
            var res1: Array<Byte> = fs1.readToEnd()
            println(res1)
            let decodetd: DEREncoder = DEREncoder()
            var byteArrayStream: ByteArrayStream = ByteArrayStream()
            byteArrayStream.write(res1)
            var asn1inputstream:ASN1InputStream=ASN1InputStream(BERDecoder(),byteArrayStream)
            var leng=asn1inputstream.readLength()
            println(leng)
            @Assert(leng,4)
    }


    @TestCase
    func AsnOne52(): Unit {

            let pathname1: String = "file/tc45.ber"
            println(pathname1)
            var fs1: File = File(pathname1, Open(true, true))
            var res1: Array<Byte> = fs1.readToEnd()
            println(res1)
            let decodetd: DEREncoder = DEREncoder()
            var byteArrayStream: ByteArrayStream = ByteArrayStream()
            byteArrayStream.write(res1)
            var asn1inputstream:ASN1InputStream=ASN1InputStream(BERDecoder(),byteArrayStream)
            var leng=asn1inputstream.readLength()
            println(leng)
            @Assert(leng,36)
    }


    @TestCase
    func AsnOne53(): Unit {

            let pathname1: String = "file/tc47.ber"
            println(pathname1)
            var fs1: File = File(pathname1, Open(true, true))
            var res1: Array<Byte> = fs1.readToEnd()
            println(res1)
            let decodetd: DEREncoder = DEREncoder()
            var byteArrayStream: ByteArrayStream = ByteArrayStream()
            byteArrayStream.write(res1)
            var asn1inputstream:ASN1InputStream=ASN1InputStream(BERDecoder(),byteArrayStream)
            var leng=asn1inputstream.readLength()
            println(leng)
            @Assert(leng,35)
    }


    @TestCase
    func AsnOne54(): Unit {

            let pathname1: String = "file/tc48.ber"
            println(pathname1)
            var fs1: File = File(pathname1, Open(true, true))
            var res1: Array<Byte> = fs1.readToEnd()
            println(res1)
            let decodetd: DEREncoder = DEREncoder()
            var byteArrayStream: ByteArrayStream = ByteArrayStream()
            byteArrayStream.write(res1)
            var asn1inputstream:ASN1InputStream=ASN1InputStream(BERDecoder(),byteArrayStream)
            var leng=asn1inputstream.readLength()
            println(leng)
            @Assert(leng,35)
    }
}
