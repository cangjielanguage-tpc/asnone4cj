// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
from std import io.*
from std import collection.*
from asn1 import asn1.*
from asn1 import asn1.types.*
from asn1 import asn1.encodingrules.*
from asn1 import asn1.encodingrules.der.*

main() {
    var buffer: Array<Byte> = [0x00, 0x02, 0x04, 0x06, 0x10, 0x01, 0x03, 0x05, 0x07, 0x11]
    var berDecoder: BERDecoder = BERDecoder()
    var inputStream: ASN1InputStream = ASN1InputStream(berDecoder, buffer)
    var buffer_1: Array<Byte> = berDecoder.readValue(0, inputStream)
    if (buffer_1.size != 0) {
        return 1
    }

    var buffer0: Array<Byte> = berDecoder.readValue(5, inputStream)
    if (buffer0.size != 5) {
        return 1
    }
    if (buffer0[0] != 0x00 || buffer0[1] != 0x02 || buffer0[2] != 0x04 || buffer0[3] != 0x06 || buffer0[4] != 0x10) {
        return 1
    }

    var buffer1: Array<Byte> = berDecoder.readValue(10, inputStream)
    if (buffer1.size != 10) {
        return 1
    }

    var buffer2: Array<Byte> = berDecoder.readValue(30, inputStream)
    if (buffer2.size != 30) {
        return 1
    }

    var buffer3: Array<Byte> = berDecoder.readValue(50, inputStream)
    if (buffer3.size != 50) {
        return 1
    }
    return 0
}
