package asn1.types

from std import collection.*

public abstract class ASN1Tag {
    private static var tags: HashMap<Int64, ASN1Tag> = HashMap<Int64, ASN1Tag>()
    private var tag: Int64 = 0
    private var asn1TagClass: ASN1TagClass
    private var supportedEncodings: HashSet<ASN1Encoding> = HashSet<ASN1Encoding>()
    private var asn1Encoding: ASN1Encoding

    public init(asn1TagClass: ASN1TagClass, tag: Int64, supportedEncodings: HashSet<ASN1Encoding>) {
        if (supportedEncodings.contains(ASN1Encoding.PRIMITIVE(0x0))) {
            this.asn1Encoding = ASN1Encoding.PRIMITIVE(0x0)
        }
        this.asn1TagClass = asn1TagClass
        this.tag = tag
        this.supportedEncodings = supportedEncodings
        this.asn1Encoding = ASN1Encoding.CONSTRUCTED(0x20)
    }

    public init(asn1TagClass: ASN1TagClass, tag: Int64, asn1Encoding: ASN1Encoding) {
        this(asn1TagClass, tag, asn1Encoding, HashSet<ASN1Encoding>([asn1Encoding]))
    }

    public init(
        asn1TagClass: ASN1TagClass,
        tag: Int64,
        asn1Encoding: ASN1Encoding,
        supportedEncodings: HashSet<ASN1Encoding>
    ) {
        this.asn1TagClass = asn1TagClass
        this.tag = tag
        this.supportedEncodings = supportedEncodings
        this.asn1Encoding = asn1Encoding
    }

    public func constructed(): ASN1Tag {
        return asEncoded(ASN1Encoding.CONSTRUCTED(0x20))
    }

    public func primitive(): ASN1Tag {
        return asEncoded(ASN1Encoding.PRIMITIVE(0x0))
    }

    public func asEncoded(asn1Encoding: ASN1Encoding): ASN1Tag {
        if (this.asn1Encoding == asn1Encoding) {
            return this
        }

        // TODO
        if (!supportedEncodings.contains(asn1Encoding)) {
            throw IllegalArgumentException("")
        }
        throw IllegalArgumentException("")
    }

    public static func application(tag: Int64): ASN1Tag {
        return forTag(ASN1TagClass.APPLICATION(0x40), tag)
    }

    public static func contextSpecific(tag: Int64): ASN1Tag {
        return forTag(ASN1TagClass.CONTEXT_SPECIFIC(0x80), tag)
    }

    public static func forTag(asn1TagClass: ASN1TagClass, tag: Int64): ASN1Tag {
        // TODO
        throw IllegalArgumentException("")
    }

    public func getTag(): Int64 {
        return tag
    }

    public func getAsn1TagClass(): ASN1TagClass {
        return asn1TagClass
    }

    public func getAsn1Encoding(): ASN1Encoding {
        return asn1Encoding
    }

    public func isConstructed(): Bool {
        return asn1Encoding == ASN1Encoding.CONSTRUCTED(0x20)
    }

    public func equals(o: Object): Bool {
        if (refEq(this, o)) {
            return true
        }
        var that: ASN1Tag = (o as ASN1Tag).getOrThrow()
        return (getTag() == that.getTag() && asn1Encoding == that.asn1Encoding)
    }

    public func hashCode(): Int32 {
        return hashCodeobjs(asn1TagClass, getTag(), asn1Encoding)
    }

    @overflowWrapping
    private func hashCodeobjs(asn1TagClass: ASN1TagClass, tag: Int64, asn1Encoding: ASN1Encoding): Int32 {
        var result: Int32 = 1
        var asn1Tagcode: Int32 = 0
        var asn1Encode: Int32 = 0
        asn1Tagcode = match (asn1TagClass) {
            case UNIVERSAL(Byte) => 1590550415
            case APPLICATION(Byte) => 1058025095
            case CONTEXT_SPECIFIC(Byte) => 665576141
            case PRIVATE(Byte) => 1599771323
        }
        result = 31 * result + asn1Tagcode
        result = 31 * result + Int32(tag)
        match (asn1Encoding) {
            case PRIMITIVE(Byte) => 1058025095
            case CONSTRUCTED(Byte) => 665576141
        }
        result = 31 * result + Int32(tag)
        return result
    }

    public func toString(): String {
        var sb: StringBuilder = StringBuilder()
        sb.append("ASN1Tag[")
        match (asn1TagClass) {
            case UNIVERSAL(Byte) => sb.append("UNIVERSAL")
            case APPLICATION(Byte) => sb.append("APPLICATION")
            case CONTEXT_SPECIFIC(Byte) => sb.append("CONTEXT_SPECIFIC")
            case PRIVATE(Byte) => sb.append("PRIVATE")
        }
        sb.append(",")
        match (asn1Encoding) {
            case PRIMITIVE(Byte) => sb.append("PRIMITIVE")
            case CONSTRUCTED(Byte) => sb.append("CONSTRUCTED")
        }
        sb.append(",")
        sb.append(tag)
        sb.append(']')
        return sb.toString()
    }

    public static let ASN1_BOOLEAN: ASN1Tag = ASN1BooleanTag(
        ASN1TagClass.UNIVERSAL(0),
        0x01,
        ASN1Encoding.PRIMITIVE(0x0)
    )

