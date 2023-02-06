package asn1.types

public abstract class ASN1PrimitiveValue <: ASN1Object & ASN1Primitive & Hashable {
    public var valueBytes: Array<Byte> = Array<Byte>()

    public init(tag: ASN1Tag) {
        super(tag)
    }

    public init(tag: ASN1Tag, valueBytes: Array<Byte>) {
        super(tag)
        this.valueBytes = valueBytes
    }

    protected open func valueHash(): Int64 {
        if (valueBytes.isEmpty()) {
            return 0
        }
        var result: Int64 = 1
        for (element in valueBytes) {
            result = 31 * result + element.position()
        }
        return result
    }
}
