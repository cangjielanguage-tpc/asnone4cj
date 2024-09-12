// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import asn1.*
import std.io.*
import std.math.numeric.*

main() {
    let bytesBuf: Array<Byte> = Array<Byte>(10, repeat: 0)
    let sc = ASN1Enumerated(65)
    var p: BigInt = BigInt(1)
    ASN1Enumerated(p)
    ASN1Enumerated(p,bytesBuf)
    sc.getValue()
    let decodetd: BERDecoder = BERDecoder()
    let src =EnumeratedParser(decodetd)
    let src1 = src.parse(ENUMERATED,bytesBuf)
    println(src1.toString())
    if (src1.toString() != "ASN1Object[ASN1Tag[UNIVERSAL,PRIMITIVE,10]]") {
        return 1
    }
    return 0
}
