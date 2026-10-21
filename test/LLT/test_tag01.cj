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
    return 0
}
