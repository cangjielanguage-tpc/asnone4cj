// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from asn1 import asn1.*
from asn1 import asn1.types.*
from asn1 import asn1.util.*
from asn1 import asn1.encodingrules.*
from asn1 import asn1.encodingrules.der.*
from std import io.*

main(): Int64 {
    try {
        Checks.checkState(false, "error", Array<ToString>())
    } catch (e: Exception) {
        println(e)
    }
    Checks.checkState(true, "error", Array<ToString>())
    try {
        Checks.checkArgument(false, "error", Array<ToString>())
    } catch (e: Exception) {
        println(e)
    }
    Checks.checkArgument(true, "error", Array<ToString>())
    return 0
}
