package asn1.types

var encodingvalue: Int64 = 0

public enum ASN1Encoding <: Hashable & Equatable<ASN1Encoding> {
    | PRIMITIVE(Byte)
    | CONSTRUCTED(Byte)

    func ASN1Encoding(value: Int64) {
        encodingvalue = value
    }

    public func getValue(): Int64 {
        return encodingvalue
    }

    public static func parseEncoding(tagByte: Byte): ASN1Encoding {
        if ((tagByte & 0x20) == 0) {
            return PRIMITIVE(0x0)
        } else {
            return CONSTRUCTED(0x20)
        }
    }

    public func hashCode(): Int64 {
        return match (this) {
            case PRIMITIVE(0x0) => (0x0).hashCode()
            case CONSTRUCTED(0x20) => (0x20).hashCode()
            case _ => throw Exception("error")
        }
    }

    public operator func ==(that: ASN1Encoding): Bool {
        match ((this, that)) {
            case (PRIMITIVE(0x0), PRIMITIVE(0x0)) => true
            case (CONSTRUCTED(0x20), CONSTRUCTED(0x20)) => true
            case _ => false
        }
    }

    public operator func !=(that: ASN1Encoding): Bool {
        return !(this == that)
    }
}
