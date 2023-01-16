package asn1.encodingrules.ber

from std import collection.*
from std import io.*
import asn1.encodingrules.ASN1Decoder
import asn1.types.ASN1Tag
import asn1.types.ASN1Object

public open class BERDecoder <: ASN1Decoder {
    public override func readTag(inputStream: InputStream): ASN1Tag {
        // TODO
        throw Exception("Could not parse ASN.1 Tag Class (should be impossible)");
    }

    public override func readLength(inputStream: InputStream): Int64 {
        // TODO
        return 0
    }

    public override func readValue(length: Int64, inputStream: InputStream): Array<Byte> {
        // TODO
        return []
    }
}
