package asn1

from cryptocj import bignumcj.bnLshift
from cryptocj import bignumcj.bnAdd
from cryptocj import bignumcj.bnDec2bn
from cryptocj import bignumcj.bnRshift
from cryptocj import bignumcj.bnNumBits

public class ASN1ObjectIdentifier <: ASN1PrimitiveValue {
    protected var oid: String

    public init(oid: String) {
        super(ASN1Tag.OBJECT_IDENTIFIER)
        this.oid = oid
    }

    public init(oid: String, valueBytes: Array<Byte>) {
        super(ASN1Tag.OBJECT_IDENTIFIER, valueBytes)
        this.oid = oid
    }

    public override func getValue(): Any {
        return oid
    }

    protected func valueHash(): Int64 {
        return oid.hashCode()
    }
}

public class ASN1ObjectIdentifierParser <: ASN1Parser {
    public init(decoder: ASN1Decoder) {
        super(decoder)
    }

    public override func parse(asn1Tag: Any, value: Array<Byte>): ASN1Object {
        Checks.checkArgument(
            value.size > 0,
            "An ASN.1 OBJECT IDENTIFIER should have at least a one byte value",
            Array<ToString>()
        )
        var byteArrayStream: ByteArrayStream = ByteArrayStream()

        // 将 buffer 中的数据写入到输出流中，当数据全部成功写入则函数返回
        byteArrayStream.write(value)

        // 返回当前缓冲区总容量
        var dataArr: Array<Byte> = Array<Byte>(1, item: 0)
        var firstTwoLength: Int64 = byteArrayStream.read(dataArr)
        var firstTwo: Byte = dataArr[0]
        var stringBuilder: StringBuilder = StringBuilder()
        stringBuilder.append(firstTwo / 40)
        stringBuilder.append('.').append(firstTwo % 40)
        while (byteArrayStream.isEmpty()) {
            var xLength: Int64 = byteArrayStream.read(dataArr)
            var x: Byte = dataArr[0]
            if (x < 127) {
                stringBuilder.append('.').append(x)
            } else {
                var vInt: Int64 = Int64(x) & 0x7f
                var v: CPointer<BIGNUM> = bnNew()
                bnSetWord(v, UInt64(vInt))
                do {
                    byteArrayStream.read(dataArr)
                    x = dataArr[0]
                    var r: CPointer<BIGNUM> = bnNew()
                    bnLshift(r, v, 7)
                    var c: CPointer<BIGNUM> = bnNew()
                    var b: CPointer<BIGNUM> = bnNew()
                    bnAdd(c, r, b)
                    v = c
                } while (x > 127)
                stringBuilder.append('.').append(bnGetWord(v))
            }
        }
        return ASN1ObjectIdentifier(stringBuilder.toString(), value)
    }
}

public class ASN1ObjectIdentifierSerializer <: ASN1Serializer {
    public init(encoder: ASN1Encoder) {
        super(encoder)
    }

    public override func serializedLength(asn1Object: Any): Int64 {
        var object: ASN1ObjectIdentifier = (asn1Object as ASN1ObjectIdentifier).getOrThrow()
        if (object.valueBytes.isEmpty()) {
            calculateBytes(object)
        }
        return object.valueBytes.size
    }

    public override func serialize(asn1Object: Any, stream: Any): Unit {
        var object: ASN1ObjectIdentifier = (asn1Object as ASN1ObjectIdentifier).getOrThrow()
        var stream1: ASN1OutputStream = (stream as ASN1OutputStream).getOrThrow()
        if (object.valueBytes.isEmpty()) {
            calculateBytes(object)
        }
        stream1.write(object.valueBytes)
    }

    private func calculateBytes(asn1Object: ASN1ObjectIdentifier): Unit {
        var oid: String = asn1Object.oid
        var baos: ByteArrayStream = ByteArrayStream()
        var stringArr: Array<String> = oid.split(".")
        var first: Int64 = Int64.parse(stringArr[0])
        var second: Int64 = Int64.parse(stringArr[1])
        var number: Int64 = first * 40 + second
        baos.write(number.toString().toUtf8Array())
        for (i in 2..stringArr.size) {
            var valueBigNum: CPointer<BIGNUM> = bnNew()

            // 将十进制字符串转换为大数
            bnDec2bn(valueBigNum, stringArr[i])

            // 从大数中提取整数
            var bigNum: Int64 = Int64(bnGetWord(valueBigNum))
            if (bigNum > 0 && bigNum < 127) {
                baos.write(bigNum.toString().toUtf8Array())
            } else {
                var neededBytes: Int64
                if (bnNumBits(valueBigNum) % 7 > 0) {
                    neededBytes = Int64(bnNumBits(valueBigNum)) / 7 + 1
                } else {
                    neededBytes = Int64(bnNumBits(valueBigNum)) / 7 + 0
                }
                for (i in neededBytes - 1..0) {
                    var r: CPointer<BIGNUM> = bnNew()
                    bnRshift(r, valueBigNum, Int32(i * 7))
                    var b: Byte = UInt8(bnGetWord(r))
                    b &= 0x7f
                    if (i > 0) {
                        b |= 0x80
                    }
                    baos.write(Array<Byte>([b]))
                }
            }
        }
        asn1Object.valueBytes = baos.bytes()
    }
}
