// 3rd_party_lib:asn1-cj/build/asn1
from asn1 import asn1.EnumeratedSerializer
from asn1 import asn1.BERDecoder
from asn1 import asn1.ASN1Tag
from asn1 import asn1.ASN1Null
from asn1 import asn1.ASN1Integer
from asn1 import asn1.NullSerializer
from asn1 import asn1.IntegerSerializer
from asn1 import asn1.BooleanParser
from asn1 import asn1.ASN1OutputStream
from asn1 import asn1.encodingrules.der.DEREncoder
from asn1 import asn1.ASN1TaggedObject
from std import io.*
from asn1 import asn1.ASN1ParseException
from asn1 import asn1.ASN1Object
from asn1 import asn1.ASN1Sequence
from asn1 import asn1.BitStringParser
from asn1 import asn1.*
from asn1 import asn1.types.*
from asn1 import asn1.util.*
from asn1 import asn1.encodingrules.*
from asn1 import asn1.encodingrules.der.*
from std import collection.*
@Test
public class asn_SeqUencer{





    @TestCase
    func asn_ASN1Null_02(): Unit {
        
         var arr = ArrayList<ASN1Object>([ASN1Boolean(true), ASN1Integer(1),ASN1Null(),ASN1Integer(2),ASN1ObjectIdentifier("1.3.4"),
         ASN1Enumerated(20),ASN1Boolean(true), ASN1Integer(1),ASN1Null(),ASN1Integer(2),ASN1ObjectIdentifier("1.3.4"),ASN1Enumerated(20)])
         var asn1sequencer:ASN1Sequence=ASN1Sequence(arr)
         println(asn1sequencer)
    }


    @TestCase
    func asn_ASN1Null_03(): Unit {
        
         var arr = ArrayList<ASN1Object>([ASN1Boolean(true)])
         var asn1sequencer:ASN1Sequence=ASN1Sequence(arr)
         println(asn1sequencer)
    }



    @TestCase
    func asn_ASN1Null_04(): Unit {
        
         var ar = ArrayList<ASN1Object>([ASN1Boolean(true), ASN1Integer(1), ASN1Boolean(false), ASN1Integer(2)])
         var arr = ArrayList<ASN1Object>([ASN1Boolean(true),ASN1Sequence(ar)])
         var asn1sequencer:ASN1Sequence=ASN1Sequence(arr)
         println(asn1sequencer)
    }



     @TestCase
    func asn_ASN1Null_05(): Unit {
        
         var ar = ArrayList<ASN1Object>([ASN1Boolean(true), ASN1Integer(1), ASN1Boolean(false), ASN1Integer(2)])
         var arr = ArrayList<ASN1Object>([ASN1Boolean(true),ASN1Sequence(ar),ASN1Boolean(true), ASN1Integer(1),ASN1Null(),ASN1Integer(2),ASN1ObjectIdentifier("1.3.4")])
         var asn1sequencer:ASN1Sequence=ASN1Sequence(arr)
         println(asn1sequencer)
    }



     @TestCase
    func asn_ASN1Null_06(): Unit {
        
         var arr = ArrayList<ASN1Object>()
         var asn1sequencer:ASN1Sequence=ASN1Sequence(arr)
         println(asn1sequencer)
    }


     @TestCase
    func asn_ASN1Null_07(): Unit {
        
         var arr = ArrayList<ASN1Object>([ASN1Null()])
         var asn1sequencer:ASN1Sequence=ASN1Sequence(arr)
         println(asn1sequencer)
    }


     @TestCase
    func asn_ASN1Null_08(): Unit {
        
         var arr = ArrayList<ASN1Object>([ASN1ObjectIdentifier("1.3.4")])
         var asn1sequencer:ASN1Sequence=ASN1Sequence(arr)
         println(asn1sequencer)
    }


     @TestCase
    func asn_ASN1Null_09(): Unit {
        
         var arr = ArrayList<ASN1Object>([ASN1Enumerated(20)])
         var asn1sequencer:ASN1Sequence=ASN1Sequence(arr)
         println(asn1sequencer)
    }


     @TestCase
    func asn_ASN1Null_10(): Unit {
        
         var arr = ArrayList<ASN1Object>([ASN1Boolean(true),ASN1Enumerated(20)])
         var asn1sequencer:ASN1Sequence=ASN1Sequence(arr)
         println(asn1sequencer)
    }


     @TestCase
    func asn_ASN1Null_11(): Unit {
        
         var arr = ArrayList<ASN1Object>([ASN1Boolean(true),ASN1ObjectIdentifier("1.3.4")])
         var asn1sequencer:ASN1Sequence=ASN1Sequence(arr)
         println(asn1sequencer)
    }


     @TestCase
    func asn_ASN1Null_12(): Unit {
        
         var arr = ArrayList<ASN1Object>([ASN1Boolean(true),ASN1Enumerated(20),ASN1ObjectIdentifier("1.3.4")])
         var asn1sequencer:ASN1Sequence=ASN1Sequence(arr)
         println(asn1sequencer)
    }


     @TestCase
    func asn_ASN1Null_13(): Unit {
        
         var arr = ArrayList<ASN1Object>([ASN1Enumerated(20),ASN1ObjectIdentifier("1.3.4")])
         var asn1sequencer:ASN1Sequence=ASN1Sequence(arr)
         println(asn1sequencer)
    }


     @TestCase
    func asn_Asn1OutputStream_16(): Unit {
        var arr = ArrayList<ASN1Object>([ASN1Enumerated(20)])
        var set2:ASN1Sequence=ASN1Sequence(arr)
        var iteratorSet2: Iterator<ASN1Object> = set2.iterator()
        while (true) {
        match (iteratorSet2.next()) {
            case Some(i) => println(i)
            @Assert(i.toString(),"ASN1Object[ASN1Tag[UNIVERSAL,PRIMITIVE,10]]")
            case None => break
        }
    }
    }

}
