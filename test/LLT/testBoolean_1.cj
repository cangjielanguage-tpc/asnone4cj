// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from asn1 import asn1.ASN1ParseException
from asn1 import asn1.types.primitive.ASN1Boolean

main() {
    var value1: Bool = false
    var asn1Boolean1: ASN1Boolean<Bool> = ASN1Boolean<Bool>(value1)
    try {
        asn1Boolean1.getValue()
    } catch (e: ASN1ParseException) {
        return 1
    }
    var value2: Bool = true
    var asn1Boolean2: ASN1Boolean<Bool> = ASN1Boolean<Bool>(value2, Array<Byte>())
    try {
        asn1Boolean2.getValue()
    } catch (e: ASN1ParseException) {
        return 1
    }
    return 0
}
