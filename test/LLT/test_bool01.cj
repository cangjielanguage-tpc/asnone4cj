// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import asn1.*
import std.io.*
import std.unittest.*
import std.unittest.testmacro.*

main(): Int64 {
    let bytesBuf: Array<Byte> = Array<Byte>(10, repeat: 0)
    let sc = ASN1Boolean(true)
    ASN1Boolean(true,bytesBuf)
    let fs = sc.getValue()
    var asn1test: Bool = (fs as Bool).getOrThrow()
    println(asn1test)
    let dec: BERDecoder = BERDecoder()
    BooleanParser(dec)

    @Assert(asn1test, true)
    return 0
}
