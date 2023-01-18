package asn1.types.string

import asn1.types.ASN1Object
import asn1.types.ASN1Primitive
import asn1.types.ASN1Constructed
import asn1.types.ASN1Tag
import asn1.types.ASN1Encoding

public abstract class ASN1String<T> <: ASN1Object<T> & ASN1Primitive & ASN1Constructed<ASN1Object<T>> {
    protected var valueBytes: Array<Byte> = Array<Byte>()

    public init(tag: ASN1Tag, valueBytes: Array<Byte>) {
        super(tag)
        this.valueBytes = valueBytes
    }

    public func iterator(): Iterator<ASN1Object<T>> {
        if (tag.getAsn1Encoding() == ASN1Encoding.CONSTRUCTED(0x20)) {
            // TODO
            throw IllegalArgumentException("")
        } else {
            // TODO
            throw IllegalArgumentException("")
        }
    }

    public func getValueBytes(): Array<Byte> {
        var copyList: Array<Byte> = Array<Byte>()
        valueBytes.copyTo(copyList, 0, 0, valueBytes.size)
        return copyList
    }

    public func length(): Int64
}
