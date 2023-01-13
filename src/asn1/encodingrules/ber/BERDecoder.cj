package asn1.encodingrules.ber

from std import collection.*
from std import io.*
import asn1.encodingrules.ASN1Decoder
import asn1.types.ASN1Tag
import asn1.types.ASN1Object

public open class BERDecoder<T> <: ASN1Decoder<T> where T <: ASN1Object<T> {
    public override func readTag(inputStream: InputStream): ASN1Tag {
        throw Exception("Could not parse ASN.1 Tag Class (should be impossible)");
    }

    public override func readLength(inputStream: InputStream): Int64 {
        return 0
    }

    public override func readValue(length: Int64, inputStream: InputStream): Array<Byte> {
        return []
    }
}
