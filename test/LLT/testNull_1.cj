// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from asn1 import asn1.ASN1ParseException
from asn1 import asn1.types.primitive.ASN1Null

main() {
    var asn1Null1: ASN1Null = ASN1Null()
    try {
        asn1Null1.getValue()
    } catch (e: ASN1ParseException) {
        return 1
    }
    return 0
}
