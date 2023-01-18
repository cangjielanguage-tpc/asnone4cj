package asn1

from std import io.InputStream
from std import io.ByteArrayStream
import asn1.types.ASN1Object
import asn1.encodingrules.ASN1Decoder

public class ASN1InputStream<T> <: InputStream & Iterable<ASN1Object<T>> {
    private var decoder: ASN1Decoder

    public init(decoder: ASN1Decoder, wrapped: InputStream) {
        // TODO
        this.decoder = decoder
    }

    public init(decoder: ASN1Decoder, value: Array<Byte>) {
        // TODO
        this.decoder = decoder
    }

    public func readObject(): ASN1Object<T> {
        //TODO
        throw ASN1ParseException("Cannot parse ASN.1 object from stream")
    }

    public func readValue(length: Int64): Array<Byte> {
        //TODO
        return Array<Byte>()
    }

    public override func iterator(): Iterator<ASN1Object<T>> {
        //TODO
        throw IllegalArgumentException("")
    }

    public func readTag(): ASN1Tag {
        //TODO
        throw IllegalArgumentException("")
    }

    public func readLength(): Int64 {
        //TODO
        return 0
    }

    public override func read(buffer: Array<Byte>): Int64 {
        // TODO
        return buffer.size
    }
}
