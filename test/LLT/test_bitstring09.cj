// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import std.io.*
import asn1.*
import std.unittest.*
import std.unittest.testmacro.*

main(): Int64 {
    let decz: BERDecoder = BERDecoder()
    DEREncoder()
    let arr: Array<Bool> = Array<Bool>(80, repeat: true)
    ASN1BitString(arr)
    let srt = BitStringParser(decz)
    let tag = SEQUENCE
    tag.isConstructed()
    let buf = Array<Byte>(80, repeat: 1)
    // Boolean tag 传入 BitString 解析器应抛异常
    var caught1: Bool = false
    try {
        srt.parse(tag,buf)
    } catch (e: Exception) {
        caught1 = true
    }
    @Assert(caught1, true)

    ASN1InputStream(decz, buf)

    @Assert(tag.isConstructed(), true)
    return 0
}
