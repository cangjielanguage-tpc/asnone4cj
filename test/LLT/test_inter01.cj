// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import asn1.*
import std.io.*
import std.math.numeric.*
import std.unittest.*
import std.unittest.testmacro.*

main(): Int64 {
    let bytesBuf: Array<Byte> = Array<Byte>(10, repeat: 0)
    ASN1Integer(65)
    var d: BigInt = BigInt(2)
    let sc1 = ASN1Integer(d)
    ASN1Integer(d,bytesBuf)
    sc1.getValue()

    let decodetd: BERDecoder = BERDecoder()
    let src = IntegerParser(decodetd)
    let src1 = src.parse(INTEGER,bytesBuf)
    println(src1.toString())

    @Assert(src1.toString(), "ASN1Object[ASN1Tag[UNIVERSAL,PRIMITIVE,2]]")
    return 0
}
