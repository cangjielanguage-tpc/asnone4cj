// 3rd_party_lib:asnone4cj/target/release/asn1

import std.io.*
import asn1.*
import std.collection.*

@Test
public class asn_ASN1Boolean01 {
    @TestCase
    func asn_Asn1Boolean_01(): Unit {
        var asn1bool: ASN1Boolean = ASN1Boolean(false)
        var ssss: Bool = (asn1bool.getValue() as Bool).getOrThrow()
        println(ssss)
        @Assert(ssss,false)
    }

    @TestCase
    func asn_Asn1Boolean_02(): Unit {
        var asn1bool: ASN1Boolean = ASN1Boolean(true)
        var ssss: Bool = (asn1bool.getValue() as Bool).getOrThrow()
        println(ssss)
        @Assert(ssss,true)
    }
}
