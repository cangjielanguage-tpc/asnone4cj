// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from asn1 import asn1.ASN1Object
from asn1 import asn1.ASN1Sequence
from asn1 import asn1.BitStringParser
from asn1 import asn1.ASN1Tag

from std import collection.*

main() {
    var arr = ArrayList<ASN1Object>()
    var seq = ASN1Sequence(arr)
    let src = seq.size()
    var es: String = ""
    try {
        let src1 = seq.get(1)
    } catch (e: Exception){
       es = e.toString()
    }
    
    if (src != 0){
        return 1
    }
    if(es != "IndexOutOfBoundsException: index: 1, size: 0") {
        return 2
    }
    return 0
}
