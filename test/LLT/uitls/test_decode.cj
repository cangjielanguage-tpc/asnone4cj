// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from numeric import bigint.*
from encoding import hex.*
from std import overflow.*
from std import format.*
from std import collection.*
from asn1 import asn1.util.*

main(): Int64 {
    // -1234
    var value: Array<Byte> = [0xfb, 0x2e]
    var bigIntValue: BigInt = DecoderUtils.asn1Decode(value)
    println(bigIntValue)
    if (!bigIntValue.toStringDec().equals("-1234")) {
        return 1
    }

    // 255
    var value1: Array<Byte> = [0x00, 0xff]
    var bigIntValue1: BigInt = DecoderUtils.asn1Decode(value1)
    println(bigIntValue1)
    if (!bigIntValue1.toStringDec().equals("255")) {
        return 1
    }

    // -2
    var value01: Array<Byte> = [0xfe]
    var bigIntValue01: BigInt = DecoderUtils.asn1Decode(value01)
    println(bigIntValue01)
    if (!bigIntValue01.toStringDec().equals("-2")) {
        return 1
    }

    // 254
    var value001: Array<Byte> = [0x00, 0xfe]
    var bigIntValue001: BigInt = DecoderUtils.asn1Decode(value001)
    println(bigIntValue001)
    if (!bigIntValue001.toStringDec().equals("254")) {
        return 1
    }

    // -1
    var value0001: Array<Byte> = [0xff]
    var bigIntValue0001: BigInt = DecoderUtils.asn1Decode(value0001)
    println(bigIntValue0001)
    if (!bigIntValue0001.toStringDec().equals("-1")) {
        return 1
    }

    // -258
    var value00001: Array<Byte> = [0xfe, 0xfe]
    var bigIntValue00001: BigInt = DecoderUtils.asn1Decode(value00001)
    println(bigIntValue00001)
    if (!bigIntValue00001.toStringDec().equals("-258")) {
        return 1
    }

    // 256
    var value2: Array<Byte> = [0x01, 0x00]
    var bigIntValue2: BigInt = DecoderUtils.asn1Decode(value2)
    println(bigIntValue2)
    if (!bigIntValue2.toStringDec().equals("256")) {
        return 1
    }

    // -4494
    var value3: Array<Byte> = [0xee, 0x72]
    var bigIntValue3: BigInt = DecoderUtils.asn1Decode(value3)
    println(bigIntValue3)
    if (!bigIntValue3.toStringDec().equals("-4494")) {
        return 1
    }

    // 16843122
    var value4: Array<Byte> = [0x01, 0x01, 0x01, 0x72]
    var bigIntValue4: BigInt = DecoderUtils.asn1Decode(value4)
    println(bigIntValue4)
    if (!bigIntValue4.toStringDec().equals("16843122")) {
        return 1
    }

    // -16903902
    var value5: Array<Byte> = [0xfe, 0xfe, 0x11, 0x22]
    var bigIntValue5: BigInt = DecoderUtils.asn1Decode(value5)
    println(bigIntValue5)
    if (!bigIntValue5.toStringDec().equals("-16903902")) {
        return 1
    }

    return 0
}
