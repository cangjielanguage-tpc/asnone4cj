// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import asn1.*
import std.collection.*

main() {
    var arr = ArrayList<ASN1Object>()
    var seq = ASN1Sequence(arr)
    let src = seq.size()
    var es: String = ""
    try {
        seq.get(1)
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
