package asn1.types.constructed

from std import collection.*
from std import io.*
import asn1.*
import asn1.types.*
import asn1.encodingrules.*

public class ASN1Sequence <: ASN1Object & Iterable<ASN1Object> {
    private var objects: ArrayList<ASN1Object>
    protected var bytes: Array<Byte> = Array<Byte>()

    protected init(objects: ArrayList<ASN1Object>, bytes: Array<Byte>) {
        super(ASN1Tag.SEQUENCE)
        this.objects = objects
        this.bytes = bytes
    }

    public init(objects: ArrayList<ASN1Object>) {
        super(ASN1Tag.SEQUENCE)
        this.objects = objects
    }

    public func getValue(): ArrayList<ASN1Object> {
        return objects
    }

    public func iterator(): Iterator<ASN1Object> {
        return ArrayList<ASN1Object>(objects).iterator()
    }

    public func size(): Int64 {
        return objects.size
    }

    public func get(i: Int64): ASN1Object {
        return objects[i]
    }
}

class SeqParser <: ASN1Parser {
    public init(decoder: ASN1Decoder) {
        super(decoder)
    }

    public func parse(asn1Tag: ASN1Tag, value: Array<Byte>): ASN1Object {
        var list: ArrayList<ASN1Object> = ArrayList<ASN1Object>()
        return ASN1Sequence(list, Array<Byte>())
    }
}

class SeqSerializer <: ASN1Serializer {
    public init(encoder: ASN1Encoder) {
        super(encoder)
    }

    public func serializedLength(asn1Object: ASN1Object): Int64 {
        var object = (asn1Object as ASN1Sequence).getOrThrow()
        if (object.bytes.isEmpty()) {
            calculateBytes(object);
        }
        return object.bytes.size
    }

    public func serialize(asn1Object: ASN1Object, stream: ASN1OutputStream): Unit {
        var object = (asn1Object as ASN1Sequence).getOrThrow()
        if (!object.bytes.isEmpty()) {
            ()
            stream.write(object.bytes)
        } else {
            for (v in object) {
                stream.writeObject(object)
            }
        }
    }

    private func calculateBytes(asn1Object: ASN1Sequence): Unit {
        var out: ByteArrayStream = ByteArrayStream()
        var asn1OutputStream: ASN1OutputStream = ASN1OutputStream(encoder, out)
        for (object in asn1Object) {
            asn1OutputStream.writeObject(object)
        }
        asn1Object.bytes = out.bytes()
    }
}
