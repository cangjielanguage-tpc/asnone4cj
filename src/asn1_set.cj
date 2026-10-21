/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2023-2024. All rights reserved.
 */
 
package asn1

public class ASN1Set <: ASN1Object & ASN1Constructed {
    private var objects: HashSet<ASN1Object>
    // None 表示尚未编码；Some(空数组) 表示已编码且内容为空，两者语义不同
    protected var bytes: Option<Array<Byte>> = None

    public init(objects: HashSet<ASN1Object>, bytes: Array<Byte>) {
        super(SET)
        this.objects = objects
        this.bytes = bytes
    }

    public init(objects: HashSet<ASN1Object>) {
        super(SET)
        this.objects = objects
    }

    public func getValue(): HashSet<ASN1Object> {
        // 返回拷贝，避免外部修改内部状态
        return HashSet<ASN1Object>(objects)
    }

    public func iterator(): Iterator<ASN1Object> {
        return HashSet<ASN1Object>(objects).iterator()
    }

    protected override func valueEquals(other: ASN1Object): Bool {
        match (other as ASN1Set) {
            case Some(that) =>
                if (objects.size != that.getValue().size) {
                    return false
                }
                // SET 无序：逐元素在对方集合中查找
                var thatObjects: HashSet<ASN1Object> = that.getValue()
                for (v in objects) {
                    if (!thatObjects.contains(v)) {
                        return false
                    }
                }
                return true
            case None => return false
        }
    }
}

class SetParser <: ASN1Parser {
    public init(decoder: ASN1Decoder) {
        super(decoder)
    }

    public func parse(_: ASN1Tag, value: Array<Byte>): ASN1Object {
        var asn1Objects: HashSet<ASN1Object> = HashSet<ASN1Object>()
        try {
            var stream: ASN1InputStream = ASN1InputStream(decoder, value)
            for (asn1Object in stream) {
                asn1Objects.add(asn1Object)
            }
        } catch (ioe: IOException) {
            throw ASN1ParseException(ioe, "Could not parse ASN.1 SET contents.", Array<ToString>())
        }
        return ASN1Set(asn1Objects, value)
    }
}

class SetSerializer <: ASN1Serializer {
    public init(encoder: ASN1Encoder) {
        super(encoder)
    }

    public func serializedLength(asn1Object: ASN1Object): Int64 {
        var objects: ASN1Set = (asn1Object as ASN1Set).getOrThrow()
        match (objects.bytes) {
            case Some(b) => return b.size
            case None =>
                calculateBytes(objects)
                return (objects.bytes.getOrThrow()).size
        }
    }

    public func serialize(asn1Object: ASN1Object, stream: ASN1OutputStream): Unit {
        var objects: ASN1Set = (asn1Object as ASN1Set).getOrThrow()
        match (objects.bytes) {
            case Some(b) => stream.write(b)
            case None =>
                for (v in objects) {
                    stream.writeObject(v)
                }
        }
    }

    private func calculateBytes(asn1Object: ASN1Set): Unit {
        var outs: ByteBuffer = ByteBuffer()
        var asn1OutputStream: ASN1OutputStream = ASN1OutputStream(encoder, outs)
        for (object in asn1Object) {
            asn1OutputStream.writeObject(object)
        }
        asn1Object.bytes = Some(outs.bytes())
    }
}
