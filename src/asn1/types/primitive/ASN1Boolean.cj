package asn1.types.primitive

import asn1.ASN1Parser
import asn1.ASN1Serializer
import asn1.ASN1OutputStream
import asn1.types.ASN1Tag
import asn1.types.ASN1Object
import asn1.encodingrules.ASN1Decoder
import asn1.encodingrules.ASN1Encoder
import asn1.util.Checks

public class ASN1Boolean<T> <: ASN1PrimitiveValue<T> {
    protected var value: Bool = false

    public init(value: Bool) {
        super(ASN1Tag.ASN1_BOOLEAN)
        this.value = value
    }

    public init(value: Bool, valueBytes: Array<Byte>) {
        super(ASN1Tag.ASN1_BOOLEAN, valueBytes)
        this.value = value
    }

    public func getValue(): Any {
        return value
    }

    protected func valueHash(): Int64 {
        if (value) {
            return 1231
        } else {
            return 1237
        }
    }
}

public class BooleanParser<T> <: ASN1Parser<T> where T <: ASN1Object<T> {
    public init(decoder: ASN1Decoder) {
        super(decoder)
    }

    public override func parse(asn1Tag: ASN1Tag, value: Array<Byte>): ASN1Object<T> {
        let list: Array<Any> = [value.size]
        Checks.checkState(value.size == 1, "ASN.1 NULL can not have a value", list)
        return ASN1Boolean<T>(value[0] != 0x0, value)
    }
}

public class BooleanSerializer<T> <: ASN1Serializer<T> where T <: ASN1Object<T> {
    public init(encoder: ASN1Encoder) {
        super(encoder)
    }

    public override func serializedLength(asn1Object: T): Int64 {
        return 1
    }

    public override func serialize(asn1Object: T, stream: ASN1OutputStream): Unit {
        var object = (asn1Object as ASN1Boolean<T>).getOrThrow()
        if (object.value) {
            stream.write(0x01)
        } else {
            stream.write(0x00)
        }
    }
}
