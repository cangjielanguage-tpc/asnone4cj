package asn1.types

from std import collection.*

public abstract class ASN1Tag {
    private var tag: Int64 = 0
    private static var tags: HashMap<Int8, ASN1Tag> = HashMap<Int8, ASN1Tag>();

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
        this(asn1TagClass, tag, asn1Encoding, HashSet<ASN1Encoding>([asn1Encoding]));
    }

    private init(asn1TagClass: ASN1TagClass, tag: Int64, asn1Encoding: ASN1Encoding, 
        supportedEncodings: HashSet<ASN1Encoding>) {
        this.asn1TagClass = asn1TagClass
        this.tag = tag
        this.supportedEncodings = supportedEncodings
        this.asn1Encoding = asn1Encoding
    }

    public func getTag(): Int64 {
        return tag
    }

    public static let SEQUENCE: ASN1Tag = ASN1SequenceTag(ASN1TagClass.UNIVERSAL(0), 0x10,
        ASN1Encoding.CONSTRUCTED(0x20))

    public static let ASN1_BOOLEAN: ASN1Tag = ASN1SequenceTag(
        ASN1TagClass.UNIVERSAL(0),
        0x01,
        ASN1Encoding.PRIMITIVE(0x0)
    )

    public static let ENUMERATED: ASN1Tag = ASN1SequenceTag(ASN1TagClass.UNIVERSAL(0), 0x0A, ASN1Encoding.PRIMITIVE(0x0)
    )

    public static let INTEGER: ASN1Tag = ASN1SequenceTag(ASN1TagClass.UNIVERSAL(0), 0x02, ASN1Encoding.PRIMITIVE(0x0))

    public static let ASN1_NULL_TAG: ASN1Tag = ASN1SequenceTag(
        ASN1TagClass.UNIVERSAL(0),
        0x05,
        ASN1Encoding.PRIMITIVE(0x0)
    )

    public static let OBJECT_IDENTIFIER: ASN1Tag = ASN1SequenceTag(
        ASN1TagClass.UNIVERSAL(0),
        0x06,
        ASN1Encoding.PRIMITIVE(0x0)
    )
}

public class ASN1SequenceTag <: ASN1Tag {
    public init(asn1TagClass: ASN1TagClass, tag: Int64, asn1Encoding: ASN1Encoding) {
        super(asn1TagClass, tag, asn1Encoding)
    }
}
