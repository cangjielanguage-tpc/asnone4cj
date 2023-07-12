package asn1.util

from encoding import hex.*
from std import overflow.*
from std import format.*
from std import collection.*

public class DecoderUtils {
    /**
     * 解码
     * 第一步：将Array<Byte>转二进制字符串
     * 第二步：通过二进制判断正负
     * 第三步：通过二进制计算数据值
     */
    public static func asn1Decode(value: Array<Byte>): BigInt {
        var strBin: String = ""
        for (i in 0..value.size) {
            var byte: Byte = value[i]

            // byte转二进制字符串
            var byteStr: String = byte.format("B")
            var strLength: Int64 = byteStr.size

            // 二进制不够八位高位补0
            for (k in 0..(8 - strLength)) {
                k
                byteStr = "0" + byteStr
            }
            strBin = strBin + byteStr
        }

        // 将二进制字符串变成字符数组
        var charArr1: Array<Char> = strBin.toArray()
        var str1: String = charArr1[0].toString()

        var allNumber1: BigInt = BigInt(0)

        // 从第二位开始循环
        for (i in 1..charArr1.size) {
            var charStr: String = charArr1[i].toString()

            // 判断负数取反码
            if (str1.equals("1")) {
                match (charStr) {
                    case "0" => charStr = "1"
                    case "1" => charStr = "0"
                    case _ => ()
                }
            }
            var intNumber: Int64 = Int64.parse(charStr)
            var intFor: BigInt = BigInt(intNumber)

            // 通过位数转int
            for (k in 0..(charArr1.size - 1 - i)) {
                k
                intFor = intFor * 2
            }
            allNumber1 = allNumber1 + intFor
        }

        // 判断符号负数加一加符号
        if (str1.equals("1")) {
            allNumber1 = allNumber1 + 1
            allNumber1 = -allNumber1
        }
        return allNumber1
    }
}
