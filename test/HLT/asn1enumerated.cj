// 3rd_party_lib:asn1-cj/build/asn1
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

     var  a=0
     try{
         let  a=9
         ASN1Enumerated(a)
         let  b=-9
         ASN1Enumerated(b)
          let  c=9223372036854775807
         ASN1Enumerated(c)
         let Buf: Array<Byte> = [0x60, 0x08, 0x06, 0x06, 0x2B, 0x06, 0x01, 0x05, 0x05, 0x02]
         ASN1OctetString(Buf)
         let Buf1: Array<Byte> = [0x04, 0x08, 0x06, 0x06, 0x2B, 0x06, 0x01, 0x05, 0x05, 0x02]
          ASN1OctetString(Buf1)
          let Buf2: Array<Byte> = []
         ASN1OctetString(Buf2)
         } catch (e: Exception) {
          a = 1
    }
     @Assert(a,0)
    }




}
