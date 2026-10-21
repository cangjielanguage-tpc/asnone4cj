// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import std.io.*
import asn1.*
import std.math.numeric.*
import std.unittest.*
import std.unittest.testmacro.*

main(): Int64 {
    var asn1Enumerated: ASN1Enumerated = ASN1Enumerated(-9)
    var bigint: BigInt = (asn1Enumerated.getValue() as BigInt).getOrThrow()
    println(bigint.toString())
    @Assert(bigint.toString(), "-9")

    var asn1Integer: ASN1Integer = ASN1Integer(-9)
    var bigint1: BigInt = (asn1Integer.getValue() as BigInt).getOrThrow()
    println(bigint1.toString())
    @Assert(bigint1.toString(), "-9")
    return 0
}
