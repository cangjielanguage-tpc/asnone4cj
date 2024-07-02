package asn1

public interface ASN1Decoder {
    func readTag(inputStream: InputStream): ASN1Tag

    func readLength(inputStream: InputStream): Int64

    func readValue(length: Int64, inputStream: InputStream): Array<Byte>
}
