package asn1.types

public abstract class ASN1Object <: Hashable & Equatable<ASN1Object> & ToString{
    protected var tag: ASN1Tag

    protected init(tag: ASN1Tag) {
        this.tag = tag
    }

    public func getValue(): Any

    public func equals(o: Object): Bool {
        // TODO
        if (refEq(this, o)) {
            return true
        }
        var that: ASN1Object = (o as ASN1Object).getOrThrow()
        return false
    }

    public func hashCode(): Int64 {
        var result: Int64 = tag.getTag()
        return result
    }

    public open func toString(): String {
        // TODO
        return ""
    }

    protected open func valueString(): String {
        // TODO
        return ""
    }

    public func getTag(): ASN1Tag {
        return tag
    }

    public operator func ==(that: ASN1Object): Bool {
        return this.equals(that)
    }

    public operator func !=(that: ASN1Object): Bool {
        return !(this == that)
    }
}
