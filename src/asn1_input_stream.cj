/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2023-2024. All rights reserved.
 */
 
package asn1

public class ASN1InputStream <: InputStream & Iterable<ASN1Object> {
    protected var input: InputStream

    private var decoder: ASN1Decoder

    public var lengths: Int64

    public init(decoder: ASN1Decoder, wrapped: InputStream) {
        this.input = wrapped
        this.lengths = match (wrapped as Seekable) {
            case Some(v) => v.remainLength
            case None => -1
        }
        this.decoder = decoder
    }

    public init(decoder: ASN1Decoder, value: Array<Byte>) {
        var byteStream = ByteBuffer()
        byteStream.write(value)
        this.input = byteStream
        this.lengths = byteStream.length
        this.decoder = decoder
    }

    public func readObject(): ASN1Object {
        try {
            // 仅当可 Seekable 流的剩余长度恰为 0 时表示正常 EOF；
            // 非 Seekable 流返回 -1，须继续读取并由 readTag 在 EOF 处抛错
            if(lengthData() == 0){
                throw NoneValueException()
            }
            var tag: ASN1Tag = decoder.readTag(this)
            var length: Int64 = decoder.readLength(this)
            var value: Array<Byte> = decoder.readValue(length, this)
            var parse: ASN1Object = tag.newParser(decoder).parse(tag, value)
            return parse
        } catch (pe: ASN1ParseException) {
            throw pe
        } catch (pe: NoneValueException) {
            throw pe
        } catch (e: Exception) {
            // 将根因信息拼入异常消息，避免丢失根因
            throw ASN1ParseException(e, "Cannot parse ASN.1 object from stream", Array<ToString>())
        }
    }

    public func readValue(length: Int64): Array<Byte> {
        return decoder.readValue(length, this)
    }

    public override func iterator(): Iterator<ASN1Object> {
        return IteratorASN1Object(this)
    }

    public func readTag(): ASN1Tag {
        return decoder.readTag(this)
    }

    public func readLength(): Int64 {
        return decoder.readLength(this)
    }

    public override func read(buffer: Array<Byte>): Int64 {
        return this.input.read(buffer)
    }

    protected func lengthData(): Int64 {
        return match (input as Seekable) {
            case Some(v) => v.remainLength
            case None => -1
        }
    }
}

class IteratorASN1Object <: Iterator<ASN1Object> {
    private var stream: ASN1InputStream

    init(stream: ASN1InputStream) {
        this.stream = stream
    }

    public func next(): Option<ASN1Object> {
        try {
            return stream.readObject()
        } catch (e: NoneValueException) {
            // 可 Seekable 流已耗尽，迭代正常结束
            return None
        } catch (e: ASN1ParseException) {
            // 非 Seekable 流读到 EOF 时抛出带 "EOF found" 前缀的解析异常，视为迭代正常结束；
            // 其余解析异常保留原始类型直接抛出，不再重新包装丢失类型信息
            if (e.message.contains("EOF found")) {
                return None
            }
            throw e
        }
    }
}
