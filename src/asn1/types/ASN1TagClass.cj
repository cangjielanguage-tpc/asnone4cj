package asn1.types

var tagvalue:Int64 = 0

public enum ASN1TagClass {
    | UNIVERSAL(Byte)
    | APPLICATION(Byte)
    | CONTEXT_SPECIFIC(Byte)
    | PRIVATE(Byte)

    func ASN1TagClass(value: Int64) {
        tagvalue = value;
    }

    public static func  parseClass(tagByte: Byte): ASN1TagClass {
        var classValue: UInt8 = (tagByte & 0xc0);
        match (classValue) {
            case 0 => return UNIVERSAL(0)
            case 0x40 => return return APPLICATION(0x40);
            case 0x80 => return CONTEXT_SPECIFIC(0x80);
            case 0xc0 => return PRIVATE(0xc0);
            case _ => throw Exception("Could not parse ASN.1 Tag Class (should be impossible)");
        }
    }

    public func getValue(): Int64 {
        return tagvalue;
    }
}