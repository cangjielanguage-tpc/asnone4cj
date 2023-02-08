// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from asn1 import asn1.BERDecoder
from asn1 import asn1.encodingrules.der.DEREncoder
from asn1 import asn1.ASN1OutputStream 
from asn1 import asn1.ASN1Tag
from asn1 import asn1.BooleanParser
from std import io.*

main() {
    let decodetd: DEREncoder = DEREncoder()
    let wrapped: ByteArrayStream = ByteArrayStream()
    let asn = ASN1OutputStream(decodetd,wrapped)
    let bytesBuf: Array<Byte> = Array<Byte>(10, item: 0)
   
    let src = asn.write(bytesBuf)
    let src1 = asn.write(6)
    let src2 = asn.write(6)
    let tags = ASN1Tag.INTEGER
    let dec: BERDecoder = BERDecoder()
    let bitss = BooleanParser(dec)
    let Buf: Array<Byte> = [1]
    let ssc = bitss.parse(tags,Buf)
    var es: String = ""
    try {
        let asnob = asn.writeObject(ssc)
    } catch (e: Exception) {
        es = e.toString()
    }
    return 0
}
