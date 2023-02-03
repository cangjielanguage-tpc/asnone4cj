package asn1.types.primitive

public class ASN1Integer <: ASN1PrimitiveValue {
    protected var value: CPointer<BIGNUM> = bnNew()

    public init(value: Int64) {
        super(ASN1Tag.INTEGER)
        // 将整数设置给大数对象
        bnSetWord(this.value, UInt64(value))
        this.valueBytes = value.toString().toUtf8Array()
    }

    public init(value: CPointer<BIGNUM>) {
        super(ASN1Tag.INTEGER)
        this.value = value
        // 将大数对象设置给整数
        this.valueBytes = bnGetWord(value).toString().toUtf8Array()
    }

    public init(value: CPointer<BIGNUM>, valueBytes: Array<Byte>) {
        super(ASN1Tag.INTEGER, valueBytes)
        this.value = value
    }

    public override func getValue(): Any {
        return value
    }

    protected func valueHash(): Int64 {
        return bnGetWord(value).hashCode()
    }
}

public class IntegerParser <: ASN1Parser {
    public init(decoder: ASN1Decoder) {
        super(decoder)
    }

    public override func parse(asn1Tag: ASN1Tag, value: Array<Byte>): ASN1Object {
        var valueNumber: Int64 = 0
        for (i in 0..value.size) {
            valueNumber += Int64(value[i])
        }
        var valueBigNum: CPointer<BIGNUM> = bnNew()
        // 将整数设置给大数对象
        bnSetWord(valueBigNum, UInt64(valueNumber))
        return ASN1Integer(valueBigNum, value)
    }
}

public class IntegerSerializer <: ASN1Serializer {
    public init(encoder: ASN1Encoder) {
        super(encoder)
    }

    public override func serializedLength(asn1Object: ASN1Object): Int64 {
        var object: ASN1Integer = (asn1Object as ASN1Integer).getOrThrow()
        return object.valueBytes.size
    }

    public override func serialize(asn1Object: ASN1Object, stream: ASN1OutputStream): Unit {
        var object: ASN1Integer = (asn1Object as ASN1Integer).getOrThrow()
        stream.write(object.valueBytes)
    }
}
