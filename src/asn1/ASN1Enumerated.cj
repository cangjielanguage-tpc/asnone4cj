package asn1

from cryptocj import bignumcj.BIGNUM
from cryptocj import bignumcj.bnNew
from cryptocj import bignumcj.bnGetWord
from cryptocj import bignumcj.bnSetWord

public class ASN1Enumerated <: ASN1PrimitiveValue {
    protected var value: CPointer<BIGNUM> = bnNew()

    public init(value: Int64) {
        super(ASN1Tag.ENUMERATED)
        // 将整数设置给大数对象
        bnSetWord(this.value, UInt64(value))
    }

    public init(value: CPointer<BIGNUM>) {
        super(ASN1Tag.ENUMERATED)
        this.value = value
    }

    public init(value: CPointer<BIGNUM>, valueBytes: Array<Byte>) {
        super(ASN1Tag.ENUMERATED, valueBytes)
        this.value = value
    }

    public override func getValue(): Any {
        return value
    }
}

public class EnumeratedParser <: ASN1Parser {
    public init(decoder: ASN1Decoder) {
        super(decoder)
    }

    public override func parse(asn1Tag: Any, value: Array<Byte>): ASN1Object {
        var valueNumber: Int64 = 0
        for (i in 0..value.size) {
            valueNumber += Int64(value[i])
        }
        var valueBigNum: CPointer<BIGNUM> = bnNew()
        // 将整数设置给大数对象
        bnSetWord(valueBigNum, UInt64(valueNumber))
        return ASN1Enumerated(valueBigNum, value)
    }
}

public class EnumeratedSerializer <: ASN1Serializer {
    public init(encoder: ASN1Encoder) {
        super(encoder)
    }

    public override func serializedLength(asn1Object: Any): Int64 {
        var object: ASN1Enumerated = (asn1Object as ASN1Enumerated).getOrThrow()
        if (object.valueBytes.isEmpty()) {
            calculateBytes(object)
        }
        return object.valueBytes.size
    }

    public override func serialize(asn1Object: Any, stream: Any): Unit {
        var object: ASN1Enumerated = (asn1Object as ASN1Enumerated).getOrThrow()
        var stream1: ASN1OutputStream = (stream as ASN1OutputStream).getOrThrow()
        if (object.valueBytes.isEmpty()) {
            calculateBytes(object)
        }
        stream1.write(object.valueBytes)
    }

    private func calculateBytes(asn1Object: ASN1Enumerated): Unit {
        // 将大数对象设置给整数
        asn1Object.valueBytes = bnGetWord(asn1Object.value).toString().toUtf8Array()
    }
}
