// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import asn1.*
import std.io.*
import std.collection.*

main() {

    let dec: DEREncoder = DEREncoder()
    let tags = INTEGER
    let decz: BERDecoder = BERDecoder()

    let bitss = BooleanParser(decz)
    let Buf: Array<Byte> = [1]
    let ssc = bitss.parse(tags,Buf)

    let decodetd: DEREncoder = DEREncoder()
    let wrapped: ByteArrayStream = ByteArrayStream()
    let asn9 = ASN1OutputStream(decodetd,wrapped)

    let tags1 = SEQUENCE
    let src = tags1.newParser(decz)
    let src1 = tags1.newSerializer(dec)
    try {
        src.parse(tags, Array<Byte>())
    }catch(e: Exception) {
        println("pass")
    }
    try {
        src1.serializedLength(ssc)
    }catch(e: Exception) {
        println("pass")
    }
    try {
        src1.serialize(ssc,asn9)
    }catch(e: Exception) {
        println("pass")
    }
    let resu = tags1.getTag()
    println(resu)
    let tags2 = SET
    let rel = tags2.newParser(decz)
    let rel1 = tags2.newSerializer(dec)
    try {
        rel.parse(tags, Array<Byte>())
    }catch(e: Exception) {
        println("pass")
    }
    try {
        rel1.serializedLength(ssc)
    }catch(e: Exception) {
        println("pass")
    }
    try {
        rel1.serialize(ssc,asn9)
    }catch(e: Exception) {
        println("pass")
    }
    if (resu != 16) {
        return 1
    }
    return 0
}
