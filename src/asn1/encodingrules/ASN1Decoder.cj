package asn1.encodingrules

from std import io.InputStream
import asn1.types.ASN1Tag

public interface ASN1Decoder {
    func readTag(inputStream: InputStream): ASN1Tag

    func readLength(inputStream: InputStream): Int64

    func readValue(length: Int64, inputStream: InputStream): Array<Byte>
}
