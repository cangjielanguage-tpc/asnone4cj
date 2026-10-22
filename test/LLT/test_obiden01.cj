// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import asn1.*
import std.io.*
import std.unittest.*
import std.unittest.testmacro.*

main(): Int64 {
    let Buf: Array<Byte> = [1]
    let dec: ASN1ObjectIdentifier = ASN1ObjectIdentifier("ascsc")
    ASN1ObjectIdentifier("ascsc",Buf)
    let src = dec.getValue()
    let src1 = (src as String).getOrThrow()
    println(src1)

    @Assert(src1, "ascsc")

    // 2.50 的首子标识符 = 130，须以 base-128 续行编码为 0x81 0x02（而非补码多出的前导 0x00）
    var out250: ByteBuffer = ByteBuffer()
    var os250: ASN1OutputStream = ASN1OutputStream(DEREncoder(), out250)
    os250.writeObject(ASN1ObjectIdentifier("2.50"))
    let expected250: Array<Byte> = [0x06, 0x02, 0x81, 0x02]
    @Assert(out250.bytes() == expected250, true)

    // 2.50 编码结果回读解码
    var in250: ASN1InputStream = ASN1InputStream(BERDecoder(), expected250)
    var obj250: ASN1Object = in250.readObject()
    @Assert((obj250.getValue() as String).getOrThrow(), "2.50")

    // 首子标识符 128（2.48）跨过 80 边界，解码须还原为 2.48 而非 3.8
    var in248: ASN1InputStream = ASN1InputStream(BERDecoder(), [0x06, 0x02, 0x81, 0x00])
    var obj248: ASN1Object = in248.readObject()
    @Assert((obj248.getValue() as String).getOrThrow(), "2.48")

    // 首子标识符 1079（2.999）为多字节 base-128，解码须还原为 2.999
    var out999: ByteBuffer = ByteBuffer()
    var os999: ASN1OutputStream = ASN1OutputStream(DEREncoder(), out999)
    os999.writeObject(ASN1ObjectIdentifier("2.999"))
    let expected999: Array<Byte> = [0x06, 0x02, 0x88, 0x37]
    @Assert(out999.bytes() == expected999, true)
    var in999: ASN1InputStream = ASN1InputStream(BERDecoder(), expected999)
    var obj999: ASN1Object = in999.readObject()
    @Assert((obj999.getValue() as String).getOrThrow(), "2.999")

    // 0.0 的首子标识符为 0，编码为单字节 0x00
    var out00: ByteBuffer = ByteBuffer()
    var os00: ASN1OutputStream = ASN1OutputStream(DEREncoder(), out00)
    os00.writeObject(ASN1ObjectIdentifier("0.0"))
    let expected00: Array<Byte> = [0x06, 0x01, 0x00]
    @Assert(out00.bytes() == expected00, true)

    // 常见标准 OID 编码回读一致性
    var outStd: ByteBuffer = ByteBuffer()
    var osStd: ASN1OutputStream = ASN1OutputStream(DEREncoder(), outStd)
    osStd.writeObject(ASN1ObjectIdentifier("1.2.840.113549.1.1.1"))
    var inStd: ASN1InputStream = ASN1InputStream(BERDecoder(), outStd.bytes())
    var objStd: ASN1Object = inStd.readObject()
    @Assert((objStd.getValue() as String).getOrThrow(), "1.2.840.113549.1.1.1")
    return 0
}
