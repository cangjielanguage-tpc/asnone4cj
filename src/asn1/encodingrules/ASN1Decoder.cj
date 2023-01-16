package asn1.encodingrules

from std import collection.*
from std import io.*
import asn1.types.ASN1Tag
import asn1.types.ASN1Object

public interface ASN1Decoder {
    func readTag(inputStream: InputStream): ASN1Tag

    func readLength(inputStream: InputStream): Int64

    func readValue(length: Int64, inputStream: InputStream): Array<Byte>
}
