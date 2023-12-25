package asn1.util

/*
* Encoding
* Step 1: Convert the data into binary strings
* Step 2: Distinguish the positive and negative values of incoming data
* Step 3: Perform a complement operation on negative numbers and convert them into an Array<Byte>array
* Step 4: Convert positive numbers to Array<Byte>arrays
*/
public class EncodingUtils {
    /*
    * Convert BigInt to Array<Byte>
    *
    * @param value BigInt
    * @return Byte array
    */
    public static func asn1Encoded(value: BigInt): Array<Byte> {
        // Convert BigInt to binary string
        var valueBinStr: String = value.toStringBin()

        // String to String Array
        var charBinArr: Array<Char> = valueBinStr.toRuneArray()
        var strBin: String = charBinArr[0].toString()
        if (strBin=="-") {
            return minusEncoding(valueBinStr, strBin, charBinArr)
        } else {
            return positiveEncoding(valueBinStr, strBin)
        }
    }

    private static func minusBinStrEncoding(valueBinStr: String, strBin: String, charBinArr: Array<Char>): BigInt {
        (valueBinStr, strBin, charBinArr)
        var allNumber: BigInt = BigInt(0)

        // How many bits are missing from each 8-bit byte of raw data
        var addLengthBinStr: Int64 = 8 - (valueBinStr.size - 1) % 8
        var stringBuilder: StringBuilder = StringBuilder("-")
        for (_ in 0..addLengthBinStr) {
            stringBuilder.append("0")
        }
        var strArr:String = String(valueBinStr.toRuneArray().slice(1,valueBinStr.size - 1))
        stringBuilder.append(strArr)
        var str = stringBuilder.toString()
        var charBinArrNew: Array<Char> = str.toRuneArray()
        for (i in 1..charBinArrNew.size) {
            var charBinStr: String = charBinArrNew[i].toString()

            // Inverse code
            match (charBinStr) {
                case "0" => charBinStr = "1"
                case "1" => charBinStr = "0"
                case _ => ()
            }
            var intNumber: Int64 = Int64.parse(charBinStr)
            var intFor: BigInt = BigInt(intNumber)

            // Convert to int by number of digits
            for (k in 0..(charBinArrNew.size - 1 - i)) {
                k
                intFor = intFor * 2
            }
            allNumber = allNumber + intFor
        }
        allNumber = allNumber + 1
        return allNumber
    }

    private static func minusEncoding(valueBinStr: String, strBin: String, charBinArr: Array<Char>): Array<Byte> {
        var allNumber: BigInt = minusBinStrEncoding(valueBinStr, strBin, charBinArr)

        // Convert BigInt to binary string
        var valueBinStr1: String = allNumber.toStringBin()

        // Recalculate data
        // String to String Array
        var charBinArr1: Array<Char> = valueBinStr1.toRuneArray()
        var allNumber1: BigInt = BigInt(0)

        for (i in 0..charBinArr1.size) {
            var charBinStr: String = charBinArr1[i].toString()
            var intNumber: Int64 = Int64.parse(charBinStr)
            var intFor: BigInt = BigInt(intNumber)

            // Convert to int by number of digits
            for (k in 0..(charBinArr1.size - 1 - i)) {
                k
                intFor = intFor * 2
            }
            allNumber1 = allNumber1 + intFor
        }

        // Convert BigIint to a hexadecimal string
        var stringValue: String = allNumber1.toStringHex()
        if (stringValue.size.throwingMod(2) != 0) {
            stringValue = "0" + stringValue
        }
        var arrayByte: Array<Byte> = fromHexString(stringValue).getOrThrow()
        if (arrayByte.size >= 2) {
            if (arrayByte[0] == 255 && arrayByte[1] > 127) {
                // The first item is 255, and when the second item is greater than 127, the supplementary 255 needs to be removed.
                var list: Array<Byte> = Array<Byte>(arrayByte.size - 1, item: 0)
                arrayByte.copyTo(list, 1, 0, list.size)
                return list
            }
        }
        return arrayByte
    }

    private static func positiveEncoding(valueBinStr: String, strBin: String): Array<Byte> {
        var addLengthBinStr: Int64 = valueBinStr.size % 8
        var stringBuilder: StringBuilder = StringBuilder()
        if (addLengthBinStr != 0) {
            for (_ in 0..(8 - addLengthBinStr)) {
                stringBuilder.append("0")
            }
        } else {
            if (strBin=="1") {
                stringBuilder.append("00000000")
            }
        }
        stringBuilder.append(valueBinStr)
        var valueBinStrNew: String = stringBuilder.toString()
        var arrStringByte: Array<String> = Array<String>(valueBinStrNew.size / 8, item: "")
        
        // Convert binary octets into a String list
        for (i in 0..arrStringByte.size) {
            arrStringByte[i] = valueBinStrNew[(i * 8)..(i * 8)+8]
        }
        var arrByte: Array<Byte> = Array<Byte>(arrStringByte.size, item: 0)
        for (i in 0..arrStringByte.size) {
            var valueBinStr1: String = arrStringByte[i]

            // Recalculate data
            // String to String Array
            var charBinArr1: Array<Char> = valueBinStr1.toRuneArray()
            var allNumber1: BigInt = BigInt(0)
            for (j in 0..charBinArr1.size) {
                var charBinStr: String = charBinArr1[j].toString()
                var intNumber: Int64 = Int64.parse(charBinStr)
                var intFor: BigInt = BigInt(intNumber)

                // Convert to int by number of digits
                for (k in 0..(charBinArr1.size - 1 - j)) {
                    k
                    intFor = intFor * 2
                }
                allNumber1 = allNumber1 + intFor
            }

            // Convert BigIint to a decimal string
            var stringValue: String = allNumber1.toStringDec()
            var intValue: Int64 = Int64.parse(stringValue)
            arrByte[i] = UInt8(intValue)
        }
        return arrByte
    }
}