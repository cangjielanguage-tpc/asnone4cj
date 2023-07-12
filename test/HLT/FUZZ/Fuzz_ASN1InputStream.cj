// 3rd_party_lib:asn1-cj/build/asn1
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
import secodeFuzz.*
from std import unittest.testmacro.*
from std import collection.ArrayList

func call_fuzz(int64: Int64) {

    if (int64 > 268230000 ) {
        return
    }
    var buffer: Array<Byte> = [0x01, 0x01, 0x1]
    var byteArrayStream: ByteArrayStream = ByteArrayStream()
    byteArrayStream.write(buffer)
    var asn1inputstream:ASN1InputStream=ASN1InputStream(BERDecoder(),byteArrayStream)
    var readvalue=asn1inputstream.readValue(int64)
    return
}


func unboundTest(): Unit {
    var case_name = CString("Fuzz_asn1inputstream.readValue")
    unsafe {
        DT_FUZZ_Int64(0, 30000000, case_name, 0, call_fuzz)
        case_name.free()
    }
}

main() {
    unboundTest()
    return
}
