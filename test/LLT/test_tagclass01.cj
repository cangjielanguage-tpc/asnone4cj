// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import asn1.*
import std.collection.*

main() {

    ASN1TagClass.parseClass(192)
    ASN1TagClass.parseClass(180)
    ASN1TagClass.parseClass(100)
    ASN1TagClass.parseClass(1)
    
    try {
        ASN1TagClass.UNIVERSAL(1).getValue()
    } catch(e: Exception){
        println("pass")
    }
    try {
        ASN1TagClass.APPLICATION(0).getValue()
    } catch(e: Exception){
        println("pass")
    }
    
    let sv2 = ASN1TagClass.APPLICATION(0x40).getValue()
    
    let sv3 = ASN1TagClass.CONTEXT_SPECIFIC(0x80).getValue()
    try {
        ASN1TagClass.CONTEXT_SPECIFIC(0).getValue()
    } catch(e: Exception){
        println("pass")
    }
    
    let sv5 = ASN1TagClass.PRIVATE(0xc0).getValue()
    try {
        ASN1TagClass.PRIVATE(0).getValue()
    } catch(e: Exception){
        println("pass")
    }
    let buf: Array<ToString> =Array<ToString>(100, item: unsafe {zeroValue<ToString>()})
    
    try {
        Checks.checkState(false, "abcd", buf)
    } catch(e: Exception){
        println("pass")
    }
    try {
        Checks.checkArgument(false, "abcd", buf)
    } catch(e: Exception){
        println("pass")
    }
    
    if (sv2 != 64) {
        return 1
    }
    if (sv3 != 128) {
        return 2
    }
    if (sv5 != 192) {
        return 3
    }
    return 0
}
