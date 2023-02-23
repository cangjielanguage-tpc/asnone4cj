// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from asn1 import asn1.ASN1Tag
from asn1 import asn1.ASN1OctetString
from std import io.*
from asn1 import asn1.*

main() {
    let Buf: Array<Byte> = [1]
    let Buf2: Array<Byte> = [0]
    let decs: ASN1OctetString = ASN1OctetString(Buf)
    let tags = INTEGER

    let dec1: ASN1OctetString = ASN1OctetString(tags,Buf)
    //let src = decs.getValue()
    let src2 = decs.valueString()
    let src3 = decs.length()
    //let src1 = (src as Array<Byte>).getOrThrow()
    //println(src1.size)
    println(src2)
    println(src3)
    if (src3 != 1) {
        return 1
    }
    return 0
}
