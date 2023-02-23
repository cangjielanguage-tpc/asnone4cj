// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from asn1 import asn1.BERDecoder
from asn1 import asn1.ASN1Tag
from asn1 import asn1.OctetStringParser
from asn1 import asn1.OctetStringSerializer
from asn1 import asn1.BooleanParser
from asn1 import asn1.ASN1OutputStream
from asn1 import asn1.ASN1ParseException
from asn1 import asn1.ASN1PrimitiveValue
from asn1 import asn1.ASN1Enumerated
from asn1 import asn1.ASN1Sequence  
from asn1 import asn1.ASN1Object 
from asn1 import asn1.encodingrules.der.DEREncoder
from asn1 import asn1.*
from std import io.*
from std import collection.*

main() {

    let dec: DEREncoder = DEREncoder()

    let tags = INTEGER
    let decz: BERDecoder = BERDecoder()

    let oc = OctetStringParser(decz)
    oc.parse(tags,Array<Byte>())
    let oc1 = OctetStringSerializer(dec)

    let bitss = BooleanParser(decz)
    let Buf: Array<Byte> = [1]
    let ssc = bitss.parse(tags,Buf)
    try {
        let src = oc1.serializedLength(ssc)
    }catch(e: Exception) {
        println("pass")
    }

    let decodetd: DEREncoder = DEREncoder()
    let wrapped: ByteArrayStream = ByteArrayStream()
    let asn9 = ASN1OutputStream(decodetd,wrapped)
    
    try {
        let src1 = oc1.serialize(ssc,asn9)
    }catch(e: Exception) {
        println("pass")
    }
    let ssq = Array<ToString>(100, item: unsafe {zeroValue<ToString>()})
    ASN1ParseException(Exception(), "asdda", ssq)

    let srp: ASN1PrimitiveValue  = ASN1Enumerated(6)
    srp.valueHash()
    let objs =ArrayList<ASN1Object>()
    objs.append(ssc)
    let buu: Array<Byte> = [1,6] 
    let sml = ASN1Sequence(objs,buu)
    if (ssq.size != 100) {
        return 1
    }
    return 0
}
