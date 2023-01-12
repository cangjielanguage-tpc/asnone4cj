package asn1.encodingrules.der

import asn1.encodingrules.ber.BERDecoder
import asn1.types.ASN1Object

public class DERDecoder<T> <: BERDecoder<T> where T <: ASN1Object<T> {}
