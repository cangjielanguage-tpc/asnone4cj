/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2023-2024. All rights reserved.
 */
 
package asn1

public class ASN1ObjectIdentifier <: ASN1PrimitiveValue {
    protected var oid: String

    public init(oid: String) {
        super(OBJECT_IDENTIFIER)
        this.oid = oid
    }

    public init(oid: String, valueBytes: Array<Byte>) {
        super(OBJECT_IDENTIFIER, valueBytes)
        this.oid = oid
    }

    public override func getValue(): Any {
        return oid
    }

    protected override func valueEquals(other: ASN1Object): Bool {
        match (other as ASN1ObjectIdentifier) {
            case Some(that) => return oid == that.oid
            case None => return false
        }
    }

    public func valueHash(): Int64 {
        return oid.hashCode()
    }
}

public class ObjectIdentifierParser <: ASN1Parser {
    public init(decoder: ASN1Decoder) {
        super(decoder)
    }

    public override func parse(_: ASN1Tag, value: Array<Byte>): ASN1Object {
        Checks.checkArgument(
            value.size > 0,
            "An ASN.1 OBJECT IDENTIFIER should have at least a one byte value",
            Array<ToString>()
        )
        var byteArrayStream: ByteBuffer = ByteBuffer()

        // 将 buffer 中的数据写入到输出流中，当数据全部成功写入则函数返回
        byteArrayStream.write(value)

        // 返回当前缓冲区总容量
        var dataArr: Array<Byte> = Array<Byte>(1, repeat: 0)
        // 首子标识符 = 前两个分量合并编码，同样采用 base-128 续行格式，
        // 合并值 ≥128 时占多个字节，不能按单字节直接读取
        var firstSub: BigInt = readSubIdentifier(byteArrayStream, dataArr)
        var stringBuilder: StringBuilder = StringBuilder()
        if (firstSub < BigInt(80)) {
            var firstTwo: Int64 = firstSub.toInt64(overflowHandling: OverflowStrategy.Wrapping)
            stringBuilder.append(firstTwo / 40)
            stringBuilder.append('.')
            stringBuilder.append(firstTwo % 40)
        } else {
            // 第一分量为 2 时第二分量不受 40 限制：合并值 = 2*40 + arc2
            stringBuilder.append(2)
            stringBuilder.append('.')
            stringBuilder.append(firstSub - BigInt(80))
        }
        while (byteArrayStream.remainLength > 0) {
            var v: BigInt = readSubIdentifier(byteArrayStream, dataArr)
            stringBuilder.append('.')
            stringBuilder.append(v)
        }
        return ASN1ObjectIdentifier(stringBuilder.toString(), value)
    }

    // 从流中读取一个 base-128 编码的子标识符：字节最高位为 1 表示后续字节继续拼接
    private func readSubIdentifier(stream: ByteBuffer, buffer: Array<Byte>): BigInt {
        stream.read(buffer)
        var x: Byte = buffer[0]
        var v: BigInt = BigInt(Int64(x) & 0x7f)
        while (x > 127) {
            // 续行字节被截断时 read 无进展且缓冲字节不变，直接抛错避免死循环
            if (stream.read(buffer) <= 0) {
                throw ASN1ParseException("corrupted stream - truncated sub-identifier")
            }
            x = buffer[0]
            var r: BigInt = v << 7
            var b: BigInt = BigInt(Int64(x) & 0x7f)
            var c: BigInt = r + b
            v = c
        }
        return v
    }
}

public class ObjectIdentifierSerializer <: ASN1Serializer {
    public init(encoder: ASN1Encoder) {
        super(encoder)
    }

    public override func serializedLength(asn1Object: ASN1Object): Int64 {
        var object: ASN1ObjectIdentifier = (asn1Object as ASN1ObjectIdentifier).getOrThrow()
        if (object.valueBytes.isEmpty()) {
            calculateBytes(object)
        }
        return object.valueBytes.size
    }

    public override func serialize(asn1Object: ASN1Object, stream: ASN1OutputStream): Unit {
        var object: ASN1ObjectIdentifier = (asn1Object as ASN1ObjectIdentifier).getOrThrow()
        if (object.valueBytes.isEmpty()) {
            calculateBytes(object)
        }
        stream.write(object.valueBytes)
    }

    private func calculateBytes(asn1Object: ASN1ObjectIdentifier): Unit {
        var oid: String = asn1Object.oid
        var baos: ByteBuffer = ByteBuffer()
        var stringArr: Array<String> = oid.split(".")
        // 首子标识符 = 第一分量 * 40 + 第二分量，与后续分量走同一条 base-128 编码路径，
        // 避免 BigInt.toBytes() 的补码表示在合并值 ≥128 时写入额外的符号前导字节
        var first: BigInt = BigInt.parse(stringArr[0])
        var second: BigInt = BigInt.parse(stringArr[1])
        writeBase128(baos, first * BigInt(40) + second)
        for (i in 2..stringArr.size) {
            writeBase128(baos, BigInt.parse(stringArr[i]))
        }
        asn1Object.valueBytes = baos.bytes()
    }

    // 以 base-128 续行序列写入子标识符：除最后一字节外，每字节最高位置 1
    private func writeBase128(baos: ByteBuffer, valueBigNum: BigInt): Unit {
        if (valueBigNum == BigInt(0)) {
            baos.write(Array<Byte>(1, repeat: 0))
            return
        }
        // 二进制位宽只算一次，避免每个字节重复转换字符串
        var bitLength: Int64 = Int64(valueBigNum.toString(radix: 2).size)
        var neededBytes: Int64
        if (bitLength % 7 > 0) {
            neededBytes = bitLength / 7 + 1
        } else {
            neededBytes = bitLength / 7
        }
        var intI: Int64 = neededBytes - 1
        while (intI >= 0) {
            // 以模 128 取低 7 位，避免超过 Int64 的大数右移后被截断破坏
            var r: BigInt = valueBigNum >> intI * 7
            var a: Int64 = (r % BigInt(128)).toInt64(overflowHandling: OverflowStrategy.Wrapping)
            var b: Byte = UInt8(a & 255)
            b &= 0x7f
            if (intI > 0) {
                b |= 0x80
            }
            baos.write([b].toArray())
            intI--
        }
    }
}
