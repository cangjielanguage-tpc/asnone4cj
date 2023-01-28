package asn1.types.constructed

import asn1.encodingrules.ber.*

public class ASN1TaggedObject <: ASN1Object & Iterable<ASN1Object> {
    private var object: ?ASN1Object
    private var decoder: ASN1Decoder = BERDecoder()
    protected var bytes: Array<Byte>
    private var explicit: Bool = true
    private var tags: ASN1Tag

    protected init(tag: ASN1Tag, object: ?ASN1Object, explicit: Bool) {
        //TODO
        super(tag)
        this.object = object
        this.tags = tag
        this.explicit = explicit
        this.bytes = Array<Byte>()
    }

    public init(tag: ASN1Tag, object: ?ASN1Object) {
        this(tag, object, true)
    }

    protected init(tag: ASN1Tag, bytes: Array<Byte>, decoder: ASN1Decoder) {
        super(tag)
        this.bytes = bytes
        this.tags = tag
        this.decoder = decoder
        object = Option<ASN1Object>.None
    }

    public func isExplicit(): Bool {
        return explicit
    }

    public func getValue(): ASN1Object {
        return object.getOrThrow()
    }

    public func getTagNo(): Int64 {
        return tags.getTag()
    }

    public func iterator(): Iterator<ASN1Object> {
        // TODO
        throw Exception("")
    }

    public func getObject(): ASN1Object {
        match (object) {
            case None => return object.getOrThrow()
            case Some(v) => return object.getOrThrow()
        }
        // TODO
    }

    public func getObject(tag: ASN1Object): ASN1Object {
        // TODO
        return object.getOrThrow()
    }

    public func toString(): String {
        var b: StringBuilder = StringBuilder()
        b.append("ASN1TaggedObject")
        b.append("[")
        match (object) {
            case Some(v) => b.append(",")

            //b.append(object.getOrThrow())
            case None => b.append(",<unknown>")
        }
        b.append("]")
        return b.toString()
    }
}

class TaggedObjectParser <: ASN1Parser {
    private var decoders: ASN1Decoder
    public init(decoder: ASN1Decoder) {
        super(decoder)
        this.decoders = decoder
    }

    public func parse(asn1Tag: ASN1Tag, value: Array<Byte>): ASN1Object {
        return ASN1TaggedObject(asn1Tag, value, decoder)
    }
}

class TaggedObjectSerializer <: ASN1Serializer {
    public init(encoder: ASN1Encoder) {
        super(encoder)
    }

    public func serializedLength(asn1Object: ASN1Object): Int64 {
        var object = (asn1Object as ASN1TaggedObject).getOrThrow()
        if (object.bytes.isEmpty()) {
            calculateBytes(object);
        }
        return object.bytes.size
    }

    public func serialize(asn1Object: ASN1Object, stream: ASN1OutputStream): Unit {
        var object = (asn1Object as ASN1TaggedObject).getOrThrow()
        if (object.bytes.isEmpty()) {
            calculateBytes(object)
        }
        stream.write(object.bytes)
    }

    private func calculateBytes(asn1Object: ASN1TaggedObject): Unit {
        var out: ByteArrayStream = ByteArrayStream()
        var asn1OutputStream: ASN1OutputStream = ASN1OutputStream(encoder, out)
        for (object in asn1Object) {
            asn1OutputStream.writeObject(object)
        }
        asn1Object.bytes = out.bytes()
    }
}
