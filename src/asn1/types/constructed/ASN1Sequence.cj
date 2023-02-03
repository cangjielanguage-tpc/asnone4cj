package asn1.types.constructed

from std import collection.ArrayList
from std import io.ByteArrayStream
from std import io.IOException
from std import format.Formatter
import asn1.ASN1OutputStream
import asn1.ASN1Parser
import asn1.ASN1Serializer
import asn1.types.ASN1Object
import asn1.types.ASN1Tag
import asn1.types.ASN1Constructed
import asn1.encodingrules.ASN1Decoder
import asn1.encodingrules.ASN1Encoder

public class ASN1Sequence <: ASN1Object & ASN1Constructed {
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
        try {
            var stream: ASN1InputStream = ASN1InputStream(decoder, value)
            for (asn1Object in stream) {
                list.append(asn1Object)
            }
        } catch (ioe: IOException) {
            throw ASN1ParseException(ioe, "Unable to parse the ASN.1 SEQUENCE contents.", Array<Formatter>())
        }
        return ASN1Sequence(list, value)
    }
}

class SeqSerializer <: ASN1Serializer {
    public init(encoder: ASN1Encoder) {
        super(encoder)
    }

    public func serializedLength(asn1Object: ASN1Object): Int64 {
        var object: ASN1Sequence = (asn1Object as ASN1Sequence).getOrThrow()
        if (object.bytes.isEmpty()) {
            calculateBytes(object)
        }
        return object.bytes.size
    }

    public func serialize(asn1Object: ASN1Object, stream: ASN1OutputStream): Unit {
        var object: ASN1Sequence = (asn1Object as ASN1Sequence).getOrThrow()
        if (!object.bytes.isEmpty()) {
            stream.write(object.bytes)
        } else {
            for (v in object) {
                stream.writeObject(v)
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
