// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from asn1 import asn1.BERDecoder
from asn1 import asn1.ASN1Tag
from asn1 import asn1.ASN1OutputStream
from asn1 import asn1.ASN1Object 
from asn1 import asn1.BooleanParser 
from asn1 import asn1.ASN1TaggedObject 
from asn1 import asn1.types.ASN1Encoding 
from asn1 import asn1.types.ASN1TagClass 
from asn1 import asn1.ASN1TaggedObjectTag 
from asn1 import asn1.BitStringSerializer 
from asn1 import asn1.encodingrules.der.DEREncoder
from asn1 import asn1.*
from std import io.* 
from std import collection.*

main() {

    let dec: DEREncoder = DEREncoder()
    let decz: BERDecoder = BERDecoder()
    let tags = ASN1_BOOLEAN

    let bitss = BooleanParser(decz)
    let Buf: Array<Byte> = [1]
    let ssc = bitss.parse(tags,Buf)

    let decodetd: DEREncoder = DEREncoder()
    let wrapped: ByteArrayStream = ByteArrayStream()
    let asn9 = ASN1OutputStream(decodetd,wrapped)
    let sp1 = BitStringSerializer(dec)
    try {
        let srncn = sp1.serializedLength(ssc)
    }catch(e: Exception) {
        println("pass")
    }
    try {
        let srncn2 = sp1.serialize(ssc,asn9)
    }catch(e: Exception) {
        println("pass")
    }

    let sle = ASN1TaggedObject(tags,Array<Byte>(),decz)
    
    try {
        let src = sle.iterator()
    }catch(e: Exception) {
        println("pass")
    }

    let tagg1 = ASN1TaggedObjectTag(ASN1TagClass.UNIVERSAL(0),0x03,HashSet<ASN1Encoding>([ASN1Encoding.PRIMITIVE(0x0), ASN1Encoding.CONSTRUCTED(0x20)]))
    
    let op1 =tagg1.newParser(decz)
    op1.parse(tags,Array<Byte>())
    let op2 =tagg1.newSerializer(dec)
    try {
        let src10 = op2.serializedLength(ssc)
    }catch(e: Exception) {
        println("pass")
    }
     try {
        let src11 = op2.serialize(ssc,asn9)
    }catch(e: Exception) {
        println("pass11")
    }
    if (Buf.size != 1) {
        return 1
    }
    return 0
}
