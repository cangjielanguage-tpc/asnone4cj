package asn1.types.primitive

import asn1.ASN1Parser
import asn1.ASN1Serializer
import asn1.ASN1OutputStream
import asn1.types.ASN1Tag
import asn1.types.ASN1Object
import asn1.types.ASN1Primitive
import asn1.encodingrules.ASN1Decoder
import asn1.encodingrules.ASN1Encoder
import asn1.util.Checks

public class ASN1Enumerated<T> <: ASN1PrimitiveValue<T> {
    protected var value: Int64 = 0

    public init(value: Int64) {
        super(ASN1Tag.ENUMERATED);
        this.value = value
    }

    public init(value: Int64, valueBytes: Array<Byte>) {
        super(ASN1Tag.ENUMERATED, valueBytes);
        this.value = value
    }

    public override func getValue(): Any {
        return value
    }
}

public class EnumeratedParser<T> <: ASN1Parser<T> where T <: ASN1Object<T> {
    public init(decoder: ASN1Decoder) {
        super(decoder)
    }

    public override func parse(asn1Tag: ASN1Tag, value: Array<Byte>): ASN1Object<T> {
        // TODO
        return ASN1Enumerated<T>(0, value)
    }
}

public class SerializerEnumerated<T> <: ASN1Serializer<T> where T <: ASN1Object<T> {
    public init(encoder: ASN1Encoder) {
        super(encoder)
    }

    public override func serializedLength(asn1Object: T): Int64 {
        var object = (asn1Object as ASN1Enumerated<T>).getOrThrow()
        if (object.valueBytes.isEmpty()) {
            calculateBytes(object);
        }
        return object.valueBytes.size;
    }

    public override func serialize(asn1Object: T, stream: ASN1OutputStream): Unit {
        var object = (asn1Object as ASN1Enumerated<T>).getOrThrow()
        if (object.valueBytes.isEmpty()) {
            calculateBytes(object);
        }
        stream.write(object.valueBytes);
    }

    private func calculateBytes(asn1Object: ASN1Enumerated<T>): Unit {
        // TODO
    }
}
