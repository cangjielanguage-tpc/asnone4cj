package asn1.types.primitive

public class ASN1Integer <: ASN1PrimitiveValue {
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

public class IntegerParser <: ASN1Parser {
    public init(decoder: ASN1Decoder) {
        super(decoder)
    }

    public override func parse(asn1Tag: ASN1Tag, value: Array<Byte>): ASN1Object {
        // TODO
        return ASN1Integer(0, value)
    }
}

public class IntegerSerializer <: ASN1Serializer {
    public init(encoder: ASN1Encoder) {
        super(encoder)
    }

    public override func serializedLength(asn1Object: ASN1Object): Int64 {
        var object = (asn1Object as ASN1Integer).getOrThrow()
        return object.valueBytes.size
    }

    public override func serialize(asn1Object: ASN1Object, stream: ASN1OutputStream): Unit {
        var object = (asn1Object as ASN1Integer).getOrThrow()
        stream.write(object.valueBytes)
    }
}
