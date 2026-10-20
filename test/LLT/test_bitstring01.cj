// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import asn1.*
import std.io.*
import std.unittest.*
import std.unittest.testmacro.*

main(): Int64 {
    let arr: Array<Bool> = [true, true, false, true, false, false].toArray()
    var asn1itstring: ASN1BitString = ASN1BitString(arr)
    @Assert(asn1itstring.isSet(-7), true)
    @Assert(asn1itstring.isSet(-6), true)
    @Assert(asn1itstring.isSet(-5), true)
    @Assert(asn1itstring.isSet(-4), true)
    @Assert(asn1itstring.isSet(-3), true)
    @Assert(asn1itstring.isSet(-2), true)
    @Assert(asn1itstring.isSet(-1), true)
    @Assert(asn1itstring.isSet(0), true)
    @Assert(asn1itstring.isSet(1), true)
    @Assert(asn1itstring.isSet(2), false)
    @Assert(asn1itstring.isSet(3), true)
    @Assert(asn1itstring.isSet(4), false)
    @Assert(asn1itstring.isSet(5), false)
    @Assert(asn1itstring.isSet(6), false)
    @Assert(asn1itstring.isSet(7), false)
    return 0
}
