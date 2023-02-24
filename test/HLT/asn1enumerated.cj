// 3rd_party_lib:asn-one/build/asn1
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
@Test
public class asn_ASN1Enumerated{

    @TestCase
    func asn_ASN1Enumerated_01(): Unit {

         let  a=9
         var asn1integer: ASN1Enumerated= ASN1Enumerated(a)
    }


    @TestCase
    func asn_ASN1Enumerated_02(): Unit {                   

         let  a=-9
         var asn1integer: ASN1Enumerated= ASN1Enumerated(a)
    }



    @TestCase
    func asn_ASN1Enumerated_03(): Unit {

         let  a=9223372036854775807
         var asn1integer: ASN1Enumerated= ASN1Enumerated(a)
    }


    @TestCase
    func asn_ASN1OctetString_04(): Unit {

         let Buf: Array<Byte> = [0x60, 0x08, 0x06, 0x06, 0x2B, 0x06, 0x01, 0x05, 0x05, 0x02]
         var asn1octetString: ASN1OctetString= ASN1OctetString(Buf)
    }


    @TestCase
    func asn_ASN1OctetString_05(): Unit {

         let Buf: Array<Byte> = [0x04, 0x08, 0x06, 0x06, 0x2B, 0x06, 0x01, 0x05, 0x05, 0x02]
         var asn1octetString: ASN1OctetString= ASN1OctetString(Buf)
    }


    @TestCase
    func asn_ASN1OctetString_06(): Unit {

         let Buf: Array<Byte> = []
         var asn1octetString: ASN1OctetString= ASN1OctetString(Buf)
    }

}
