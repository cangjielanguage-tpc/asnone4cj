package asn1.encodingrules

from std import io.InputStream

public interface ASN1Decoder {
    func readTag(inputStream: InputStream): Any

    func readLength(inputStream: InputStream): Int64

    func readValue(length: Int64, inputStream: InputStream): Array<Byte>
}
