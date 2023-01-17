package asn1.types.primitive

import asn1.ASN1Parser
import asn1.ASN1Serializer
import asn1.ASN1OutputStream
import asn1.types.ASN1Tag
import asn1.types.ASN1Object
import asn1.encodingrules.ASN1Decoder
import asn1.encodingrules.ASN1Encoder
import asn1.util.Checks

public class ASN1Null<T> <: ASN1PrimitiveValue<T> {
    private let NULL_BYTES: Array<Byte> = []

    public init() {
        super(ASN1Tag.ASN1_NULL_TAG, NULL_BYTES)
    }

    public override func getValue(): Any {
        return ()
    }

    protected func valueHash(): Int64 {
        return 0
    }
}

public class ParserNull<T> <: ASN1Parser<T> where T <: ASN1Object<T> {
    public init(decoder: ASN1Decoder) {
        super(decoder)
    }

    public override func parse(asn1Tag: ASN1Tag, value: Array<Byte>): ASN1Object<T> {
        Checks.checkState(value.size == 0, "ASN.1 NULL can not have a value", Array<Any>())
        return ASN1Null<T>()
    }
}

public class SerializerNull<T> <: ASN1Serializer<T> where T <: ASN1Object<T> {
    public init(encoder: ASN1Encoder) {
        super(encoder)
    }

    public override func serializedLength(asn1Object: T): Int64 {
        return 0
    }

    public override func serialize(asn1Object: T, stream: ASN1OutputStream): Unit {}
}
