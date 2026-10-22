// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import asn1.*
import std.collection.*
import std.unittest.*
import std.unittest.testmacro.*

main(): Int64 {
    var tag = BIT_STRING
    tag.constructed()
    tag.primitive()
    ASN1Tag.application(1)
    ASN1Tag.contextSpecific(1)
    let src = tag.hashCode()

    @Assert(src != 0, true)

    // 同类型同值 tag 相等
    @Assert(INTEGER.equals(INTEGER), true)
    @Assert(INTEGER.equals(BIT_STRING), false)
    // 跨具体类型的同号 tag 不相等（对齐上游 getClass() 判断）
    let allTag: ASN1Tag = OCTET_STRING.constructed().primitive()
    @Assert(allTag.equals(OCTET_STRING), false)
    @Assert(OCTET_STRING.equals(allTag), false)
    return 0
}
