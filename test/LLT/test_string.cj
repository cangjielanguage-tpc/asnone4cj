// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import asn1.*
import std.collection.*

main() {
    var tag = BIT_STRING
    var bud: Array<Byte> = [1]
 
    var src = ASN1BitString(tag,bud,1)
    src.length()
    try {
        src.getValueBytes()
    } catch (_: Exception){
    }
    
    return 0
}
