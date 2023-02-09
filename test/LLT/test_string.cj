// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from asn1 import asn1.ASN1BitString
from asn1 import asn1.ASN1String
from asn1 import asn1.ASN1Tag

from std import collection.*

main() {
    var tag = ASN1Tag.BIT_STRING
    var bud: Array<Byte> = [1]
 
    var src = ASN1BitString(tag,bud,1)
    let src1 = src.length()
    var es: String = ""
    try {
        let src3 = src.getValueBytes()
    } catch (e: Exception){
       es = e.toString()
    }
    if(bud.size == 0){
        return 1
    }
    return 0
}
