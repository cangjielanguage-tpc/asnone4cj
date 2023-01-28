package asn1.types.primitive

public class ASN1Enumerated <: ASN1PrimitiveValue {
    protected var value: Int64 = 0

    public init(value: Int64) {
        super(ASN1Tag.ENUMERATED)
        this.value = value
    }

    public init(value: Int64, valueBytes: Array<Byte>) {
        super(ASN1Tag.ENUMERATED, valueBytes)
        this.value = value
    }

    public override func getValue(): Any {
        return value
    }
}

public class EnumeratedParser <: ASN1Parser {
    public init(decoder: ASN1Decoder) {
        super(decoder)
    }

    public override func parse(asn1Tag: ASN1Tag, value: Array<Byte>): ASN1Object {
        // TODO
        return ASN1Enumerated(0, value)
    }
}

public class SerializerEnumerated <: ASN1Serializer {
    public init(encoder: ASN1Encoder) {
        super(encoder)
    }

    public override func serializedLength(asn1Object: ASN1Object): Int64 {
        var object = (asn1Object as ASN1Enumerated).getOrThrow()
        if (object.valueBytes.isEmpty()) {
            calculateBytes(object)
        }
        return object.valueBytes.size
    }

    public override func serialize(asn1Object: ASN1Object, stream: ASN1OutputStream): Unit {
        var object = (asn1Object as ASN1Enumerated).getOrThrow()
        if (object.valueBytes.isEmpty()) {
            calculateBytes(object)
        }
        stream.write(object.valueBytes)
    }

    private func calculateBytes(asn1Object: ASN1Enumerated): Unit {
        // TODO
    }
}
