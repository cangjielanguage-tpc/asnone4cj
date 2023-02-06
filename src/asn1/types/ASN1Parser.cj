package asn1.types

public abstract class ASN1Parser {
    protected var decoder: ASN1Decoder

    public init(decoder: ASN1Decoder) {
        this.decoder = decoder
    }

    public func parse(asn1Tag: Any, value: Array<Byte>): ASN1Object
}
