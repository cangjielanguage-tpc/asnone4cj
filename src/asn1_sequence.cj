/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2023-2024. All rights reserved.
 */
 
package asn1

public class ASN1Sequence <: ASN1Object & ASN1Constructed {
    private var objects: ArrayList<ASN1Object>
    // None 表示尚未编码；Some(空数组) 表示已编码且内容为空，两者语义不同
    protected var bytes: Option<Array<Byte>> = None

    public init(objects: ArrayList<ASN1Object>, bytes: Array<Byte>) {
        super(SEQUENCE)
        this.objects = objects
        this.bytes = bytes
    }

    public init(objects: ArrayList<ASN1Object>) {
        super(SEQUENCE)
        this.objects = objects
    }

    public func getValue(): ArrayList<ASN1Object> {
        // 返回拷贝，避免外部修改内部状态
        return ArrayList<ASN1Object>(objects)
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

    protected override func valueEquals(other: ASN1Object): Bool {
        match (other as ASN1Sequence) {
            case Some(that) =>
                if (objects.size != that.size()) {
                    return false
                }
                for (i in 0..objects.size) {
                    if (objects[i] != that.get(i)) {
                        return false
                    }
                }
                return true
            case None => return false
        }
    }
}

class SeqParser <: ASN1Parser {
    public init(decoder: ASN1Decoder) {
        super(decoder)
    }

    public func parse(_: ASN1Tag, value: Array<Byte>): ASN1Object {
        var list: ArrayList<ASN1Object> = ArrayList<ASN1Object>()
        try {
            var stream: ASN1InputStream = ASN1InputStream(decoder, value)
            for (asn1Object in stream) {
                list.add(asn1Object)
            }
        } catch (ioe: IOException) {
            throw ASN1ParseException(ioe, "Unable to parse the ASN.1 SEQUENCE contents.", Array<ToString>())
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
        match (object.bytes) {
            case Some(b) => return b.size
            case None =>
                calculateBytes(object)
                return (object.bytes.getOrThrow()).size
        }
    }

    public func serialize(asn1Object: ASN1Object, stream: ASN1OutputStream): Unit {
        var object: ASN1Sequence = (asn1Object as ASN1Sequence).getOrThrow()
        match (object.bytes) {
            case Some(b) => stream.write(b)
            case None =>
                for (v in object) {
                    stream.writeObject(v)
                }
        }
    }

    private func calculateBytes(asn1Object: ASN1Sequence): Unit {
        var out: ByteBuffer = ByteBuffer()
        var asn1OutputStream: ASN1OutputStream = ASN1OutputStream(encoder, out)
        for (object in asn1Object) {
            asn1OutputStream.writeObject(object)
        }
        asn1Object.bytes = Some(out.bytes())
    }
}
