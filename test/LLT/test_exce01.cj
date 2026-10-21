// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import asn1.*
import std.io.*
import std.unittest.*
import std.unittest.testmacro.*

main(): Int64 {
    ASN1ParseException()
    ASN1ParseException("value in null")
    let src1: Array<ToString> = Array<ToString>()

    ASN1ParseException("value in null",src1)
    ASN1ParseException(Exception(),"value in null", src1)
    return 0
}
