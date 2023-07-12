// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from asn1 import asn1.EnumeratedSerializer
from asn1 import asn1.BERDecoder
from asn1 import asn1.ASN1Tag
from asn1 import asn1.ASN1Null
from asn1 import asn1.ASN1Integer
from asn1 import asn1.NullSerializer
from asn1 import asn1.IntegerSerializer
from asn1 import asn1.BooleanParser
from asn1 import asn1.ASN1OutputStream
from asn1 import asn1.encodingrules.der.DEREncoder
from std import io.*
from asn1 import asn1.*

main() {
    let dec: DEREncoder = DEREncoder()

    let tags = INTEGER
    let decz: BERDecoder = BERDecoder()
    let bitss = BooleanParser(decz)
    let Buf: Array<Byte> = [1]
    let ssc = bitss.parse(tags,Buf)

    let enu = EnumeratedSerializer(dec)
    try {
        enu.serializedLength(ssc)
    }catch(e: Exception) {
        println("pass")
    }
    let decodetd: DEREncoder = DEREncoder()
    let wrapped: ByteArrayStream = ByteArrayStream()
    let asn = ASN1OutputStream(decodetd,wrapped)
    try {
        enu.serialize(ssc,asn)
    }catch(e: Exception) {
        println("pass")
    }
    let ssc3 = ASN1Integer(6)
    let ssc4 = ssc3.valueHash()
    let srv = IntegerSerializer(decodetd)
    try {
        srv.serializedLength(ssc)
    }catch(e: Exception) {
        println("pass")
    }
    try {
        srv.serialize(ssc,asn)
    }catch(e: Exception) {
        println("pass")
    }
    
    let srt = ASN1Null()
    srt.valueHash()
    let srt1 = NullSerializer(decodetd)
    srt1.serializedLength(ssc)
    srt1.serialize(ssc,asn)
    if(ssc4 != 6) {
        return 2
    }
    return 0
}


