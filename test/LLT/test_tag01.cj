// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from asn1 import asn1.ASN1BitString
from asn1 import asn1.ASN1String
from asn1 import asn1.ASN1Tag
from asn1 import asn1.*
from std import collection.*

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
