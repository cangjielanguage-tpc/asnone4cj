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

    if (int64 > 7 || int64 < -7) {
        return
    }
    let arr: Array<Bool> =Array<Bool>([true,true,false,true,false,false])
    var asn1itstring:ASN1BitString=ASN1BitString(arr)
    asn1itstring.isSet(int64)
    return
}


func unboundTest(): Unit {
    var case_name = CString("Fuzz_asn1itstring.isSet")
    unsafe {
        DT_FUZZ_Int64(0, 30000000, case_name, 0, call_fuzz)
        case_name.free()
    }
}

main() {
    unboundTest()
    return
}
