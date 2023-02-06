// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from asn1 import asn1.types.ASN1ParseException
from asn1 import asn1.types.primitive.ASN1Enumerated
from cryptocj import bignumcj.BIGNUM
from cryptocj import bignumcj.bnNew
from cryptocj import bignumcj.bnGetWord
from cryptocj import bignumcj.bnSetWord

main() {
    var value1: CPointer<BIGNUM> = bnNew()
    bnSetWord(value1, 1)
    var asn1Enumerated1: ASN1Enumerated = ASN1Enumerated(value1)
    try {
        asn1Enumerated1.getValue()
    } catch (e: ASN1ParseException) {
        return 1
    }
    var value2: CPointer<BIGNUM> = bnNew()
    bnSetWord(value2, 2)
    var asn1Enumerated2: ASN1Enumerated = ASN1Enumerated(value2, Array<Byte>())
    try {
        asn1Enumerated2.getValue()
    } catch (e: ASN1ParseException) {
        return 1
    }
    return 0
}
