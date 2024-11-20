// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import asn1.*
import std.io.*
import std.collection.*

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
        oc1.serializedLength(ssc)
    }catch(e: Exception) {
        println("pass")
    }

    let decodetd: DEREncoder = DEREncoder()
    let wrapped: ByteArrayStream = ByteArrayStream()
    let asn9 = ASN1OutputStream(decodetd,wrapped)
    
    try {
        oc1.serialize(ssc,asn9)
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
    ASN1Sequence(objs,buu)
    
    return 0
}
