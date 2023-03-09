package asn1.util

public class EncodingUtils {
    /**
     * 编码
     * 第一步：将数据转换成二进制字符串
     * 第二步：区分传入数据的正负值
     * 第三步：负数进行补码操作，在转换成Array<Byte>数组
     * 第四步：正数转换成Array<Byte>数组
     */
    public static func asn1Encoded(value: BigInt): Array<Byte> {
        // 将BigInt转换成二进制字符串
        var valueBinStr: String = value.toStringBin()

        // 字符串转字符串数组
        var charBinArr: Array<Char> = valueBinStr.toArray()
        var strBin: String = charBinArr[0].toString()
        if (strBin.equals("-")) {
            return minusEncoding(valueBinStr, strBin, charBinArr)
        } else {
            return positiveEncoding(valueBinStr, strBin)
        }
    }

    private static func minusBinStrEncoding(valueBinStr: String, strBin: String, charBinArr: Array<Char>): BigInt {
        var allNumber: BigInt = BigInt(0)
        for (i in 1..charBinArr.size) {
            var charBinStr: String = charBinArr[i].toString()

            // 反码
            match (charBinStr) {
                case "0" => charBinStr = "1"
                case "1" => charBinStr = "0"
                case _ => ()
            }

            var intNumber: Int64 = Int64.parse(charBinStr)
            var intFor: BigInt = BigInt(intNumber)

            // 通过位数转int
            for (k in 0..(charBinArr.size - 1 - i)) {
                intFor = intFor * 2
            }
            allNumber = allNumber + intFor
        }
        allNumber = allNumber + 1
        return allNumber
    }

    private static func minusEncoding(valueBinStr: String, strBin: String, charBinArr: Array<Char>): Array<Byte> {
        var allNumber: BigInt = minusBinStrEncoding(valueBinStr, strBin, charBinArr)

        // 将BigInt转换成二进制字符串
        var valueBinStr1: String = allNumber.toStringBin()

        var valueBinStr0 = valueBinStr.slice(1, valueBinStr.size - 1)

        // 二进制 八位一个字节 还缺失多少位数
        // 原始数据8位一个字节还缺多少位
        var addLengthBinStr: Int64 = valueBinStr0.size % 8

        // 转换数据8位一个字节还缺多少位
        var addLengthBinStr1: Int64 = valueBinStr1.size % 8

        // 缺失的位数,需要补0
        var addLengthBinStr2: Int64 = addLengthBinStr - addLengthBinStr1

        // 缺失的位数,需要补1
        var addLengthBinStr3: Int64
        if (addLengthBinStr == 0) {
            addLengthBinStr3 = 0
        } else {
            addLengthBinStr3 = 8 - addLengthBinStr
        }
        var stringBuilder: StringBuilder = StringBuilder(valueBinStr1)
        for (i in 0..addLengthBinStr2) {
            stringBuilder.insert(0, "0")
        }
        for (i in 0..addLengthBinStr3) {
            stringBuilder.insert(0, "1")
        }
        var valueBinStr2 = stringBuilder.toString()

        // 重新计算数据
        // 字符串转字符串数组
        var charBinArr1: Array<Char> = valueBinStr2.toArray()
        var allNumber1: BigInt = BigInt(0)

        for (i in 0..charBinArr1.size) {
            var charBinStr: String = charBinArr1[i].toString()
            var intNumber: Int64 = Int64.parse(charBinStr)
            var intFor: BigInt = BigInt(intNumber)

            // 通过位数转int
            for (k in 0..(charBinArr1.size - 1 - i)) {
                intFor = intFor * 2
            }
            allNumber1 = allNumber1 + intFor
        }

        // 将BigIint转成十六进制的字符串
        var stringValue: String = allNumber1.toStringHex()
        if (stringValue.size.throwingMod(2) != 0) {
            stringValue = "0" + stringValue
        }
        return fromHexString(stringValue).getOrThrow()
    }

    private static func positiveEncoding(valueBinStr: String, strBin: String): Array<Byte> {
        var addLengthBinStr: Int64 = valueBinStr.size % 8
        var stringBuilder: StringBuilder = StringBuilder(valueBinStr)
        if (addLengthBinStr != 0) {
            for (i in 0..(8 - addLengthBinStr)) {
                stringBuilder.insert(0, "0")
            }
        } else {
            if (strBin.equals("1")) {
                stringBuilder.insert(0, "00000000")
            }
        }
        var valueBinStrNew: String = stringBuilder.toString()
        var arrStringByte: Array<String> = Array<String>(valueBinStrNew.size / 8, item: "")

        // 字符串转字符串数组
        var charBinArr1: Array<Char> = valueBinStrNew.toArray()
        var strTemporary: String = ""

        // 将二进制八位一个字节转换成String列表
        for (i in 0..arrStringByte.size) {
            arrStringByte[i] = valueBinStrNew.substring((i * 8), 8)
        }
        var arrByte: Array<Byte> = Array<Byte>(arrStringByte.size, item: 0)
        for (i in 0..arrStringByte.size) {
            var valueBinStr1: String = arrStringByte[i]

            // 重新计算数据
            // 字符串转字符串数组
            var charBinArr1: Array<Char> = valueBinStr1.toArray()
            var allNumber1: BigInt = BigInt(0)
            for (j in 0..charBinArr1.size) {
                var charBinStr: String = charBinArr1[j].toString()
                var intNumber: Int64 = Int64.parse(charBinStr)
                var intFor: BigInt = BigInt(intNumber)

                // 通过位数转int
                for (k in 0..(charBinArr1.size - 1 - j)) {
                    intFor = intFor * 2
                }
                allNumber1 = allNumber1 + intFor
            }

            // 将BigIint转成十进制的字符串
            var stringValue: String = allNumber1.toStringDec()
            var intValue: Int64 = Int64.parse(stringValue)
            arrByte[i] = UInt8(intValue)
        }
        return arrByte
    }
}
