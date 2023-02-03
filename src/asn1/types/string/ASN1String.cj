package asn1.types.string

import asn1.types.ASN1Primitive
import asn1.types.ASN1Constructed
import asn1.types.ASN1Encoding

public abstract class ASN1String <: ASN1Object & ASN1Primitive & ASN1Constructed {
    protected var valueBytes: Array<Byte> = Array<Byte>()

    public init(tag: ASN1Tag, valueBytes: Array<Byte>) {
        super(tag)
        this.valueBytes = valueBytes
    }

    public func iterator(): Iterator<ASN1Object> {
        if (tag.getAsn1Encoding() == ASN1Encoding.CONSTRUCTED(0x20)) {
            // TODO
            // return ASN1Tag.SEQUENCE.newParser(new BERDecoder()).parse(ASN1Tag.SEQUENCE, valueBytes).iterator();
            throw IllegalArgumentException("")
        } else {
            return this.iterator()
        }
    }

    public func getValueBytes(): Array<Byte> {
        var copyList: Array<Byte> = Array<Byte>()
        valueBytes.copyTo(copyList, 0, 0, valueBytes.size)
        return copyList
    }

    public func length(): Int64
}
