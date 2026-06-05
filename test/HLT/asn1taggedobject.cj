// 3rd_party_lib:asnone4cj/target/release/asn1

import std.io.*
import asn1.*
import std.collection.*

@Test
public class asn_Asn1TaggedObject {

    //public init(tag: ASN1Tag, object: ?ASN1Object, explicit: Bool) 

    @TestCase
    func asn_Asn1TaggedObject_01(): Unit {
        let tags = ASN1_BOOLEAN
        let sle = ASN1TaggedObject(tags, ASN1Boolean(false), false)
        var a = sle.isExplicit()
        @Assert(a,false)
    }

    @TestCase
    func asn_Asn1TaggedObject_02(): Unit {
        let tags = INTEGER
        let sle = ASN1TaggedObject(tags, ASN1Integer(10), false)
        var a = sle.isExplicit()
        @Assert(a,false)
    }

    @TestCase
    func asn_Asn1TaggedObject_03(): Unit {
        let tags = BIT_STRING
        let tagss = BIT_STRING
        let arr: Array<Bool> = [true, true, false, true, false, false].toArray()
        let sle = ASN1TaggedObject(tags, ASN1BitString(arr), true)
        @Assert(sle.isExplicit(),true)
        @Assert(sle.getValue().toString(),"ASN1Object[[true, true, false, true, false, false]]")
        @Assert(sle.getObject().toString(),"ASN1Object[[true, true, false, true, false, false]]")
        @Assert(sle.getObject(tagss).toString(),"ASN1Object[[true, true, false, true, false, false]]")
        @Assert(sle.toString(),"ASN1TaggedObject[ASN1Tag[UNIVERSAL,CONSTRUCTED,3],ASN1Object[[true, true, false, true, false, false]]]")
    }

    @TestCase
    func asn_Asn1TaggedObject_04(): Unit {
        let tags = BIT_STRING
        let sle = ASN1TaggedObject(tags, ASN1Null(), false)
        var a = sle.isExplicit()
        @Assert(a,false)
    }

    @TestCase
    func asn_Asn1TaggedObject_05(): Unit {
        let tags = OBJECT_IDENTIFIER
        let sle = ASN1TaggedObject(tags, ASN1ObjectIdentifier("1.3.4"), false)
        var sl = sle.isExplicit()
        @Assert(sl,false)
    }

    @TestCase
    func asn_Asn1TaggedObject_06(): Unit {
        let tags = SEQUENCE
        var arr = ArrayList<ASN1Object>([ASN1Boolean(true), ASN1Integer(1), ASN1Boolean(false), ASN1Integer(2)])
        var asn1sequence: ASN1Sequence = ASN1Sequence(arr)
        let sle = ASN1TaggedObject(tags, asn1sequence, true)
        @Assert(sle.isExplicit(),true)
    }

    @TestCase
    func asn_Asn1TaggedObject_07(): Unit {
        let tags = ENUMERATED
        let sle = ASN1TaggedObject(tags, ASN1Enumerated(20), false)
        var sl = sle.isExplicit()
        @Assert(sl,false)
    }

    //public init(tag: ASN1Tag, object: ?ASN1Object)

    @TestCase
    func asn_Asn1TaggedObject_08(): Unit {
        try {
            let tags = ASN1_BOOLEAN
            ASN1TaggedObject(tags, ASN1Boolean(false))
        } catch (e: Exception) {
            @Assert(e.toString(),"IllegalArgumentException: The ASN.1 tag does not support encoding")
        }
    }

    @TestCase
    func asn_Asn1TaggedObject_09(): Unit {
        try {
            let tags = INTEGER
            ASN1TaggedObject(tags, ASN1Integer(10))
        } catch (e: Exception) {
            @Assert(e.toString(),"IllegalArgumentException: The ASN.1 tag does not support encoding")
        }
    }

    @TestCase
    func asn_Asn1TaggedObject_10(): Unit {
        let tags = BIT_STRING
        let tagss = BIT_STRING
        let arr: Array<Bool> = [true, true, false, true, false, false].toArray()
        let sle = ASN1TaggedObject(tags, ASN1BitString(arr))
        @Assert(sle.isExplicit(),true)
        @Assert(sle.getValue().toString(),"ASN1Object[[true, true, false, true, false, false]]")
        @Assert(sle.getObject().toString(),"ASN1Object[[true, true, false, true, false, false]]")
        @Assert(sle.getObject(tagss).toString(),"ASN1Object[[true, true, false, true, false, false]]")
        @Assert(sle.toString(),"ASN1TaggedObject[ASN1Tag[UNIVERSAL,CONSTRUCTED,3],ASN1Object[[true, true, false, true, false, false]]]")
    }

