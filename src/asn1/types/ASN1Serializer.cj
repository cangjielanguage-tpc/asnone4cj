package asn1.types

public abstract class ASN1Serializer {
    protected var encoder: ASN1Encoder

    public init(encoder: ASN1Encoder) {
        this.encoder = encoder
    }

    public func serializedLength(asn1Object: Any): Int64

    public func serialize(asn1Object: Any, stream: Any): Unit
}
