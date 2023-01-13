package asn1.types.primitive

from std import collection.*
import asn1.types.ASN1Object
import asn1.types.ASN1Primitive
import asn1.types.ASN1Tag

public abstract class ASN1PrimitiveValue<T> <: ASN1Object<T> & ASN1Primitive where T <: ASN1Object<T> {
    protected var valueBytes: Array<Byte>

    public init(tag: ASN1Tag) {
        super(tag);
        valueBytes = []
    }

    public init(tag: ASN1Tag, valueBytes: Array<Byte>) {
        super(tag);
        this.valueBytes = valueBytes
    }

    protected open func valueHash(): Int64 {
        return 0;
    }
}
