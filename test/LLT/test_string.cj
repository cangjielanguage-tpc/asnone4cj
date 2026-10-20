// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import asn1.*
import std.collection.*
import std.unittest.*
import std.unittest.testmacro.*

main(): Int64 {
    var tag = BIT_STRING
    var bud: Array<Byte> = [1]

    var src = ASN1BitString(tag,bud,1)
    src.length()
    // getValueBytes 不抛异常，仅冒烟
    src.getValueBytes()
    return 0
}
