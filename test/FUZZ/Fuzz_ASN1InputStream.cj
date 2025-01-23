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

    if (int64 > 268230000 ) {
        return
    }
    var buffer: Array<Byte> = [0x01, 0x01, 0x1]
    var byteArrayStream: ByteBuffer = ByteBuffer()
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
