package asn1

from std import io.*

public class ASN1OutputStream {
    public init(encoder: ASN1Encoder, out: OutputStream) {}

    public func writeObject<T>(asn1Object: ASN1Object<T>): Unit {}

    public func write(b: Array<Byte>): Unit {}

    public func write(b: Int64): Unit {}
}
