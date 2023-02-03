// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from asn1 import asn1.ASN1ParseException
from asn1 import asn1.types.primitive.ASN1Integer
from cryptocj import bignumcj.BIGNUM
from cryptocj import bignumcj.bnNew
from cryptocj import bignumcj.bnGetWord
from cryptocj import bignumcj.bnSetWord

main() {
    var value1: CPointer<BIGNUM> = bnNew()

    bnSetWord(value1, 1)
    var asn1Integer1: ASN1Integer = ASN1Integer(value1)
    try {
        asn1Integer1.getValue()
    } catch (e: ASN1ParseException) {
        return 1
    }
    var value2: CPointer<BIGNUM> = bnNew()
    bnSetWord(value2, 2)
    var asn1Integer2: ASN1Integer = ASN1Integer(value2, Array<Byte>())
    try {
        asn1Integer2.getValue()
    } catch (e: ASN1ParseException) {
        return 1
    }
    return 0
}
