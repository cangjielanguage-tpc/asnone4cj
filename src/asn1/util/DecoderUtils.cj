package asn1.util

from encoding import hex.*
from std import overflow.*
from std import format.*
from std import collection.*

/**
 * decode
 * Step 1: Convert Array<Byte>to a binary string
 * Step 2: Determine positive or negative through binary
 * Step 3: Calculate data values through binary
 */
public class DecoderUtils {
    /*
    * Convert Array<Byte>to BigInt
    *
    * @param value byte array
    * @return BigInt 
    * exception IndexOutOfBoundsException - Array cannot be empty.
    */
    public static func asn1Decode(value: Array<Byte>): BigInt {
        if (value.size <= 0) {
            throw IndexOutOfBoundsException("Array cannot be empty.")
        }
        var strBin: String = ""
        for (i in 0..value.size) {
            var byte: Byte = value[i]

            // Byte to binary string
            var byteStr: String = byte.format("B")
            var strLength: Int64 = byteStr.size

            // If the binary is not enough, fill in the high bit of the octet with 0
            for (k in 0..(8 - strLength)) {
                k
                byteStr = "0" + byteStr
            }
            strBin = strBin + byteStr
        }

        // Convert binary strings into character arrays
        var charArr1: Array<Char> = strBin.toRuneArray()
        var str1: String = charArr1[0].toString()

        var allNumber1: BigInt = BigInt(0)

        // Loop starting from the second position
        for (i in 1..charArr1.size) {
            var charStr: String = charArr1[i].toString()

            // Judging Negative Numbers to Negate
            if (str1=="1") {
                match (charStr) {
                    case "0" => charStr = "1"
                    case "1" => charStr = "0"
                    case _ => ()
                }
            }
            var intNumber: Int64 = Int64.parse(charStr)
            var intFor: BigInt = BigInt(intNumber)

            // Convert to int by number of digits
            for (k in 0..(charArr1.size - 1 - i)) {
                k
                intFor = intFor * 2
            }
            allNumber1 = allNumber1 + intFor
        }

        // Judging sign negative number plus one sign
        if (str1=="1") {
            allNumber1 = allNumber1 + 1
            allNumber1 = -allNumber1
        }
        return allNumber1
    }
}

