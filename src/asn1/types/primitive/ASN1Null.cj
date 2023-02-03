package asn1.types.primitive

from std import format.Formatter
import asn1.types.ASN1Tag
import asn1.types.ASN1Object
import asn1.util.Checks
import asn1.encodingrules.ASN1Decoder
import asn1.encodingrules.ASN1Encoder

public class ASN1Null <: ASN1PrimitiveValue {
    private let NULL_BYTES: Array<Byte> = []

    public init() {
        super(ASN1Tag.ASN1_NULL_TAG, NULL_BYTES)
    }

    public override func getValue(): Any {
        return Option<Unit>.None
    }

    protected func valueHash(): Int64 {
        return 0
    }
}

public class ParserNull <: ASN1Parser {
    public init(decoder: ASN1Decoder) {
        super(decoder)
    }

    public override func parse(asn1Tag: ASN1Tag, value: Array<Byte>): ASN1Object {
        Checks.checkState(value.size == 0, "ASN.1 NULL can not have a value", Array<Formatter>())
        return ASN1Null()
    }
}

public class SerializerNull <: ASN1Serializer {
    public init(encoder: ASN1Encoder) {
        super(encoder)
    }

    public override func serializedLength(asn1Object: ASN1Object): Int64 {
        return 0
    }

    public override func serialize(asn1Object: ASN1Object, stream: ASN1OutputStream): Unit {
        // No-op, no data
    }
}
