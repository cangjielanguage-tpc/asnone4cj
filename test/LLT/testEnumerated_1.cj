// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from asn1 import asn1.ASN1ParseException
from asn1 import asn1.ASN1Enumerated
from numeric import bigint.*

main() {
    var value1: BigInt = BigInt(1)
    var asn1Enumerated1: ASN1Enumerated = ASN1Enumerated(value1)
    try {
        asn1Enumerated1.getValue()
    } catch (e: ASN1ParseException) {
        return 1
    }
    var value2: BigInt =BigInt(2)
    var asn1Enumerated2: ASN1Enumerated = ASN1Enumerated(value2, Array<Byte>())
    try {
        asn1Enumerated2.getValue()
    } catch (e: ASN1ParseException) {
        return 1
    }
    return 0
}
