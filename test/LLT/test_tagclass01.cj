// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import asn1.*
import std.collection.*
import std.unittest.*
import std.unittest.testmacro.*

main(): Int64 {
    ASN1TagClass.parseClass(192)
    ASN1TagClass.parseClass(180)
    ASN1TagClass.parseClass(100)
    ASN1TagClass.parseClass(1)

    // 非法 class 值调用 getValue 应抛异常
    var caught1: Bool = false
    try {
        ASN1TagClass.UNIVERSAL(1).getValue()
    } catch (e: Exception) {
        caught1 = true
    }
    @Assert(caught1, true)

    var caught2: Bool = false
    try {
        ASN1TagClass.APPLICATION(0).getValue()
    } catch (e: Exception) {
        caught2 = true
    }
    @Assert(caught2, true)

    let sv2 = ASN1TagClass.APPLICATION(0x40).getValue()

    let sv3 = ASN1TagClass.CONTEXT_SPECIFIC(0x80).getValue()

    var caught3: Bool = false
    try {
        ASN1TagClass.CONTEXT_SPECIFIC(0).getValue()
    } catch (e: Exception) {
        caught3 = true
    }
    @Assert(caught3, true)

    let sv5 = ASN1TagClass.PRIVATE(0xc0).getValue()

    var caught4: Bool = false
    try {
        ASN1TagClass.PRIVATE(0).getValue()
    } catch (e: Exception) {
        caught4 = true
    }
    @Assert(caught4, true)

    let buf: Array<ToString> = Array<ToString>(100, repeat: unsafe {zeroValue<ToString>()})

    var caught5: Bool = false
    try {
        Checks.checkState(false, "abcd", buf)
    } catch (e: Exception) {
        caught5 = true
    }
    @Assert(caught5, true)

    var caught6: Bool = false
    try {
        Checks.checkArgument(false, "abcd", buf)
    } catch (e: Exception) {
        caught6 = true
    }
    @Assert(caught6, true)

    @Assert(sv2, 64)
    @Assert(sv3, 128)
    @Assert(sv5, 192)
    return 0
}
