package asn1.types

public class ASN1Boolean <: ASN1PrimitiveValue {
    protected var value: Bool = false

    public init(value: Bool) {
        super(ASN1Tag.ASN1_BOOLEAN)
        this.value = value
    }

    public init(value: Bool, valueBytes: Array<Byte>) {
        super(ASN1Tag.ASN1_BOOLEAN, valueBytes)
        this.value = value
    }

    public func getValue(): Any {
        return value
    }

    protected func valueHash(): Int64 {
        if (value) {
            return 1231
        } else {
            return 1237
        }
    }
}

public class BooleanParser <: ASN1Parser {
    public init(decoder: ASN1Decoder) {
        super(decoder)
    }

    public override func parse(asn1Tag: Any, value: Array<Byte>): ASN1Object {
        let list: Array<ToString> = [value.size]
        Checks.checkState(value.size == 1, "ASN.1 NULL can not have a value", list)
        return ASN1Boolean(value[0] != 0x0, value)
    }
}

public class BooleanSerializer <: ASN1Serializer {
    public init(encoder: ASN1Encoder) {
        super(encoder)
    }

    public override func serializedLength(asn1Object: Any): Int64 {
        return 1
    }

    public override func serialize(asn1Object: Any, stream: Any): Unit {
        var object: ASN1Boolean = (asn1Object as ASN1Boolean).getOrThrow()
        var stream1: ASN1OutputStream = (stream as ASN1OutputStream).getOrThrow()
        if (object.value) {
            stream1.write(0x01)
        } else {
            stream1.write(0x00)
        }
    }
}
