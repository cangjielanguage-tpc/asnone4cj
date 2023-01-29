package asn1.types.constructed


public class ASN1Set <: ASN1Object & Iterable<ASN1Object> {

    private var objects: HashSet<ASN1Object>
    protected var bytes: Array<Byte> = Array<Byte>()

    private init (objects: HashSet<ASN1Object>, bytes: Array<Byte>) {
        super(ASN1Tag.SET)
        this.objects = objects
        this.bytes = bytes
    }

    public init (objects: HashSet<ASN1Object>) {
        super(ASN1Tag.SET)
        this.objects = objects
    }

    public func getValue(): HashSet<ASN1Object> {
        return objects
    }

    public func iterator(): Iterator<ASN1Object> {
        return this.objects.iterator()
    }

}

class SetParser <: ASN1Parser {

    public init(decoder: ASN1Decoder) {
        super(decoder)
    }

    public func parse(asn1Tag: ASN1Tag, value: Array<Byte>): ASN1Object {
        var asn1Objects: HashSet<ASN1Object> = HashSet<ASN1Object>()
        return ASN1Set(asn1Objects)
    }
}
class SetSerializer <: ASN1Serializer {

    public init(encoder: ASN1Encoder) {
        super(encoder)
    }

    public func serializedLength(asn1Object: ASN1Object): Int64 {
        var objects = (asn1Object as ASN1Set).getOrThrow()
        if (objects.bytes.isEmpty()) {
            calculateBytes(objects);
        }
        return objects.bytes.size
    }

    public func serialize(asn1Object: ASN1Object, stream: ASN1OutputStream): Unit {
        var objects = (asn1Object as ASN1Set).getOrThrow()
        if (!objects.bytes.isEmpty()) {
            ()
            stream.write(objects.bytes)
        } else {
            for (v in objects) {
                stream.writeObject(objects)
            }
        }
    }

    private func calculateBytes(asn1Object: ASN1Set): Unit {
        var outs: ByteArrayStream = ByteArrayStream()
        var asn1OutputStream: ASN1OutputStream = ASN1OutputStream(encoder, outs)
        for (object in asn1Object) {
            asn1OutputStream.writeObject(object)
        }
        asn1Object.bytes = outs.bytes()
    }
}
