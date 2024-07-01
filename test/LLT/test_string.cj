// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from asn1 import asn1.*
from std import collection.*

main() {
    var tag = BIT_STRING
    var bud: Array<Byte> = [1]
 
    var src = ASN1BitString(tag,bud,1)
    src.length()
    var es: String = ""
    try {
        src.getValueBytes()
    } catch (e: Exception){
       es = e.toString()
    }
    
    return 0
}
