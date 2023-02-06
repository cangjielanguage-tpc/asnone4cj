// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from std import collection.ArrayList
from asn1 import asn1.types.constructed.ASN1Sequence
from asn1 import asn1.types.ASN1Object
from asn1 import asn1.types.ASN1ParseException

main() {
    var arr = ArrayList<ASN1Object>()
    var seq = ASN1Sequence(arr)
    try {
        seq.getValue()
        for (i in seq) {
            println(i.equals(i))
        }
    } catch (e: ASN1ParseException) {
        return 1
    }
    return 0
}