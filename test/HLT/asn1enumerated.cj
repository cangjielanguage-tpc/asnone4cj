// 3rd_party_lib:asnone4cj/target/release/asn1

import std.io.*
import asn1.*
import std.collection.*

@Test
public class asn_ASN1Enumerated {
    @TestCase
    func asn_ASN1Enumerated_01(): Unit {
        var a = 0
        try {
            let a = 9
            ASN1Enumerated(a)
            let b = -9
            ASN1Enumerated(b)
            let c = 9223372036854775807
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
