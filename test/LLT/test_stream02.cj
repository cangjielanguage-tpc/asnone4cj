// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from asn1 import asn1.*
from std import io.*

main() {
    let decodetd: DEREncoder = DEREncoder()
    let wrapped: ByteArrayStream = ByteArrayStream()
    let asn = ASN1OutputStream(decodetd,wrapped)
    let bytesBuf: Array<Byte> = Array<Byte>(10, item: 0)
   
    asn.write(bytesBuf)
    asn.write(6)
    asn.write(6)
    let tags = INTEGER
    let dec: BERDecoder = BERDecoder()
    let bitss = BooleanParser(dec)
    let Buf: Array<Byte> = [1]
    let ssc = bitss.parse(tags,Buf)
    var es: String = ""
    try {
        asn.writeObject(ssc)
    } catch (e: Exception) {
        es = e.toString()
    }
    return 0
}
