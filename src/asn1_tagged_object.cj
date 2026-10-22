/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2023-2024. All rights reserved.
 */
 
package asn1

public class ASN1TaggedObject <: ASN1Object & ASN1Constructed {
    // object 与 explicit 不对外暴露可变引用，避免编码过程中被外部并发改写
    protected var object: ?ASN1Object
    // None 表示尚未编码；Some(空数组) 表示已编码且内容为空，两者语义不同
    protected var bytes: Option<Array<Byte>>
    private var decoder: ASN1Decoder = BERDecoder()
    protected var explicit: Bool = true
    private var tags: ASN1Tag

    public init(tag: ASN1Tag, object: ?ASN1Object, explicit: Bool) {
        super(formatMessage(tag, object, explicit))
        this.object = object
        this.tags = tag
        this.explicit = explicit
        this.bytes = None
    }

    public init(tag: ASN1Tag, object: ?ASN1Object) {
        this(tag, object, true)
    }

    public init(tag: ASN1Tag, bytes: Array<Byte>, decoder: ASN1Decoder) {
        super(tag)
        this.bytes = Some(bytes)
        this.tags = tag
        this.decoder = decoder
        object = Option<ASN1Object>.None
    }

    public func isExplicit(): Bool {
        return explicit
    }

    public func getValue(): ASN1Object {
        return getObject()
    }

    public func getTagNo(): Int64 {
        return tags.getTag()
    }

    public func iterator(): Iterator<ASN1Object> {
        var seq: ASN1Sequence = (getObject(SEQUENCE) as ASN1Sequence).getOrThrow()
        return seq.iterator()
    }

    public func getObject(): ASN1Object {
        match (object) {
            case None =>
                match (bytes) {
                    case Some(b) =>
                        try {
                            var inputStream: ASN1InputStream = ASN1InputStream(decoder, b)
                            return inputStream.readObject()
                        } catch (asn1ParseException: ASN1ParseException) {
                            // 对齐上游：将 tag 信息作为 %s 参数携带进异常消息
                            let list: Array<ToString> = [tags.toString()]
                            throw ASN1ParseException(
                                asn1ParseException,
                                "Unable to parse the explicit Tagged Object with %s, it might be implicit",
                                list
                            )
                        } catch (ioe: IOException) {
                            throw ASN1ParseException(ioe, "Could not parse the inputstream", Array<ToString>())
                        }
                    case None =>
                        throw ASN1ParseException("Tagged object has no content to parse.")
                }
            case Some(v) =>
                return v
        }
    }

    public func getObject(tag: ASN1Tag): ASN1Object {
        match (object) {
            case Some(v) =>
                if (v.getTag().equals(tag)) {
                    return v
                }
            case None =>
                match (bytes) {
                    case Some(b) =>
                        // 空 bytes 同样交给解析器处理（对齐上游语义），由解析器决定合法性
                        return tag.newParser(decoder).parse(tag, b)
                    case None => ()
                }
        }
        // 对齐上游：将 tag 信息作为 %s 参数携带进异常消息
        throw ASN1ParseException("Unable to parse the implicit Tagged Object with %s, it is explicit", [tags.toString()])
    }

    protected override func valueString(): String {
        match (object) {
            case Some(v) => return v.toString()
            case None =>
                match (bytes) {
                    case Some(b) => return b.toString()
                    case None => return "<unencoded>"
                }
        }
    }

    public func toString(): String {
        var b: StringBuilder = StringBuilder()
        b.append("ASN1TaggedObject")
        b.append("[")
        b.append(tag.toString())
        match (object) {
            case Some(v) =>
                b.append(",")
                b.append(v)
            case None => b.append(",<unknown>")
        }
        b.append("]")
        return b.toString()
    }
}

func formatMessage(tag: ASN1Tag, object: ?ASN1Object, explicit: Bool): ASN1Tag {
    if (explicit) {
        return tag.constructed()
    } else {
        return tag.asEncoded(object.getOrThrow().getTag().getAsn1Encoding())
    }
}

class TaggedObjectParser <: ASN1Parser {
    public init(decoder: ASN1Decoder) {
        super(decoder)
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
        var object: ASN1TaggedObject = (asn1Object as ASN1TaggedObject).getOrThrow()
        match (object.bytes) {
            case Some(b) => return b.size
            case None =>
                calculateBytes(object)
                return (object.bytes.getOrThrow()).size
        }
    }

    public func serialize(asn1Object: ASN1Object, stream: ASN1OutputStream): Unit {
        var object: ASN1TaggedObject = (asn1Object as ASN1TaggedObject).getOrThrow()
        match (object.bytes) {
            case Some(b) => stream.write(b)
            case None => calculateBytes(object)
        }
    }

    private func calculateBytes(asn1Object: ASN1TaggedObject): Unit {
        var object: ASN1Object = asn1Object.object.getOrThrow()
        var out: ByteBuffer = ByteBuffer()
        var asn1OutputStream: ASN1OutputStream = ASN1OutputStream(encoder, out)
        if (asn1Object.explicit) {
            asn1OutputStream.writeObject(object)
        } else {
            object.getTag().newSerializer(encoder).serialize(object, asn1OutputStream)
        }
        asn1Object.bytes = Some(out.bytes())
    }
}
