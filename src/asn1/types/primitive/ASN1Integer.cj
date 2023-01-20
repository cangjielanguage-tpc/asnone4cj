package asn1.types.primitive

public class ASN1Integer<T> <: ASN1PrimitiveValue<T> {
    protected var value: Int64 = 0

    public init(value: Int64) {
        super(ASN1Tag.INTEGER)
        this.value = value
    }

    public init(value: Int64, valueBytes: Array<Byte>) {
        super(ASN1Tag.INTEGER, valueBytes)
        this.value = value
    }

    public override func getValue(): Any {
        return value
    }

    protected func valueHash(): Int64 {
        return value.hashCode()
    }
}

public class IntegerParser<T> <: ASN1Parser<T> where T <: ASN1Object<T> {
    public init(decoder: ASN1Decoder) {
        super(decoder)
    }

    public override func parse(asn1Tag: ASN1Tag, value: Array<Byte>): ASN1Object<T> {
        // TODO
        return ASN1Integer<T>(0, value)
    }
}

public class IntegerSerializer<T> <: ASN1Serializer<T> where T <: ASN1Object<T> {
    public init(encoder: ASN1Encoder) {
        super(encoder)
    }

    public override func serializedLength(asn1Object: T): Int64 {
        var object = (asn1Object as ASN1Integer<T>).getOrThrow()
        return object.valueBytes.size
    }

    public override func serialize(asn1Object: T, stream: ASN1OutputStream): Unit {
        var object = (asn1Object as ASN1Integer<T>).getOrThrow()
        stream.write(object.valueBytes)
    }
}
