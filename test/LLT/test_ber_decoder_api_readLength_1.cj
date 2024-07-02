// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from std import io.*
from std import collection.*
from asn1 import asn1.*

main() {
    var array: Array<Byte> = [0x00, 0x02, 0x04, 0x06, 0x10, 0x01, 0x03, 0x05, 0x07, 0x11]
    var berDecoder: BERDecoder = BERDecoder()
    var inputStream: ASN1InputStream = ASN1InputStream(berDecoder, array)
    var buffer: Int64 = berDecoder.readLength(inputStream)
    if (buffer != 0) {
        return 1
    }

    var array_0: Array<Byte> = [0x7f, 0x02, 0x04, 0x06, 0x10, 0x01, 0x03, 0x05, 0x07, 0x11]
    var inputStream_0: ASN1InputStream = ASN1InputStream(berDecoder, array_0)
    var buffer_0: Int64 = berDecoder.readLength(inputStream_0)
    if (buffer_0 != 127) {
        return 1
    }

    var array1: Array<Byte> = [0x66, 0x02, 0x04, 0x06, 0x10, 0x01, 0x03, 0x05, 0x07, 0x11]
    var inputStream1: ASN1InputStream = ASN1InputStream(berDecoder, array1)
    var buffer1: Int64 = berDecoder.readLength(inputStream1)
    if (buffer1 != 102) {
        return 1
    }

    var array2: Array<Byte> = [0x81, 0x02, 0x04, 0x06, 0x10, 0x01, 0x03, 0x05, 0x07, 0x7f]
    var inputStream2: ASN1InputStream = ASN1InputStream(berDecoder, array2)
    var buffer2: Int64 = berDecoder.readLength(inputStream2)
    if (buffer2 != 2) {
        return 1
    }
    return 0
}
