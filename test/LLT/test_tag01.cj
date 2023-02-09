// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from asn1 import asn1.ASN1BitString
from asn1 import asn1.ASN1String
from asn1 import asn1.ASN1Tag

from std import collection.*

main() {
    var tag = ASN1Tag.BIT_STRING
    var bud: Array<Byte> = [1]
    tag.constructed()
    tag.primitive()
    let sc =ASN1Tag.application(1)
    let sc1 =ASN1Tag.contextSpecific(1)
    let src = tag.hashCode()

    let tag1 = ASN1Tag.ASN1_BOOLEAN

    if (src != -489378674) {
        return 1
    }

    return 0
}
