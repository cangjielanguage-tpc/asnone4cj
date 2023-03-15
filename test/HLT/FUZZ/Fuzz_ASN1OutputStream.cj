// 3rd_party_lib:asn-one/build/asn1
from asn1 import asn1.EnumeratedSerializer
from asn1 import asn1.BERDecoder
from asn1 import asn1.ASN1Tag
from asn1 import asn1.ASN1Null
from asn1 import asn1.ASN1Integer
from asn1 import asn1.NullSerializer
from asn1 import asn1.IntegerSerializer
from asn1 import asn1.BooleanParser
from asn1 import asn1.ASN1OutputStream
from asn1 import asn1.encodingrules.der.DEREncoder
from asn1 import asn1.ASN1TaggedObject
from std import io.*
from asn1 import asn1.ASN1ParseException
from asn1 import asn1.ASN1Object
from asn1 import asn1.ASN1Sequence
from asn1 import asn1.BitStringParser
from asn1 import asn1.*
from asn1 import asn1.types.*
from asn1 import asn1.util.*
from asn1 import asn1.encodingrules.*
from asn1 import asn1.encodingrules.der.*
from std import collection.*
from std import io.*
from std import time.*
from okio import okio.*
import secodeFuzz.*
from std import unittest.testmacro.*
from std import collection.ArrayList
func call_fuzz(int64: Int64) {

    let decodetd: DEREncoder = DEREncoder()
    var output=ByteArrayStream()
    var asn1OutputStream:ASN1OutputStream=ASN1OutputStream(decodetd,output)
    var arr: HashSet<ASN1Object> = HashSet<ASN1Object>([ASN1Boolean(true), ASN1Integer(1), ASN1Boolean(false), ASN1Integer(2)])
    var asn1set:ASN1Set=ASN1Set(arr)
    asn1OutputStream.writeObject(asn1set)
    asn1OutputStream.write(int64)
}

func unboundTest(): Unit {
    var case_name = CString("Fuzz_asn1OutputStream.write")
    unsafe {
        DT_FUZZ_InT64(0, 100000, case_name, 0, call_fuzz)
        case_name.free()
    }
}

main() {
    unboundTest()
    return
}
