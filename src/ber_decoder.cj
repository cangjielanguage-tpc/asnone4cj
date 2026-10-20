/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2023-2024. All rights reserved.
 */
 
package asn1

// 注意：dataArr 为解码器实例私有缓冲，单实例不可跨线程并发使用
public open class BERDecoder <: ASN1Decoder {
    private var dataArr: Array<Byte> = Array<Byte>(1, repeat: 0)

    private func readByte(inputStream: InputStream): Byte {
        dataArr[0] = 0
        let count: Int64 = inputStream.read(dataArr)
        if (count <= 0) {
            throw ASN1ParseException("EOF found while reading the ASN.1 object.")
        }
        return dataArr[0]
    }

    public override func readTag(inputStream: InputStream): ASN1Tag {
        try {
            let byte: Byte = readByte(inputStream)
            let asn1TagClass: ASN1TagClass = ASN1TagClass.parseClass(byte)
            let asn1Encoding: ASN1Encoding = ASN1Encoding.parseEncoding(byte)
            let tag: Int64 = Int64(byte) & 0x1f
            if (tag <= 0x1e) {
                return ASN1Tag.resolve(asn1TagClass, tag, asn1Encoding)
            } else {
                var iTag: Int64 = 0
                var read: Byte = readByte(inputStream)
                if ((read & 0x7f) == 0) {
                    throw ASN1ParseException("corrupted stream - invalid high tag number found")
                }
                while ((read & 0x80) != 0) {
                    iTag |= (Int64(read) & 0x7f)
                    iTag <<= 7
                    read = readByte(inputStream)
                }
                iTag |= (Int64(read) & 0x7f)
                return ASN1Tag.resolve(asn1TagClass, iTag, asn1Encoding)
            }
        } catch (ioe: IOException) {
            let list: Array<ToString> = [ioe.toString()]
            throw ASN1ParseException("Unable to parse ASN.1 tag", list)
        }
    }

    public override func readLength(inputStream: InputStream): Int64 {
        try {
            let firstByte: Byte = readByte(inputStream)
            if (firstByte <= 0x7f) {
                return Int64(firstByte)
            }
            let nrBytes: Int64 = Int64(firstByte) & 0x7f
            var longLength: Int64 = 0
            for (_ in 0..nrBytes) {
                longLength = longLength << 8
                longLength += Int64(readByte(inputStream))
            }
            if (longLength == 0) {
                throw ASN1ParseException("The indefinite length form is not (yet) supported!")
            }
            return longLength
        } catch (ioe: IOException) {
            let list: Array<ToString> = [ioe.toString()]
            throw ASN1ParseException("Unable to read the length of the ASN.1 object.", list)
        }
    }

    public override func readValue(length: Int64, inputStream: InputStream): Array<Byte> {
        if (length <= 0) {
            return Array<Byte>()
        }
        try {
            let value: Array<Byte> = Array<Byte>(length, repeat: 0)
            var count: Int64 = inputStream.read(value)
            // 常规路径一次读满；流式数据源可能部分返回，逐字节补齐，避免截断数据静默出错
            while (count < length) {
                value[count] = readByte(inputStream)
                count++
            }
            return value
        } catch (ioe: IOException) {
            let list: Array<ToString> = [ioe.toString()]
            throw ASN1ParseException("Unable to read the value of the ASN.1 object", list)
        }
    }
}
