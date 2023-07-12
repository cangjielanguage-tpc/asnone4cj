// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from asn1 import asn1.*
from asn1 import asn1.types.*
from asn1 import asn1.util.*
from asn1 import asn1.encodingrules.*
from asn1 import asn1.encodingrules.der.*
from std import io.*
from asn1 import asn1.util.BigInt

main(): Int64 {
    var asn1Enumerated: ASN1Enumerated = ASN1Enumerated(-9)
    var bigint: BigInt = (asn1Enumerated.getValue() as BigInt).getOrThrow()
    println(bigint.toString())
    if (!bigint.toString().equals("-9")) {
        return 1
    }

    var asn1Integer: ASN1Integer = ASN1Integer(-9)
    var bigint1: BigInt = (asn1Integer.getValue() as BigInt).getOrThrow()
    println(bigint1.toString())
    if (!bigint1.toString().equals("-9")) {
        return 2
    }
    return 0
}
