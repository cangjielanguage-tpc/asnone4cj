// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from asn1 import asn1.*
from std import io.*
from std import collection.*
from std import time.*

main() {
    var asn1Tag1: ASN1Tag = ASN1Tag.application(2)
    if (asn1Tag1.toString()!="ASN1Tag[APPLICATION,PRIMITIVE,2]") {
        return 1
    }

    var asn1Tag2: ASN1Tag = ASN1Tag.contextSpecific(2)
    if (asn1Tag2.toString()!="ASN1Tag[CONTEXT_SPECIFIC,PRIMITIVE,2]") {
        return 1
    }

    return 0
}
