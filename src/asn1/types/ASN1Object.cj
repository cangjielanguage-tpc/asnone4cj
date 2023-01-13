package asn1.types

public abstract class ASN1Object<T> {

    protected var tag: ASN1Tag

    protected init(tag: ASN1Tag) {
        this.tag = tag;
    }

    public func getValue(): Any;

    public func equals(o: Object): Bool {
        if ( refEq(this, o) ) {
            return true
        }

        var that: ASN1Object<T> = (o as ASN1Object<T>).getOrThrow()

        return false
    }

    public func hashCode():Int64 {
        var result: Int64 = tag.getTag();
        return result;
    }

    public func toString(): String {
        return ""
    }

    protected func valueString(): String { 
        return ""
    }

    public func getTag(): ASN1Tag {
        return tag
    }
}