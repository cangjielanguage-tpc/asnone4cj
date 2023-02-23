// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from asn1 import asn1.BERDecoder
from asn1 import asn1.ASN1Tag
from asn1 import asn1.ASN1BitString
from asn1 import asn1.BitStringParser
from asn1 import asn1.BitStringSerializer
from asn1 import asn1.ASN1InputStream  
from asn1 import asn1.ObjectIdentifierParser  
from asn1 import asn1.encodingrules.der.DEREncoder   
from std import io.*
from asn1 import asn1.*
from std import collection.*

main() {
    let decz: BERDecoder = BERDecoder()
    let dec: DEREncoder = DEREncoder()
    let arr: Array<Bool> = Array<Bool>(80, item: true)
    let src = ASN1BitString(arr)
    let srt = BitStringParser(decz)
    let tag = SEQUENCE
    let sp = tag.isConstructed()
    let buf = Array<Byte>(80, item: 1)
    try {
        let src = srt.parse(tag,buf)
    }catch(e: Exception) {
        println("pass")
    }
    var stream: ASN1InputStream = ASN1InputStream(decz, buf)
    if (tag.isConstructed()){
        return 0
    }
    let src11 = ObjectIdentifierParser(decz)
    try {
        let arr: Array<Byte> = [128,128,128,128,128]
        let ssc9 = src11.parse(tag, arr)
    }catch(e : Exception){
        println("pass")
    }
    return 1
}
