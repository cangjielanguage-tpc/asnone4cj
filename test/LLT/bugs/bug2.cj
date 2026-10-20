// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import asn1.*
import std.io.*
import std.collection.*
import std.time.*
import std.unittest.*
import std.unittest.testmacro.*

main(): Int64 {
    var asn1Tag1: ASN1Tag = ASN1Tag.application(2)
    @Assert(asn1Tag1.toString(), "ASN1Tag[APPLICATION,PRIMITIVE,2]")

    var asn1Tag2: ASN1Tag = ASN1Tag.contextSpecific(2)
    @Assert(asn1Tag2.toString(), "ASN1Tag[CONTEXT_SPECIFIC,PRIMITIVE,2]")
    return 0
}
