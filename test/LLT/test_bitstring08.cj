// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from asn1 import asn1.BERDecoder
from asn1 import asn1.ASN1Tag
from asn1 import asn1.ASN1OutputStream
from asn1 import asn1.ASN1Object 
from asn1 import asn1.BooleanParser 
from asn1 import asn1.encodingrules.der.DEREncoder   
from std import io.*
from std import collection.*

main() {

    let dec: DEREncoder = DEREncoder()
    let decz: BERDecoder = BERDecoder()
    let tags = ASN1Tag.ASN1_BOOLEAN
    tags.newParser(decz)
    tags.newSerializer(dec)
    let tags1 = ASN1Tag.INTEGER
    tags1.newParser(decz)
    tags1.newSerializer(dec)
    let tags2 = ASN1Tag.BIT_STRING
    tags2.newParser(decz)
    tags2.newSerializer(dec)
    let tags3 = ASN1Tag.OCTET_STRING
    tags3.newParser(decz)
    tags3.newSerializer(dec)
    let tags4 = ASN1Tag.ASN1_NULL_TAG
    tags4.newParser(decz)
    tags4.newSerializer(dec)
    let tags5 = ASN1Tag.OBJECT_IDENTIFIER
    tags5.newParser(decz)
    tags5.newSerializer(dec)
    let tags6 = ASN1Tag.ENUMERATED
    tags6.newParser(decz)
    tags6.newSerializer(dec)
    let tags7 = ASN1Tag.SET
    tags7.newParser(decz)
    tags7.newSerializer(dec)
    let tags8 = ASN1Tag.SEQUENCE
    tags8.newParser(decz)
    tags8.newSerializer(dec)

    
    let tags9 = ASN1Tag.application(6)
    let srcp1 = tags9.hashCode()
    tags9.toString()
    let tags10 = ASN1Tag.contextSpecific(6)
    let srcp2 = tags10.hashCode()
    tags10.toString()

    let bitss = BooleanParser(decz)
    let Buf: Array<Byte> = [1]
    let ssc = bitss.parse(tags,Buf)

    let decodetd: DEREncoder = DEREncoder()
    let wrapped: ByteArrayStream = ByteArrayStream()
    let asn9 = ASN1OutputStream(decodetd,wrapped)
    println(srcp1)
    println(srcp2)
    if (srcp1 != -1145102874) {
        return 1
    }
    if (srcp2 != -331425620) {
        return 1
    }
    return 0
}
