package asn1.types

public interface ASN1Decoder {
    func readTag(inputStream: InputStream): Any

    func readLength(inputStream: InputStream): Int64

    func readValue(length: Int64, inputStream: InputStream): Array<Byte>
}
