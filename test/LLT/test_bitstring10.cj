// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import std.io.*
import asn1.*
import std.collection.*

main() {
    let decz: BERDecoder = BERDecoder()
    DEREncoder()
    let arr: Array<Bool> = Array<Bool>(80, repeat: true)
    ASN1BitString(arr)
    let srt = BitStringParser(decz)
    let tag = SEQUENCE
    tag.isConstructed()
    let buf = Array<Byte>(80, repeat: 1)
    try {
        srt.parse(tag,buf)
    }catch(e: Exception) {
        println("pass")
    }
    ASN1InputStream(decz, buf)
    if (tag.isConstructed()){
        return 0
    }
    let src11 = ObjectIdentifierParser(decz)
    try {
        let arr: Array<Byte> = [128,128,128,128,128]
        src11.parse(tag, arr)
    }catch(e : Exception){
        println("pass")
    }
    return 1
}
