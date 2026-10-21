/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2023-2024. All rights reserved.
 */
 
package asn1

public class ASN1OutputStream <: OutputStream {
    private var encoder: ASN1Encoder
    protected var output: OutputStream
    // 单字节写复用缓冲，避免每个字节分配临时数组（实例内使用，单实例不可跨线程并发）
    private var singleByte: Array<Byte> = Array<Byte>(1, repeat: 0)

    public init(encoder: ASN1Encoder, out: OutputStream) {
        this.output = out
        this.encoder = encoder
    }

    public func writeObject(asn1Object: ASN1Object): Unit {
        var tag: ASN1Tag = asn1Object.getTag()
        writeTag(tag)
        var asn1Serializer: ASN1Serializer = tag.newSerializer(encoder)
        writeLength(asn1Serializer.serializedLength(asn1Object))

        //noinspection unchecked
        asn1Serializer.serialize(asn1Object, this)
    }

    public func write(b: Array<Byte>): Unit {
        output.write(b)
    }

    public func write(b: Int64): Unit {
        singleByte[0] = UInt8(b & 255)
        output.write(singleByte)
    }

    private func writeLength(length: Int64): Unit {
        // DER 要求长度采用最小编码：0x7f 及以内用短格式，否则用长格式
        if (length < 0x80) {
            write(length)
        } else {
            var nrBytes: Int64 = lengthBytes(length)
            write(0x80 | nrBytes)
            while (nrBytes > 0) {
                write(length >> ((nrBytes - 1) * 8))
                nrBytes--
            }
        }
    }

    private func lengthBytes(length: Int64): Int64 {
        var l: Int64 = length
        var nrBytes: Int64 = 1
        while (l > 255) {
            nrBytes++
            l >>= 8
        }
        return nrBytes
    }

    // 高 tag 号续行编码复用缓冲（实例内使用，单实例不可跨线程并发）
    private var tagBytes: Array<Byte> = Array<Byte>(10, repeat: 0)

    private func writeTag(tag: ASN1Tag): Unit {
        let head: Int64 = tag.getAsn1TagClass().getValue() | tag.getAsn1Encoding().getValue()
        let tagNo: Int64 = tag.getTag()
        if (tagNo <= 0x1e) {
            write(Int64(UInt8(head | tagNo)))
        } else {
            // 高 tag 号：低 5 位写 0x1F 引导，后续按 base-128 续行（与解码侧循环对称）
            write(Int64(UInt8(head | 0x1f)))
            var idx: Int64 = 10
            var n: Int64 = tagNo
            while (n > 0) {
                idx--
                tagBytes[idx] = UInt8(n & 0x7f)
                n = n >> 7
            }
            // 从高到低输出，除最低组（最后一字节）外均置续行标志
            var j: Int64 = idx
            while (j < 9) {
                tagBytes[j] = tagBytes[j] | 0x80
                j++
            }
            while (idx < 10) {
                write(Int64(tagBytes[idx]))
                idx++
            }
        }
    }
}
