package asn1.types.constructed

from std import collection.*
from std import io.*
import asn1.*
import asn1.types.*
import asn1.encodingrules.*

public class ASN1Sequence<T> <: ASN1Object<T> & Iterable<ASN1Object<T>> {
    private var objects: ArrayList<ASN1Object<T>>
    protected var bytes: Array<Byte> = Array<Byte>()

    protected init(objects: ArrayList<ASN1Object<T>>, bytes: Array<Byte>) {
        super(ASN1Tag.SEQUENCE)
        this.objects = objects
        this.bytes = bytes
    }

    public init(objects: ArrayList<ASN1Object<T>>) {
        super(ASN1Tag.SEQUENCE)
        this.objects = objects
    }

    public func getValue(): ArrayList<ASN1Object<T>> {
        return objects
    }

    public func iterator(): Iterator<ASN1Object<T>> {
        return ArrayList<ASN1Object<T>>(objects).iterator()
    }

    public func size(): Int64 {
        return objects.size
    }

    public func get(i: Int64): ASN1Object<T> {
        return objects[i];
    }
}

class SeqParser<T> <: ASN1Parser<T> where T <: ASN1Object<T> {

    public init(decoder: ASN1Decoder) {
        super(decoder)
    }

    public func parse(asn1Tag: ASN1Tag, value: Array<Byte>): ASN1Object<T> {
        var list: ArrayList<ASN1Object<T>> = ArrayList<ASN1Object<T>>()
        return ASN1Sequence<T>(list, Array<Byte>())
    }
}

class SeqSerializer<T> <: ASN1Serializer<T> where T <: ASN1Object<T>  {
    public init(encoder: ASN1Encoder) {
        super(encoder)
    }

    public func parse( asn1Tag: ASN1Tag, value: Array<Byte>): ASN1Object<T> {
        var list: ArrayList<ASN1Object<T>> = ArrayList<ASN1Object<T>>()
        return ASN1Sequence<T>(list, Array<Byte>())
    }

    public func serializedLength(asn1Object: T): Int64 {
        var object = (asn1Object as ASN1Sequence<T>).getOrThrow()
        if (object.bytes.isEmpty()) {
            calculateBytes(object);
        }
        return object.bytes.size
    }

    public func serialize(asn1Object: T, stream: ASN1OutputStream): Unit {
        var object = (asn1Object as ASN1Sequence<T>).getOrThrow()
        if (!object.bytes.isEmpty()) {
            ()
            stream.write(object.bytes)
        } else {
            for (v in object) {
                stream.writeObject(object)
            }
        }
    }

    private func calculateBytes(asn1Object: ASN1Sequence<T>): Unit {
        var out: ByteArrayStream = ByteArrayStream()
        var asn1OutputStream: ASN1OutputStream = ASN1OutputStream(encoder, out)
        for (object in asn1Object) {
            asn1OutputStream.writeObject(object)
        }
        asn1Object.bytes = out.bytes()
    }
}
