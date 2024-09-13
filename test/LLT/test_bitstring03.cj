// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import asn1.*
import std.io.*

main() {

    let arr: Array<Bool> = Array<Bool>(5, repeat: true)
    let asn1 = ASN1BitString(arr)
    let str = asn1.valueString()
    let asse = DEREncoder()
    BitStringSerializer(asse)
    
    let tag = BIT_STRING
    let dec: BERDecoder = BERDecoder()
    let buf:  Array<Byte> = [1,1]
    let bitss = BitStringParser(dec)
    bitss.parse(tag,buf)

    let bols = ASN1Boolean(true)
    let bols1 = ASN1Boolean(false)
    bols.valueHash()
    bols1.valueHash()
    if (str.size != 30) {
        return 1
    }
    return 0
}


