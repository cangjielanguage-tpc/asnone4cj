// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import std.io.*
import asn1.*
import std.collection.*
import std.time.*

main() {
    let tag = ASN1_BOOLEAN
    let sc = ASN1TaggedObject(tag, ASN1Boolean(false), false)
    let src = sc.toString()
    println(src)

    if (src != "ASN1TaggedObject[ASN1Tag[UNIVERSAL,PRIMITIVE,1],ASN1Object[ASN1Tag[UNIVERSAL,PRIMITIVE,1]]]") {
        return 1
    }
    return 0
}
