package asn1.encodingrules.ber

from std import io.InputStream
from std import io.IOException
import asn1.encodingrules.ASN1Decoder
import asn1.types.ASN1Tag
import asn1.types.ASN1Object

public open class BERDecoder <: ASN1Decoder {
    public override func readTag(inputStream: InputStream): ASN1Tag {
        // TODO
        throw Exception("Could not parse ASN.1 Tag Class (should be impossible)")
    }

    public override func readLength(inputStream: InputStream): Int64 {
        // TODO
        return inputStream.length
    }

    public override func readValue(length: Int64, inputStream: InputStream): Array<Byte> {
        // TODO
        try {
            var value: Array<Byte> = Array<Byte>()
            var count: Int64 = 0
            var read: Int64 = 0
            return value
        } catch (ioe: IOException) {
            throw IOException("Unable to read the value of the ASN.1 object")
        }
    }
}
