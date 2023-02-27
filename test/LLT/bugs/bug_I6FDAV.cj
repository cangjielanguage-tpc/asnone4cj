// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from asn1 import asn1.ASN1BitString
from asn1 import asn1.ASN1Enumerated
from asn1 import asn1.ASN1Tag
from asn1 import asn1.ASN1TaggedObject
from asn1 import asn1.ASN1Boolean
from std import io.*
from asn1 import asn1.*
from std import collection.*
from std import time.*

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
