// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from asn1 import asn1.EnumeratedSerializer
from asn1 import asn1.BERDecoder
from asn1 import asn1.ASN1OutputStream
from asn1 import asn1.ASN1Tag
from asn1 import asn1.ASN1Boolean
from asn1 import asn1.ASN1Sequence
from asn1 import asn1.ASN1Object
from asn1 import asn1.ASN1Set
from asn1 import asn1.encodingrules.der.DEREncoder   
from std import io.*
from asn1 import asn1.*
from std import collection.*

main() {
    BERDecoder()
    let tag = SEQUENCE
    let decs: DEREncoder = DEREncoder()

    let str = tag.newSerializer(decs)
    let arr:ArrayList<ASN1Object> = ArrayList<ASN1Object>()
    arr.append(ASN1Boolean(true))
    arr.append(ASN1Boolean(false))
    let sc = ASN1Sequence(arr)
    let resu = str.serializedLength(sc) 
    let wrapped: ByteArrayStream = ByteArrayStream()
    let asn = ASN1OutputStream(decs,wrapped)
    str.serialize(sc,asn) 
    
    let tags = SET
    let str1 = tags.newSerializer(decs)
    let buf = HashSet<ASN1Object>()
    buf.put(ASN1Boolean(false))
    buf.put(ASN1Boolean(true))
    buf.put(ASN1Boolean(true))

    let sc1 = ASN1Set(buf)
    let resu1 = str1.serializedLength(sc1)
    str1.serialize(sc1,asn)
    if ( resu != 6){
        return 1
    }
    if ( resu1 != 9){
        return 2
    }
    return 0  
}
