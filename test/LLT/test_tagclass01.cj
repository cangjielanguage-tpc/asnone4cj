// EXEC: cjc %import-path %L %l %f
// EXEC: ./main


from asn1 import asn1.types.ASN1TagClass
from asn1 import asn1.util.Checks

from std import collection.*

main() {

    let srce = ASN1TagClass.parseClass(192)
    let srce1 = ASN1TagClass.parseClass(180)
    let srce2 = ASN1TagClass.parseClass(100)
    let srce3 = ASN1TagClass.parseClass(1)
    let sq = (255 & 0xc0)
    
    try {
        let sv = ASN1TagClass.UNIVERSAL(1).getValue()
    } catch(e: Exception){
        println("pass")
    }
    try {
        let sv1 = ASN1TagClass.APPLICATION(0).getValue()
    } catch(e: Exception){
        println("pass")
    }
    
    let sv2 = ASN1TagClass.APPLICATION(0x40).getValue()
    
    let sv3 = ASN1TagClass.CONTEXT_SPECIFIC(0x80).getValue()
    try {
        let sv4 = ASN1TagClass.CONTEXT_SPECIFIC(0).getValue()
    } catch(e: Exception){
        println("pass")
    }
    
    let sv5 = ASN1TagClass.PRIVATE(0xc0).getValue()
    try {
        let sv6 = ASN1TagClass.PRIVATE(0).getValue()
    } catch(e: Exception){
        println("pass")
    }
    let buf: Array<ToString> =Array<ToString>(100, item: unsafe {zeroValue<ToString>()})
    
    try {
        let src = Checks.checkState(false, "abcd", buf)
    } catch(e: Exception){
        println("pass")
    }
    try {
        let src = Checks.checkArgument(false, "abcd", buf)
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
