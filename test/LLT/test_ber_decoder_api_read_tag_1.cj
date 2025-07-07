// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
import std.io.*
import std.collection.*
import asn1.*

main() {
    var array: Array<Byte> = [0xc0]
    var berDecoder: BERDecoder = BERDecoder()
    var inputStream: ASN1InputStream = ASN1InputStream(berDecoder, array)
    var buffer: ASN1Tag = berDecoder.readTag(inputStream)
    if (buffer.getTag() != 0) {
        return 1
    }

    var array1: Array<Byte> = [0x80]
    var berDecoder1: BERDecoder = BERDecoder()
    var inputStream1: ASN1InputStream = ASN1InputStream(berDecoder1, array1)
    var buffer1: ASN1Tag = berDecoder1.readTag(inputStream1)
    if (buffer1.getTag() != 0) {
        return 2
    }

    var array2: Array<Byte> = [0x40]
    var berDecoder2: BERDecoder = BERDecoder()
    var inputStream2: ASN1InputStream = ASN1InputStream(berDecoder2, array2)
    var buffer2: ASN1Tag = berDecoder2.readTag(inputStream2)
    if (buffer2.getTag() != 0) {
        return 3
    }
    
    return 0
}