    public static let INTEGER: ASN1Tag = ASN1IntegerTag(ASN1TagClass.UNIVERSAL(0), 0x02, ASN1Encoding.PRIMITIVE(0x0))

    public static let BIT_STRING: ASN1Tag = ASN1BitStringTag(
        ASN1TagClass.UNIVERSAL(0),
        0x03,
        ASN1Encoding.PRIMITIVE(0x0),
        HashSet<ASN1Encoding>([ASN1Encoding.PRIMITIVE(0x0), ASN1Encoding.CONSTRUCTED(0x20)])
    )

    public static let OCTET_STRING: ASN1Tag = ASN1OctetStringTag(
        ASN1TagClass.UNIVERSAL(0),
        0x04,
        HashSet<ASN1Encoding>([ASN1Encoding.PRIMITIVE(0x0), ASN1Encoding.CONSTRUCTED(0x20)])
    )

    public static let ASN1_NULL_TAG: ASN1Tag = ASN1NullTag(
        ASN1TagClass.UNIVERSAL(0),
        0x05,
        ASN1Encoding.PRIMITIVE(0x0)
    )

    public static let OBJECT_IDENTIFIER: ASN1Tag = ASN1ObjectIdentifierTag(
        ASN1TagClass.UNIVERSAL(0),
        0x06,
        ASN1Encoding.PRIMITIVE(0x0)
    )

    public static let ENUMERATED: ASN1Tag = ASN1EnumeratedTag(
        ASN1TagClass.UNIVERSAL(0),
        0x0A,
        ASN1Encoding.PRIMITIVE(0x0)
    )

    public static let SET: ASN1Tag = ASN1SetTag(
        ASN1TagClass.UNIVERSAL(0),
        0x11,
        ASN1Encoding.CONSTRUCTED(0x20)
    )

    public static let SEQUENCE: ASN1Tag = ASN1SequenceTag(
        ASN1TagClass.UNIVERSAL(0),
        0x10,
        ASN1Encoding.CONSTRUCTED(0x20)
    )

    private func addTags() {
        tags.put(ASN1_BOOLEAN.getTag(), ASN1_BOOLEAN)
        tags.put(INTEGER.getTag(), INTEGER)
        tags.put(BIT_STRING.getTag(), BIT_STRING)
        tags.put(OCTET_STRING.getTag(), OCTET_STRING)
        tags.put(ASN1_NULL_TAG.getTag(), ASN1_NULL_TAG)
        tags.put(OBJECT_IDENTIFIER.getTag(), OBJECT_IDENTIFIER)
        tags.put(ENUMERATED.getTag(), ENUMERATED)
        tags.put(SET.getTag(), SET)
        tags.put(SEQUENCE.getTag(), SEQUENCE)
    }
}

public class ASN1BooleanTag <: ASN1Tag {

    public init(asn1TagClass: ASN1TagClass, tag: Int64, asn1Encoding: ASN1Encoding) {
        super(asn1TagClass, tag, asn1Encoding)
    }
    // TODO
}

public class ASN1IntegerTag <: ASN1Tag {
    public init(asn1TagClass: ASN1TagClass, tag: Int64, asn1Encoding: ASN1Encoding) {
        super(asn1TagClass, tag, asn1Encoding)
    }
    // TODO
}

public class ASN1BitStringTag <: ASN1Tag {
    public init(
        asn1TagClass: ASN1TagClass,
        tag: Int64,
        asn1Encoding: ASN1Encoding,
        supportedEncodings: HashSet<ASN1Encoding>
    ) {
        super(asn1TagClass, tag, asn1Encoding, supportedEncodings)
    }
    // TODO
}

public class ASN1OctetStringTag <: ASN1Tag {
    public init(
        asn1TagClass: ASN1TagClass,
        tag: Int64,
        supportedEncodings: HashSet<ASN1Encoding>
    ) {
        super(asn1TagClass, tag, supportedEncodings)
    }
    // TODO
}

public class ASN1NullTag <: ASN1Tag {
    public init(asn1TagClass: ASN1TagClass, tag: Int64, asn1Encoding: ASN1Encoding) {
        super(asn1TagClass, tag, asn1Encoding)
    }
    // TODO
}

public class ASN1ObjectIdentifierTag <: ASN1Tag {
    public init(asn1TagClass: ASN1TagClass, tag: Int64, asn1Encoding: ASN1Encoding) {
        super(asn1TagClass, tag, asn1Encoding)
    }
    // TODO
}

public class ASN1EnumeratedTag <: ASN1Tag {
    public init(asn1TagClass: ASN1TagClass, tag: Int64, asn1Encoding: ASN1Encoding) {
        super(asn1TagClass, tag, asn1Encoding)
    }
    // TODO
}

public class ASN1SetTag <: ASN1Tag {
    public init(asn1TagClass: ASN1TagClass, tag: Int64, asn1Encoding: ASN1Encoding) {
        super(asn1TagClass, tag, asn1Encoding)
    }
    // TODO
}

public class ASN1SequenceTag <: ASN1Tag {
    public init(asn1TagClass: ASN1TagClass, tag: Int64, asn1Encoding: ASN1Encoding) {
        super(asn1TagClass, tag, asn1Encoding)
    }
    // TODO
}
