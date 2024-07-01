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
from asn1 import asn1.ASN1TaggedObject
from std import io.*
from asn1 import asn1.ASN1ParseException
from asn1 import asn1.ASN1Object
from asn1 import asn1.ASN1Sequence
from asn1 import asn1.BitStringParser
from asn1 import asn1.*
from std import collection.*
@Test
public class asn_Asn1objectIdentifier{

    @TestCase
    func asn_Asn1objectIdentifier_01(): Unit {

         var ObjectIdentifier:ASN1ObjectIdentifier=ASN1ObjectIdentifier("1.2.52")
         var ssss= (ObjectIdentifier.getValue() as String).getOrThrow()
         println(ssss)
         @Assert(ssss,"1.2.52")
    }


    @TestCase
    func asn_Asn1objectIdentifier_02(): Unit {

         var ObjectIdentifier:ASN1ObjectIdentifier=ASN1ObjectIdentifier("1.2.127.127.127.127")
         var ssss= (ObjectIdentifier.getValue() as String).getOrThrow()
         println(ssss)
         @Assert(ssss,"1.2.127.127.127.127")
    }


    @TestCase
    func asn_Asn1objectIdentifier_03(): Unit {

         var ObjectIdentifier:ASN1ObjectIdentifier=ASN1ObjectIdentifier("0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0")
         var ssss= (ObjectIdentifier.getValue() as String).getOrThrow()
         println(ssss)
         @Assert(ssss,"0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0")
    }


    @TestCase
    func asn_Asn1objectIdentifier_04(): Unit {

         var ObjectIdentifier:ASN1ObjectIdentifier=ASN1ObjectIdentifier("128.-129.130.-255")
         var ssss= (ObjectIdentifier.getValue() as String).getOrThrow()
         println(ssss)
         @Assert(ssss,"128.-129.130.-255")
    }


    @TestCase
    func asn_Asn1objectIdentifier_05(): Unit {

         var ObjectIdentifier:ASN1ObjectIdentifier=ASN1ObjectIdentifier("")
         var ssss= (ObjectIdentifier.getValue() as String).getOrThrow()
         println(ssss)
         @Assert(ssss,"")
    }

    @TestCase
    func asn_Asn1objectIdentifier_06(): Unit {

         var ObjectIdentifier:ASN1ObjectIdentifier=ASN1ObjectIdentifier("nihao")
         var ssss= (ObjectIdentifier.getValue() as String).getOrThrow()
         println(ssss)
         @Assert(ssss,"nihao")
    }


    @TestCase
    func asn_Asn1objectIdentifier_07(): Unit {

         var ObjectIdentifier:ASN1ObjectIdentifier=ASN1ObjectIdentifier("仓颉")
         var ssss= (ObjectIdentifier.getValue() as String).getOrThrow()
         println(ssss)
         @Assert(ssss,"仓颉")
    }


    @TestCase
    func asn_Asn1objectIdentifier_08(): Unit {

         var ObjectIdentifier:ASN1ObjectIdentifier=ASN1ObjectIdentifier("仓颉nihao")
         var ssss= (ObjectIdentifier.getValue() as String).getOrThrow()
         println(ssss)
         @Assert(ssss,"仓颉nihao")
    }


    @TestCase
    func asn_Asn1objectIdentifier_09(): Unit {

         var ObjectIdentifier:ASN1ObjectIdentifier=ASN1ObjectIdentifier("仓颉nihao^%&*%")
         var ssss= (ObjectIdentifier.getValue() as String).getOrThrow()
         println(ssss)
         @Assert(ssss,"仓颉nihao^%&*%")
    }
}
