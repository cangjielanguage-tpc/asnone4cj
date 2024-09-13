// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import asn1.*
import std.io.*

main() {
    let bytesBuf: Array<Byte> = Array<Byte>(10, repeat: 0)
    let asn = ASN1BitString(bytesBuf,6)
    let arr: Array<Bool> = Array<Bool>(5, repeat: true)
    ASN1BitString(arr)
    asn.getValue()
    let indd =asn.isSet(2)
    let src =asn.length()

    let tags = INTEGER
    let dec: BERDecoder = BERDecoder()
    let bitss = BitStringParser(dec)
    bitss.parse(tags,bytesBuf)

    if (indd != false) {
        return 1
    }
    if (src != 74) {
        return 2
    }
    return 0
}
