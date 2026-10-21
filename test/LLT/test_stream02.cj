// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import asn1.*
import std.io.*
import std.unittest.*
import std.unittest.testmacro.*

main(): Int64 {
    let decodetd: DEREncoder = DEREncoder()
    let wrapped: ByteBuffer = ByteBuffer()
    let asn = ASN1OutputStream(decodetd,wrapped)
    let bytesBuf: Array<Byte> = Array<Byte>(10, repeat: 0)

    asn.write(bytesBuf)
    asn.write(6)
    asn.write(6)
    let tags = INTEGER
    let dec: BERDecoder = BERDecoder()
    let bitss = BooleanParser(dec)
    let Buf: Array<Byte> = [1]
    let ssc = bitss.parse(tags,Buf)
    // Boolean 对象写入 INTEGER 输出流不抛异常，仅冒烟
    asn.writeObject(ssc)
    return 0
}
