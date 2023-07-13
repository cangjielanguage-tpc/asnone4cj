// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from asn1 import asn1.BooleanParser
from asn1 import asn1.BERDecoder
from asn1 import asn1.BitStringParser
from asn1 import asn1.ASN1OutputStream
from asn1 import asn1.BitStringSerializer
from asn1 import asn1.ASN1BitString
from asn1 import asn1.ASN1Tag
from asn1 import asn1.encodingrules.der.DEREncoder
from std import io.*

main() {

    let decodetd: DEREncoder = DEREncoder()


    let wrapped: ByteArrayStream = ByteArrayStream()
    ASN1OutputStream(decodetd,wrapped)

    BitStringSerializer(decodetd)

    let bytesBuf: Array<Byte> = Array<Byte>(10, item: 0)
    ASN1BitString(bytesBuf,6)

    if (bytesBuf.size != 0) {
        return 0
    }
    return 1
}
