// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from asn1 import asn1.ASN1ParseException
from std import io.*

main() {
    let dec: ASN1ParseException = ASN1ParseException()
    let dec1: ASN1ParseException = ASN1ParseException("value in null")
    let src1: Array<ToString> = Array<ToString>()
    let src2: Array<ToString> = Array<ToString>(100, item: unsafe {zeroValue<ToString>()})

    let dec2: ASN1ParseException = ASN1ParseException("value in null",src1 )
    let dec3: ASN1ParseException = ASN1ParseException(Exception(),"value in null", src1)
    if (src2.size == 0) {
        return 1
    }
    return 0
}
