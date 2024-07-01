// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from std import io.*
from asn1 import asn1.*
from std import collection.*

main() {

    let dec: DEREncoder = DEREncoder()
    let decz: BERDecoder = BERDecoder()
    let tags = ASN1_BOOLEAN
    tags.newParser(decz)
    tags.newSerializer(dec)
    let tags1 = INTEGER
    tags1.newParser(decz)
    tags1.newSerializer(dec)
    let tags2 = BIT_STRING
    tags2.newParser(decz)
    tags2.newSerializer(dec)
    let tags3 = OCTET_STRING
    tags3.newParser(decz)
    tags3.newSerializer(dec)
    let tags4 = ASN1_NULL_TAG
    tags4.newParser(decz)
    tags4.newSerializer(dec)
    let tags5 = OBJECT_IDENTIFIER
    tags5.newParser(decz)
    tags5.newSerializer(dec)
    let tags6 = ENUMERATED
    tags6.newParser(decz)
    tags6.newSerializer(dec)
    let tags7 = SET
    tags7.newParser(decz)
    tags7.newSerializer(dec)
    let tags8 = SEQUENCE
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
    bitss.parse(tags,Buf)

    let decodetd: DEREncoder = DEREncoder()
    let wrapped: ByteArrayStream = ByteArrayStream()
    ASN1OutputStream(decodetd,wrapped)
    println(srcp1)
    println(srcp2)
    if (srcp1 == 0) {
        return 1
    }
    if (srcp2 == 0) {
        return 1
    }

    return 0
}
