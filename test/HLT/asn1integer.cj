// 3rd_party_lib:asnone4cj/target/release/asn1

import std.io.*
import asn1.*
import std.collection.*
import std.math.numeric.*

@Test
public class asn_Asn1OutputStream01 {
    @TestCase
    func asn_Asn1Integer_01(): Unit {
        var value1: BigInt = BigInt(0)
        var asn1integer: ASN1Integer = ASN1Integer(value1)
        var ssss: BigInt = (asn1integer.getValue() as BigInt).getOrThrow()
        var intValue: String = ssss.toString()
        @Assert(intValue,"0")
    }

    @TestCase
    func asn_Asn1Integer_02(): Unit {
        var value1: BigInt = BigInt(184467440737)
        var asn1integer: ASN1Integer = ASN1Integer(value1)
        var ssss: BigInt = (asn1integer.getValue() as BigInt).getOrThrow()
        var intValue: String = ssss.toString()
        @Assert(intValue,"184467440737")
    }

    @TestCase
    func asn_Asn1Integer_03(): Unit {
        var value1: BigInt = BigInt(10)
        var asn1integer: ASN1Integer = ASN1Integer(value1)
        var ssss: BigInt = (asn1integer.getValue() as BigInt).getOrThrow()
        var intValue: String = ssss.toString()
        @Assert(intValue,"10")
    }

    @TestCase
    func asn_Asn1Integer_04(): Unit {
        var value1: BigInt = BigInt(9999)
        var asn1integer: ASN1Integer = ASN1Integer(value1)
        var ssss: BigInt = (asn1integer.getValue() as BigInt).getOrThrow()
        var intValue: String = ssss.toString()
        @Assert(intValue,"9999")
    }

    @TestCase
    func asn_Asn1Integer_05(): Unit {
        var value1: BigInt = BigInt(184467440737)
        var asn1integer: ASN1Integer = ASN1Integer(value1)
        var ssss: BigInt = (asn1integer.getValue() as BigInt).getOrThrow()
        var intValue: String = ssss.toString()
        @Assert(intValue,"184467440737")
    }

    @TestCase
    func asn_Asn1Integer_06(): Unit {
        var value1: BigInt = BigInt(-9223372036854775807)
        var asn1integer: ASN1Integer = ASN1Integer(value1)
        var ssss: BigInt = (asn1integer.getValue() as BigInt).getOrThrow()
        var intValue: String = ssss.toString()
        @Assert(intValue,"-9223372036854775807")
    }

    @TestCase
    func asn_Asn1Integer_07(): Unit {
        var value1: BigInt = BigInt(-2)
        var asn1integer: ASN1Integer = ASN1Integer(value1)
        var ssss: BigInt = (asn1integer.getValue() as BigInt).getOrThrow()
        var intValue: String = ssss.toString()
        @Assert(intValue,"-2")
    }
}
