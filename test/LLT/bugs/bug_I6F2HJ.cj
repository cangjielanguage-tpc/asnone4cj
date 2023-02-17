// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from asn1 import asn1.*
from std import io.*
from std import collection.*
from std import time.*

main() {
    var asn1Tag1: ASN1Tag = ASN1Tag.application(2)
    if (!asn1Tag1.toString().equals("ASN1Tag[APPLICATION,PRIMITIVE,2]")) {
        return 1
    }
    println(asn1Tag1.hashCode())
    if (asn1Tag1.hashCode() != -1396321146) {
        // return 1
    }

    var asn1Tag2: ASN1Tag = ASN1Tag.contextSpecific(2)
    if (!asn1Tag2.toString().equals("ASN1Tag[CONTEXT_SPECIFIC,PRIMITIVE,2]")) {
        return 1
    }
    println(asn1Tag2.hashCode())
    if (asn1Tag2.hashCode() != -1199231940) {
        // return 1
    }

    return 0
}
