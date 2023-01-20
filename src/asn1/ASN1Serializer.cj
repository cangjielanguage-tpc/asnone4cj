package asn1


public abstract class ASN1Serializer<T> where T <: ASN1Object<T> {
    protected var encoder: ASN1Encoder

    public init(encoder: ASN1Encoder) {
        this.encoder = encoder
    }

    public func serializedLength(asn1Object: T): Int64

    public func serialize(asn1Object: T, stream: ASN1OutputStream): Unit
}
