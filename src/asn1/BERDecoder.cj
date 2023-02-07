package asn1

import asn1.encodingrules.ASN1Decoder
import asn1.types.ASN1TagClass
import asn1.types.ASN1Encoding

public open class BERDecoder <: ASN1Decoder {
    public override func readTag(inputStream: InputStream): Any {
        try {
            var dataArr = Array<Byte>(1, item: 0)
            var tagByteLength: Int64 = inputStream.read(dataArr)
            var byte: Byte = dataArr[0]
            var asn1TagClass: ASN1TagClass = ASN1TagClass.parseClass(byte)
            var asn1Encoding: ASN1Encoding = ASN1Encoding.parseEncoding(byte)
            var tag: Int64 = Int64(byte) & 0x1f
            if (tag <= 0x1e) {
                return ASN1Tag.forTag(asn1TagClass, tag).asEncoded(asn1Encoding)
            } else {
                var iTag: Int64 = 0
                var readLength: Int64 = inputStream.read(dataArr)
                var read: Byte = dataArr[0]
                if ((read & 0x7f) == 0) {
                    throw ASN1ParseException("corrupted stream - invalid high tag number found")
                }
                while ((read >= 0) && ((read & 0x80) != 0)) {
                    iTag |= (Int64(read) & 0x7f)
                    iTag <<= 7
                    readLength = inputStream.read(dataArr)
                    read = dataArr[0]
                }
                if (read < 0) {
                    throw ASN1ParseException("EOF found inside tag value.")
                }
                iTag |= (Int64(read) & 0x7f)
                return ASN1Tag.forTag(asn1TagClass, iTag).asEncoded(asn1Encoding)
            }
        } catch (ioe: IOException) {
            let list: Array<ToString> = [ioe.toString()]
            throw ASN1ParseException("Unable to parse ASN.1 tag", list)
        }
    }

    public override func readLength(inputStream: InputStream): Int64 {
        try {
            var dataArr: Array<Byte> = Array<Byte>(1, item: 0)
            var firstByteLength: Int64 = inputStream.read(dataArr)
            var firstByte: Byte = dataArr[0]
            if (firstByte <= 0x7f) {
                return Int64(firstByte)
            }
            var nrBytes: Int64 = Int64(firstByte) & 0x7f
            var longLength: Int64 = 0
            for (i in 0..nrBytes) {
                longLength = longLength << 8
                firstByteLength = inputStream.read(dataArr)
                firstByte = dataArr[0]
                longLength += Int64(firstByte)
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
        try {
            var value: Array<Byte> = Array<Byte>(length, item: 0)
            var count: Int64 = 0
            var readLength: Int64 = 0
            while (count < length) {
                var valueRead: Array<Byte> = Array<Byte>(length - count, item: 0)
                readLength = inputStream.read(valueRead)
                if (readLength == 0) {
                    break
                }
                valueRead.copyTo(value, 0, count, valueRead.size)
                count += readLength
            }
            return value
        } catch (ioe: IOException) {
            let list: Array<ToString> = [ioe.toString()]
            throw ASN1ParseException("Unable to read the value of the ASN.1 object", list)
        }
    }
}
