// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from asn1 import asn1.ASN1ParseException
from asn1 import asn1.types.primitive.ASN1Integer

main() {
    var value1: Int64 = 0
    var asn1Integer1: ASN1Integer<Int64> = ASN1Integer<Int64>(value1)
    try {
        asn1Integer1.getValue()
    } catch (e: ASN1ParseException) {
        return 1
    }
    var value2: Int64 = 1
    var asn1Integer2: ASN1Integer<Int64> = ASN1Integer<Int64>(value2, Array<Byte>())
    try {
        asn1Integer2.getValue()
    } catch (e: ASN1ParseException) {
        return 1
    }
    return 0
}
