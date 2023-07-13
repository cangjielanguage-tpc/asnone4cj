// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from asn1 import asn1.ASN1ParseException
from std import io.*

main() {
    ASN1ParseException()
    ASN1ParseException("value in null")
    let src1: Array<ToString> = Array<ToString>()
    Array<ToString>(100, item: unsafe {zeroValue<ToString>()})

    ASN1ParseException("value in null",src1 )
    ASN1ParseException(Exception(),"value in null", src1)
    
    return 0
}
