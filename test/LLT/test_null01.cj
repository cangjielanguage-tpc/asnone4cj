// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import asn1.*
import std.io.*
import std.unittest.*
import std.unittest.testmacro.*

main(): Int64 {
    let bytesBuf: Array<Byte> = Array<Byte>()
    let sc = ASN1Null()
    sc.getValue()
    let deco: BERDecoder = BERDecoder()
    let src = NullParser(deco)
    let src2 = src.parse(ASN1_NULL_TAG,bytesBuf)
    println(src2.toString())

    @Assert(src2.toString(), "ASN1Object[ASN1Tag[UNIVERSAL,PRIMITIVE,5]]")
    return 0
}
