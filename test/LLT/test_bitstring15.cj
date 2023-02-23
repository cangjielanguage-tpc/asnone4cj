// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from asn1 import asn1.EnumeratedSerializer
from asn1 import asn1.BERDecoder
from asn1 import asn1.ASN1OutputStream
from asn1 import asn1.ASN1Tag
from asn1 import asn1.ASN1TaggedObjectTag
from asn1 import asn1.ASN1Boolean
from asn1 import asn1.ASN1TaggedObject
from asn1 import asn1.types.ASN1Encoding
from asn1 import asn1.types.ASN1TagClass
from asn1 import asn1.encodingrules.der.DEREncoder   
from std import io.*
from asn1 import asn1.*
from std import collection.*

main() {
    let dec: BERDecoder = BERDecoder()
    let wrapped: ByteArrayStream = ByteArrayStream()
    var buf = Array<Byte>(10, item: 63)
    wrapped.write(buf)

    let tag = SET
    let str = ASN1TaggedObject(tag,ASN1Boolean(true))
    let decs: DEREncoder = DEREncoder()
    let arr = HashSet<ASN1Encoding>([ASN1Encoding.PRIMITIVE(0x0), ASN1Encoding.CONSTRUCTED(0x20)])
    let tagss = ASN1TaggedObjectTag(ASN1TagClass.UNIVERSAL(0),0x0A,arr)
    let sc  = tagss.newSerializer(decs)
    let result = sc.serializedLength(str)
    println(result)
    try {
        let tag = dec.readTag(wrapped)
    }catch(e: Exception) {
        return 0
    }
    return 1  
}