    @TestCase
    func asn_Asn1TaggedObject_11(): Unit {
        try {
            let tags = ASN1_NULL_TAG
            ASN1TaggedObject(tags, ASN1Null())
        } catch (e: Exception) {
            @Assert(e.toString(),"IllegalArgumentException: The ASN.1 tag does not support encoding")
        }
    }

    @TestCase
    func asn_Asn1TaggedObject_12(): Unit {
        try {
            let tags = OBJECT_IDENTIFIER
            ASN1TaggedObject(tags, ASN1ObjectIdentifier("1.3.4"))
        } catch (e: Exception) {
            @Assert(e.toString(),"IllegalArgumentException: The ASN.1 tag does not support encoding")
        }
    }

    @TestCase
    func asn_Asn1TaggedObject_13(): Unit {
        let tags = SEQUENCE
        let tagss = SEQUENCE
        var arr = ArrayList<ASN1Object>([ASN1Boolean(true), ASN1Integer(1), ASN1Boolean(false), ASN1Integer(2)])
        var asn1sequence: ASN1Sequence = ASN1Sequence(arr)
        let sle = ASN1TaggedObject(tags, asn1sequence)
        println(sle.isExplicit())
        println(sle.getValue())
        println(sle.getObject())
        println(sle.getObject(tagss))
        println(sle.toString())
        @Assert(sle.isExplicit(),true)
        @Assert(sle.getValue().toString(),"ASN1Object[ASN1Tag[UNIVERSAL,CONSTRUCTED,16]]")
        @Assert(sle.getObject().toString(),"ASN1Object[ASN1Tag[UNIVERSAL,CONSTRUCTED,16]]")
        @Assert(sle.getObject(tagss).toString(),"ASN1Object[ASN1Tag[UNIVERSAL,CONSTRUCTED,16]]")
        @Assert(sle.toString(),"ASN1TaggedObject[ASN1Tag[UNIVERSAL,CONSTRUCTED,16],ASN1Object[ASN1Tag[UNIVERSAL,CONSTRUCTED,16]]]")
    }

    @TestCase
    func asn_Asn1TaggedObject_14(): Unit {
        try {
            let tags = ENUMERATED
            ASN1TaggedObject(tags, ASN1Enumerated(20))
        } catch (e: Exception) {
            @Assert(e.toString(),"IllegalArgumentException: The ASN.1 tag does not support encoding")
        }
    }

    //public init(tag: ASN1Tag, bytes: Array<Byte>, decoder: ASN1Decoder) 

    @TestCase
    func asn_Asn1TaggedObject_15(): Unit {
        try {
            let tags = ASN1_BOOLEAN
            let tagss = ASN1_BOOLEAN
            let decz: BERDecoder = BERDecoder()
            BooleanParser(decz)
            let Buf: Array<Byte> = [0x01, 0x08, 0x06, 0x06, 0x2B, 0x06, 0x01, 0x05, 0x05, 0x02]
            let sle = ASN1TaggedObject(tags, Buf, decz)
            println(sle.isExplicit())
            println(sle.getValue())
            println(sle.getObject())
            println(sle.getObject(tagss))
            println(sle.toString())
        } catch (e: Exception) {
            @Assert(e.toString(),"Exception: Cannot parse ASN.1 object from streamUnable to parse the explicit Tagged Object with %s, it might be implicit")
        }
    }

    @TestCase
    func asn_Asn1TaggedObject_16(): Unit {
        let tags = ASN1_BOOLEAN
        let decz: BERDecoder = BERDecoder()
        let Buf: Array<Byte> = [0x60, 0x08, 0x06, 0x06, 0x2B, 0x06, 0x01, 0x05, 0x05, 0x02]
        let sle = ASN1TaggedObject(tags, Buf, decz)
        println(sle.isExplicit())
        @Assert(sle.isExplicit(),true)
    }

    @TestCase
    func asn_Asn1TaggedObject_17(): Unit {
        let tags = SEQUENCE
        var arr = ArrayList<ASN1Object>([ASN1Enumerated(20)])
        var asn1sequence: ASN1Sequence = ASN1Sequence(arr)
        let set2 = ASN1TaggedObject(tags, asn1sequence)
        var iteratorSet2: Iterator<ASN1Object> = set2.iterator()
        while (true) {
            match (iteratorSet2.next()) {
                case Some(i) =>
                    println(i)
                    @Assert(i.toString(),"ASN1Object[ASN1Tag[UNIVERSAL,PRIMITIVE,10]]")
                case None => break
            }
        }
    }
}
