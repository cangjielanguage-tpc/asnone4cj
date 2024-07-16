// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import asn1.*
import std.collection.*

main() {
    var tag = BIT_STRING
    tag.constructed()
    tag.primitive()
    ASN1Tag.application(1)
    ASN1Tag.contextSpecific(1)
    let src = tag.hashCode()

    if (src == 0) {
        return 1
    }

    return 0
}
