package asn1

from std import collection.*
import asn1.types.ASN1Object
import asn1.types.ASN1Tag
import asn1.encodingrules.ASN1Decoder

public abstract class ASN1Parser<T> where T <: ASN1Object<T> {
    protected var decoder: ASN1Decoder<T>

    public init(decoder: ASN1Decoder<T>) {
        this.decoder = decoder
    }

    public func parse(asn1Tag: ASN1Tag<T>, value: Array<Byte>): T
}
