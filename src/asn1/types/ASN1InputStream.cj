package asn1.types

from std import io.InputStream
from std import log.*

public class ASN1InputStream <: InputStream & Iterable<ASN1Object> {
    private static let logger: SimpleLogger = SimpleLogger()
    protected var input: InputStream

    private var decoder: ASN1Decoder

    public init(decoder: ASN1Decoder, wrapped: InputStream) {
        this.input = wrapped
        this.decoder = decoder
    }

    public init(decoder: ASN1Decoder, value: Array<Byte>) {
        var byteStream = ByteArrayStream()
        byteStream.write(value)
        this.input = byteStream
        this.decoder = decoder
    }

    public func readObject(): ASN1Object {
        try {
            var tag: ASN1Tag = (decoder.readTag(this) as ASN1Tag).getOrThrow()
            logger.trace("Read ASN.1 tag")
            var length: Int64 = decoder.readLength(this)
            logger.trace("Read ASN.1 object length: ${length}")
            var value: Array<Byte> = decoder.readValue(length, this)
            var parse: ASN1Object = tag.newParser(decoder).parse(tag, value)
            logger.debug("Read ASN.1 object")
            return parse
        } catch (pe: ASN1ParseException) {
            throw pe
        } catch (e: Exception) {
            throw ASN1ParseException("Cannot parse ASN.1 object from stream")
        }
        throw ASN1ParseException("Cannot parse ASN.1 object from stream")
    }

    public func readValue(length: Int64): Array<Byte> {
        return decoder.readValue(length, this)
    }

    public override func iterator(): Iterator<ASN1Object> {
        return IteratorASN1Object(this)
    }

    public func readTag(): ASN1Tag {
        return (decoder.readTag(this) as ASN1Tag).getOrThrow()
    }

    public func readLength(): Int64 {
        return decoder.readLength(this)
    }

    public override func read(buffer: Array<Byte>): Int64 {
        return this.input.read(buffer)
    }
}

class IteratorASN1Object <: Iterator<ASN1Object> {
    private var stream: ASN1InputStream

    init(stream: ASN1InputStream) {
        this.stream = stream
    }
    public func iterator(): Iterator<ASN1Object> {
        return this
    }

    public func next(): Option<ASN1Object> {
        try {
            return stream.readObject()
        } catch (e: Exception) {
            throw Exception(e.message)
        }
        return Option<ASN1Object>.None
    }
}
