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

    // primitive BIT STRING 的 unusedBits > 7 应被拒绝
    var inBad: ASN1InputStream = ASN1InputStream(BERDecoder(), [0x03, 0x02, 0x08, 0xFF])
    var caught1: Bool = false
    try {
        inBad.readObject()
    } catch (e: ASN1ParseException) {
        caught1 = true
    }
    @Assert(caught1, true)

    // constructed BIT STRING 末分片的 unusedBits > 7 应被拒绝
    var inBadC: ASN1InputStream = ASN1InputStream(
        BERDecoder(),
        [0x23, 0x08, 0x03, 0x02, 0x00, 0xFF, 0x03, 0x02, 0x08, 0xAA]
    )
    var caught2: Bool = false
    try {
        inBadC.readObject()
    } catch (e: ASN1ParseException) {
        caught2 = true
    }
    @Assert(caught2, true)

    // 合法 constructed BIT STRING（unusedBits = 4）应正常解析
    var inOkC: ASN1InputStream = ASN1InputStream(
        BERDecoder(),
        [0x23, 0x08, 0x03, 0x02, 0x00, 0xFF, 0x03, 0x02, 0x04, 0xF0]
    )
    var objOkC: ASN1Object = inOkC.readObject()
    @Assert(objOkC is ASN1BitString, true)
    let bitsOkC: ASN1BitString = (objOkC as ASN1BitString).getOrThrow()
    @Assert(bitsOkC.unusedBits, 4)
    return 0
}
