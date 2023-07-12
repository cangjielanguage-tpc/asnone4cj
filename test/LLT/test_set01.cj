// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from asn1 import asn1.ASN1Object
from asn1 import asn1.ASN1Set 
from asn1 import asn1.BitStringParser
from asn1 import asn1.ASN1Tag

from std import collection.*

main() {
    var arr = HashSet<ASN1Object>()
    let buf: Array<Byte> = [1]
    var sets = ASN1Set(arr,buf)
    ASN1Set(arr)

    let src = sets.getValue()
    sets.iterator()

    println(src.size)
    if (src.size != 0){
        return 1
    }

    return 0
}
