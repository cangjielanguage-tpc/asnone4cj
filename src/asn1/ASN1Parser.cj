package asn1


public abstract class ASN1Parser<T> where T <: ASN1Object<T> {
    protected var decoder: ASN1Decoder

    public init(decoder: ASN1Decoder) {
        this.decoder = decoder
    }

    public func parse(asn1Tag: ASN1Tag, value: Array<Byte>): ASN1Object<T>
}