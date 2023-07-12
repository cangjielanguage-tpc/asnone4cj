// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from asn1 import asn1.ASN1Tag
from asn1 import asn1.ASN1TaggedObject
from asn1 import asn1.ASN1Null
from asn1 import asn1.ASN1ObjectIdentifier
from asn1 import asn1.ASN1Object
from asn1 import asn1.ASN1Sequence
from asn1 import asn1.ASN1Enumerated
from asn1 import asn1.ASN1Boolean
from asn1 import asn1.ASN1Integer
from asn1 import asn1.*
from std import io.*
from std import collection.*
from std import time.*

main() {
    let tag = ASN1_NULL_TAG
    let sc = ASN1TaggedObject(tag, ASN1Null(), false)
    let src = sc.toString()

    let tag1 = OBJECT_IDENTIFIER
    let sc1 = ASN1TaggedObject(tag1, ASN1ObjectIdentifier("1.3.4"), false)

    let tag2 = SEQUENCE
    var arr = ArrayList<ASN1Object>([ASN1Boolean(true), ASN1Integer(1), ASN1Boolean(false), ASN1Integer(2)])
    var arr2 = ASN1Sequence(arr)
    ASN1TaggedObject(tag2, arr2, false)

    let tag3 = ENUMERATED
    ASN1TaggedObject(tag3, ASN1Enumerated(20), false)

    if (src != "ASN1TaggedObject[ASN1Tag[UNIVERSAL,PRIMITIVE,5],ASN1Object[ASN1Tag[UNIVERSAL,PRIMITIVE,5]]]") {
        return 1
    }
    if (sc1.toString().size != 91) {
        return 2
    }
    return 0
}
