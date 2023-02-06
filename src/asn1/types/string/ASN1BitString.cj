package asn1.types.string

from std import io.ByteArrayStream
import asn1.types.ASN1Parser
import asn1.types.ASN1Serializer
import asn1.ASN1OutputStream
import asn1.ASN1InputStream
import asn1.types.ASN1ParseException
import asn1.types.ASN1Object
import asn1.types.ASN1Tag
import asn1.encodingrules.ASN1Decoder
import asn1.encodingrules.ASN1Encoder
import asn1.util.Checks

public class ASN1BitString <: ASN1String {
    public var unusedBits: Int64 = 0
    private var bits: Array<Bool> = Array<Bool>()

    public init(tag: ASN1Tag, bytes: Array<Byte>, unusedBits: Int64) {
        super(tag, bytes)
        this.unusedBits = unusedBits
        this.bits = constructBits()
    }

    public init(bytes: Array<Byte>, unusedBits: Int64) {
        this(ASN1Tag.BIT_STRING, bytes, unusedBits)
    }

    public init(bits: Array<Bool>) {
        super(ASN1Tag.BIT_STRING, constructBytes(bits))
        this.bits = bits
        this.unusedBits = 8 - (bits.size % 8)
    }

    public init(bitSet: Any) {
        // TODO
        // BitSet
        this(ASN1Tag.BIT_STRING, constructBytes(bitSet), 0)
    }

    private static func constructBytes(bits: Array<Bool>): Array<Byte> {
        var length: Int64
        if (bits.size % 8 > 0) {
            length = bits.size / 8 + 1
        } else {
            length = bits.size / 8
        }
        var bytes: Array<Byte> = Array<Byte>()
        for (i in 0..bytes.size) {
            bytes[i] = 0
            for (j in 0..8) {
                var v: Bool = i * 8 + j < bits.size && bits[i * 8 + j]
                if (v) {
                    bytes[i] += 1 << (8 - j - 1)
                } else {
                    bytes[i] += 0 << (8 - j - 1)
                }
            }
        }
        return bytes
    }

    private static func constructBytes(bitSet: Any): Array<Byte> {
        // TODO
        return Array<Byte>()
    }

    private func constructBits(): Array<Bool> {
        var bits: Array<Bool> = Array<Bool>()
        for (i in 0..bits.size) {
            bits[i] = isSet(i)
        }
        return bits
    }

    public override func getValue(): Any {
        var copyList: Array<Bool> = Array<Bool>()
        bits.copyTo(copyList, 0, 0, this.bits.size)
        return copyList
    }

    protected override func valueString(): String {
        return bits.toString()
    }

    public func isSet(x: Int64): Bool {
        var toCheck: Int64 = x / 8
        var theByte: Byte = valueBytes[toCheck]
        var index: Int64 = x % 8
        var mask: Int64 = 1 << (7 - index)
        var masked: Int64 = theByte.position() & mask
        return masked != 0
    }

    public override func length(): Int64 {
        return (valueBytes.size * 8) - unusedBits
    }
}

public class BitStringParser <: ASN1Parser {
    public init(decoder: ASN1Decoder) {
        super(decoder)
    }

    public override func parse(asn1Tag: Any, value: Array<Byte>): ASN1Object {
        var asn1test: ASN1Tag = (asn1Tag as ASN1Tag).getOrThrow()
        if (asn1test.isConstructed()) {
            try {
                var stream: ASN1InputStream = ASN1InputStream(decoder, value)
                var baos: ByteArrayStream = ByteArrayStream()
                var unusedBits: Int64 = 0
                while (stream.length > 0) {
                    var subTag: ASN1Tag = stream.readTag()
                    Checks.checkState(
                        subTag.getTag() == asn1test.getTag(),
                        "Expected an ASN.1 BIT STRING as Constructed object, got",
                        Array<ToString>()
                    )
                    var i: Int64 = stream.readLength()
                    var subValue: Array<Byte> = stream.readValue(i)
                    baos.write(subValue)
                    if (stream.length <= 0) {
                        // Last ASN.1 BitString
                        unusedBits = Int64(subValue[0])
                    }
                }
                return ASN1BitString(asn1test, baos.bytes(), unusedBits)
            } catch (exception: Exception) {
                throw ASN1ParseException("Unable to parse Constructed ASN.1 BIT STRING")
            }
        } else {
            var unusedBits: Byte = value[0]
            var bits: Array<Byte> = Array<Byte>()
            value.copyTo(bits, 1, 1, value.size)
            return ASN1BitString(asn1test, bits, Int64(unusedBits))
        }
    }
}

public class BitStringSerializer <: ASN1Serializer {
    public init(encoder: ASN1Encoder) {
        super(encoder)
    }

    public override func serializedLength(asn1Object: Any): Int64 {
        var object: ASN1BitString = (asn1Object as ASN1BitString).getOrThrow()
        return object.valueBytes.size + 1
    }

    public override func serialize(asn1Object: Any, stream: Any): Unit {
        var object: ASN1BitString = (asn1Object as ASN1BitString).getOrThrow()
        var stream1: ASN1OutputStream = (stream as ASN1OutputStream).getOrThrow()
        stream1.write(object.unusedBits)
        stream1.write(object.valueBytes)
    }
}
