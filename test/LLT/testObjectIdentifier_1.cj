// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from asn1 import asn1.ASN1ParseException
from asn1 import asn1.types.primitive.ASN1ObjectIdentifier

main() {
    var value1: String = ""
    var asn1ObjectIdentifier1: ASN1ObjectIdentifier<String> = ASN1ObjectIdentifier<String>(value1)
    try {
        asn1ObjectIdentifier1.getValue()
    } catch (e: ASN1ParseException) {
        return 1
    }
    var value2: String = ""
    var asn1ObjectIdentifier2: ASN1ObjectIdentifier<String> = ASN1ObjectIdentifier<String>(value2, Array<Byte>())
    try {
        asn1ObjectIdentifier2.getValue()
    } catch (e: ASN1ParseException) {
        return 1
    }
    return 0
}
