package asn1.types.string


public class ASN1OctetString<T> <: ASN1String<T> {

    protected var bytes: Array<Byte> = Array<Byte>()

    public init(bytes: Array<Byte>) {
        super(ASN1Tag.OCTET_STRING, bytes)
        this.bytes = bytes
    }

    public init(tag: ASN1Tag, bytes: Array<Byte>) {
        super(tag, bytes)
        this.bytes = bytes
    }

    public override func getValue(): Any {
        var copyList: Array<Byte> = Array<Byte>()
        bytes.copyTo(copyList, 0, 0, this.bytes.size)
        return copyList
    }

    public func valueString(): String {
        return bytes.toString()
    }

    public func length(): Int64 {
        return bytes.size
    }
}
public class OctetStringParser<T> <: ASN1Parser<T> where T <: ASN1Object<T> {

    public init(decoder: ASN1Decoder) {
        super(decoder)
    }

    public override func parse(asn1Tag: ASN1Tag, value: Array<Byte>): ASN1Object<T> {
        return ASN1OctetString<T>(asn1Tag, value)
    }
}

public class OctetStringSerializer<T> <: ASN1Serializer<T> where T <: ASN1Object<T> {

    public init(encoder: ASN1Encoder) {
        super(encoder)
    }

    public override func serializedLength(asn1Object: T): Int64 {
        var object: ASN1OctetString<T> = (asn1Object as ASN1OctetString<T>).getOrThrow()
        return object.bytes.size + 1
    }

    public override func serialize(asn1Object: T, stream: ASN1OutputStream): Unit {
        var object: ASN1OctetString<T> = (asn1Object as ASN1OctetString<T>).getOrThrow()
        stream.write(object.bytes)
    }
}


