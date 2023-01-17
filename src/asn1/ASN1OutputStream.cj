package asn1

from std import io.OutputStream

public class ASN1OutputStream <: OutputStream {
    private var encoder: ASN1Encoder

    public init(encoder: ASN1Encoder, out: OutputStream) {
        this.encoder = encoder
    }

    public func writeObject<T>(asn1Object: ASN1Object<T>): Unit {
        // TODO
    }

    public func write(b: Array<Byte>): Unit {
        // TODO
    }

    public func write(b: Int64): Unit {
        // TODO
    }

    private func writeLength(length: Int64): Unit {   
        // TODO
    }

    private func lengthBytes(length: Int64): Int64 {
        var l: Int64 = length
        var nrBytes: Int64 = 1
        while (l > 255) {
            nrBytes++
            l >>= 8
        }
        return nrBytes
    }

    private func writeTag(tag: ASN1Tag): Unit {
        // TODO
    }
}
