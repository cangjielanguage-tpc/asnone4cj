package asn1

from encoding import hex.*
from numeric import bigint.*
from std import overflow.*

public class ASN1Integer <: ASN1PrimitiveValue {
    protected var value: CPointer<BIGNUM> = bnNew()

    public init(value: Int64) {
        super(ASN1Tag.INTEGER)
        bnSetWord(this.value, UInt64(value))
        var stringValue: String = UInt64(value).format("x")
        if (stringValue.size.throwingMod(2) != 0) {
            stringValue = "0" + stringValue
        }
        this.valueBytes = fromHexString(stringValue).getOrThrow()
    }

    public init(value: CPointer<BIGNUM>) {
        super(ASN1Tag.INTEGER)
        this.value = value
        var intValue: UInt64 = bnGetWord(value)
        var stringValue: String = intValue.format("x")
        if (stringValue.size.throwingMod(2) != 0) {
            stringValue = "0" + stringValue
        }
        this.valueBytes = fromHexString(stringValue).getOrThrow()
    }

    public init(value: CPointer<BIGNUM>, valueBytes: Array<Byte>) {
        super(ASN1Tag.INTEGER, valueBytes)
        this.value = value
    }

    public override func getValue(): Any {
        return value
    }

    public func valueHash(): Int64 {
        return bnGetWord(value).hashCode()
    }
}

public class IntegerParser <: ASN1Parser {
    public init(decoder: ASN1Decoder) {
        super(decoder)
    }

    public override func parse(asn1Tag: ASN1Tag, value: Array<Byte>): ASN1Object {
        var str: String = toHexString(value)
        var charArr: Array<Char> = str.toArray()
        var allNumber: Int64 = 0
        for (i in 0..charArr.size) {
            var charStr: String = charArr[i].toString()
            if (charStr.equals("a")) {
                charStr = "10"
            } else if (charStr.equals("b")) {
                charStr = "11"
            } else if (charStr.equals("c")) {
                charStr = "12"
            } else if (charStr.equals("d")) {
                charStr = "13"
            } else if (charStr.equals("e")) {
                charStr = "14"
            } else if (charStr.equals("f")) {
                charStr = "15"
            }
            var intNumber: Int64 = Int64.parse(charStr)
            var intFor: Int64 = intNumber
            for (k in 0..(charArr.size - 1 - i)) {
                intFor = intFor * 16
            }
            allNumber = allNumber + intFor
        }
        var valueBigNum: CPointer<BIGNUM> = bnNew()
        bnSetWord(valueBigNum, UInt64(allNumber))
        return ASN1Integer(valueBigNum, value)
    }
}

public class IntegerSerializer <: ASN1Serializer {
    public init(encoder: ASN1Encoder) {
        super(encoder)
    }

    public override func serializedLength(asn1Object: ASN1Object): Int64 {
        var object: ASN1Integer = (asn1Object as ASN1Integer).getOrThrow()
        return object.valueBytes.size
    }

    public override func serialize(asn1Object: ASN1Object, stream: ASN1OutputStream): Unit {
        var object: ASN1Integer = (asn1Object as ASN1Integer).getOrThrow()
        stream.write(object.valueBytes)
    }
}
