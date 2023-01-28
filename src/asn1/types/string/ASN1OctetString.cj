package asn1.types.string

public class ASN1OctetString <: ASN1String {
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
public class OctetStringParser <: ASN1Parser {
    public init(decoder: ASN1Decoder) {
        super(decoder)
    }

    public override func parse(asn1Tag: ASN1Tag, value: Array<Byte>): ASN1Object {
        return ASN1OctetString(asn1Tag, value)
    }
}

public class OctetStringSerializer <: ASN1Serializer {
    public init(encoder: ASN1Encoder) {
        super(encoder)
    }

    public override func serializedLength(asn1Object: ASN1Object): Int64 {
        var object: ASN1OctetString = (asn1Object as ASN1OctetString).getOrThrow()
        return object.bytes.size + 1
    }

    public override func serialize(asn1Object: ASN1Object, stream: ASN1OutputStream): Unit {
        var object: ASN1OctetString = (asn1Object as ASN1OctetString).getOrThrow()
        stream.write(object.bytes)
    }
}
