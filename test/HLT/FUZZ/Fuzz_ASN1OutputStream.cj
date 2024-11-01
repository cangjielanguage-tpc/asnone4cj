// 3rd_party_lib:asnone4cj/target/release/asn1

import std.io.*
import asn1.*
import std.collection.*
import std.io.*
import std.time.*
import secodeFuzz.*
import std.unittest.testmacro.*
import std.collection.ArrayList
import std.math.*
import std.convert.*

func call_fuzz(int64: Int64) {

    let decodetd: DEREncoder = DEREncoder()
    var output=ByteBuffer()
    var asn1OutputStream:ASN1OutputStream=ASN1OutputStream(decodetd,output)
    asn1OutputStream.write(int64)
    return
}

func unboundTest(): Unit {
    var case_name = CString("Fuzz_asn1OutputStream.write")
    unsafe {
        DT_FUZZ_Int64(0, 30000000, case_name, 0, call_fuzz)
        case_name.free()
    }
}

main() {
    unboundTest()
    return
}
