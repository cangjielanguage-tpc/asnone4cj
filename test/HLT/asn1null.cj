// 3rd_party_lib:asnone4cj/target/release/asn1

import std.io.*
import asn1.*
import std.collection.*
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
