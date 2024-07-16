// 3rd_party_lib:asnone4cj/target/release/asn1

import std.io.*
import asn1.*
import std.collection.*
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
