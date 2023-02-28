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
public class asn_ASN1Null{

    @TestCase
    func asn_ASN1Null_01(): Unit {

         var asn1integer:ASN1Null=ASN1Null()
         var ssss= (asn1integer.getValue() as Option<Unit>).getOrThrow()
         println(ssss)
         @Assert(ssss.toString(),"None")
    }


    @TestCase
    func asn_ASN1Null_02(): Unit {

        let Buf: Array<Byte> = [0x01, 0x01, 0x0]
         var asn10:ASN1OctetString=ASN1OctetString(Buf)
         var ssss= asn10.length()
         println(ssss)
         @Assert(ssss,3)
    }

}
