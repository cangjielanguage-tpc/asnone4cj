// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from asn1 import asn1.util.BigInt
from encoding import hex.*
from std import overflow.*
from std import format.*
from std import collection.*
from asn1 import asn1.util.*

main(): Int64 {
    // [0xfb, 0x2e][251, 46]
    var valueArr: Array<Byte> = [0xfb, 0x2e]
    var value: BigInt = BigInt(-1234)
    var valueByteArr: Array<Byte> = EncodingUtils.asn1Encoded(value)
    println(valueByteArr)
    if (valueByteArr != valueArr) {
        return 1
    }

    // [0x00, 0xff][0, 255]
    var valueArr1: Array<Byte> = [0x00, 0xff]
    var value1: BigInt = BigInt(255)
    var valueByteArr1: Array<Byte> = EncodingUtils.asn1Encoded(value1)
    println(valueByteArr1)
    if (valueByteArr1 != valueArr1) {
        return 1
    }

    // [0xfe][254]
    var value01Arr: Array<Byte> = [0xfe]
    var value01: BigInt = BigInt(-2)
    var valueByteArr01: Array<Byte> = EncodingUtils.asn1Encoded(value01)
    println(valueByteArr01)
    if (valueByteArr01 != value01Arr) {
        return 1
    }

    // [0x00, 0xfe][0, 254]
    var value001Arr: Array<Byte> = [0x00, 0xfe]
    var value001: BigInt = BigInt(254)
    var valueByteArr001: Array<Byte> = EncodingUtils.asn1Encoded(value001)
    println(valueByteArr001)
    if (valueByteArr001 != value001Arr) {
        return 1
    }

    // [0xff][255]
    var value0001Arr: Array<Byte> = [0xff]
    var value0001: BigInt = BigInt(-1)
    var valueByteArr0001: Array<Byte> = EncodingUtils.asn1Encoded(value0001)
    println(valueByteArr0001)
    if (valueByteArr0001 != value0001Arr) {
        return 1
    }

    // [0xfe, 0xfe][254, 254]
    var value00001Arr: Array<Byte> = [0xfe, 0xfe]
    var value00001: BigInt = BigInt(-258)
    var valueByteArr00001: Array<Byte> = EncodingUtils.asn1Encoded(value00001)
    println(valueByteArr00001)
    if (valueByteArr00001 != value00001Arr) {
        return 1
    }

    // [0x01, 0x00][1, 0]
    var value2Arr: Array<Byte> = [0x01, 0x00]
    var value2: BigInt = BigInt(256)
    var valueByteArr2: Array<Byte> = EncodingUtils.asn1Encoded(value2)
    println(valueByteArr2)
    if (valueByteArr2 != value2Arr) {
        return 1
    }

    // [0xee, 0x72][238, 114]
    var value3Arr: Array<Byte> = [0xee, 0x72]
    var value3: BigInt = BigInt(-4494)
    var valueByteArr3: Array<Byte> = EncodingUtils.asn1Encoded(value3)
    println(valueByteArr3)
    if (valueByteArr3 != value3Arr) {
        return 1
    }

    // [0x01, 0x01, 0x01, 0x72][1, 1, 1, 114]
    var value4Arr: Array<Byte> = [0x01, 0x01, 0x01, 0x72]
    var value4: BigInt = BigInt(16843122)
    var valueByteArr4: Array<Byte> = EncodingUtils.asn1Encoded(value4)
    println(valueByteArr4)
    if (valueByteArr4 != value4Arr) {
        return 1
    }    

    // [0xfe, 0xfe, 0x11, 0x22][254, 254, 17, 34]
    var value5Arr: Array<Byte> = [0xfe, 0xfe, 0x11, 0x22]
    var value5: BigInt = BigInt(-16903902);
    var valueByteArr5: Array<Byte> = EncodingUtils.asn1Encoded(value5)
    println(valueByteArr5)
    if (valueByteArr5 != value5Arr) {
        return 1
    }

    return 0
}
