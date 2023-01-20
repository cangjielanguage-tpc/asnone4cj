package asn1.types.primitive

from std import io.ByteArrayStream
from std import collection.StringBuilder

public class ASN1ObjectIdentifier<T> <: ASN1PrimitiveValue<T> {
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

public class IdentifierParserObject<T> <: ASN1Parser<T> where T <: ASN1Object<T> {
    public init(decoder: ASN1Decoder) {
        super(decoder)
    }

    public override func parse(asn1Tag: ASN1Tag, value: Array<Byte>): ASN1Object<T> {
        Checks.checkArgument(
            value.size > 0,
            "An ASN.1 OBJECT IDENTIFIER should have at least a one byte value",
            Array<Any>()
        )
        var byteArrayStream: ByteArrayStream = ByteArrayStream()

        // 将 buffer 中的数据写入到输出流中，当数据全部成功写入则函数返回
        byteArrayStream.write(value)

        // 返回当前缓冲区总容量
        var firstTwo: Int64 = byteArrayStream.length
        var stringBuilder: StringBuilder = StringBuilder()
        stringBuilder.append(firstTwo / 40)
        stringBuilder.append('.').append(firstTwo % 40)
        while (byteArrayStream.isEmpty()) {
            var x: Int64 = byteArrayStream.capacity()
            if (x < 127) {
                stringBuilder.append('.').append(x)
            } else {
                var v: Int64 = x & 0x7f
                do {
                    // TODO
                } while (x > 127)
                stringBuilder.append('.').append(v)
            }
        }
        byteArrayStream.clear()
        return ASN1ObjectIdentifier<T>(stringBuilder.toString(), value)
    }
}

public class ObjectIdentifierSerializer<T> <: ASN1Serializer<T> where T <: ASN1Object<T> {
    public init(encoder: ASN1Encoder) {
        super(encoder)
    }

    public override func serializedLength(asn1Object: T): Int64 {
        var object = (asn1Object as ASN1ObjectIdentifier<T>).getOrThrow()
        if (object.valueBytes.isEmpty()) {
            calculateBytes(object)
        }
        return object.valueBytes.size
    }

    public override func serialize(asn1Object: T, stream: ASN1OutputStream): Unit {
        var object = (asn1Object as ASN1ObjectIdentifier<T>).getOrThrow()
        if (object.valueBytes.isEmpty()) {
            calculateBytes(object)
        }
        stream.write(object.valueBytes)
    }

    public func calculateBytes(asn1Object: ASN1ObjectIdentifier<T>): Unit {
        // TODO
        var oid: String = asn1Object.oid
        var byteArrayStream: ByteArrayStream = ByteArrayStream()
    }
}
