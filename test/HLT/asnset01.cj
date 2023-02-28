// 3rd_party_lib:asn-one/build/asn1
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
public class asn_Asn1OutputStream01{    
/*
  
    @TestCase
    func asn_Asn1OutputStream_01(): Unit {

         var objects: HashSet<ASN1Object> = HashSet<ASN1Object>([ASN1Boolean(true), ASN1Integer(1), ASN1Boolean(false), ASN1Integer(2)])
         var asn1set:ASN1Set=ASN1Set(objects)
         var ssss:HashSet<ASN1Object> = (asn1set.getValue() as HashSet<ASN1Object>).getOrThrow()
         println(ssss)
         @Assert(ssss.toString(),"[ASN1Object[ASN1Tag[UNIVERSAL,PRIMITIVE,1]], ASN1Object[ASN1Tag[UNIVERSAL,PRIMITIVE,2]], ASN1Object[ASN1Tag[UNIVERSAL,PRIMITIVE,1]], ASN1Object[ASN1Tag[UNIVERSAL,PRIMITIVE,2]]]")
    }


    @TestCase
    func asn_Asn1OutputStream_02(): Unit {

         var objects: HashSet<ASN1Object> = HashSet<ASN1Object>([ASN1Boolean(true), ASN1Integer(1),ASN1Null(),ASN1Integer(2),ASN1ObjectIdentifier("1.3.4"),ASN1Enumerated(20)])
         var asn1set:ASN1Set=ASN1Set(objects)
         var ssss:HashSet<ASN1Object> = (asn1set.getValue() as HashSet<ASN1Object>).getOrThrow()
         @Assert(ssss.toString(),"[ASN1Object[ASN1Tag[UNIVERSAL,PRIMITIVE,1]], ASN1Object[ASN1Tag[UNIVERSAL,PRIMITIVE,2]], ASN1Object[ASN1Tag[UNIVERSAL,PRIMITIVE,5]], ASN1Object[ASN1Tag[UNIVERSAL,PRIMITIVE,2]], ASN1Object[ASN1Tag[UNIVERSAL,PRIMITIVE,6]], ASN1Object[ASN1Tag[UNIVERSAL,PRIMITIVE,10]]]")
    }

 
     @TestCase
    func asn_Asn1OutputStream_03(): Unit {

         var objects: HashSet<ASN1Object> = HashSet<ASN1Object>([ASN1Boolean(true), ASN1Integer(1),ASN1Null(),ASN1Integer(2),ASN1ObjectIdentifier("1.3.4")])
         var asn1set:ASN1Set=ASN1Set(objects)
         var ssss:HashSet<ASN1Object> = (asn1set.getValue() as HashSet<ASN1Object>).getOrThrow()
         @Assert(ssss.toString(),"[ASN1Object[ASN1Tag[UNIVERSAL,PRIMITIVE,1]], ASN1Object[ASN1Tag[UNIVERSAL,PRIMITIVE,2]], ASN1Object[ASN1Tag[UNIVERSAL,PRIMITIVE,5]], ASN1Object[ASN1Tag[UNIVERSAL,PRIMITIVE,2]], ASN1Object[ASN1Tag[UNIVERSAL,PRIMITIVE,6]]]")
    }

 
     @TestCase
    func asn_Asn1OutputStream_04(): Unit {

         var objects: HashSet<ASN1Object> = HashSet<ASN1Object>([ASN1Boolean(true)])
         var asn1set:ASN1Set=ASN1Set(objects)
         var ssss:HashSet<ASN1Object> = (asn1set.getValue() as HashSet<ASN1Object>).getOrThrow()
         @Assert(ssss.toString(),"[ASN1Object[ASN1Tag[UNIVERSAL,PRIMITIVE,1]]]")
    }

 
     @TestCase
    func asn_Asn1OutputStream_05(): Unit {

         var objects: HashSet<ASN1Object> = HashSet<ASN1Object>([ASN1Boolean(true), ASN1Integer(1), ASN1Boolean(false), ASN1Integer(2)])
         var asn1set:ASN1Set=ASN1Set(objects)
         var ssss:HashSet<ASN1Object> = (asn1set.getValue() as HashSet<ASN1Object>).getOrThrow()
         @Assert(ssss.toString(),"[ASN1Object[ASN1Tag[UNIVERSAL,PRIMITIVE,1]], ASN1Object[ASN1Tag[UNIVERSAL,PRIMITIVE,2]], ASN1Object[ASN1Tag[UNIVERSAL,PRIMITIVE,1]], ASN1Object[ASN1Tag[UNIVERSAL,PRIMITIVE,2]]]")
    }

 
     @TestCase
    func asn_Asn1OutputStream_06(): Unit {

         var objects: HashSet<ASN1Object> = HashSet<ASN1Object>([ASN1Null()])
         var asn1set:ASN1Set=ASN1Set(objects)
         var ssss:HashSet<ASN1Object> = (asn1set.getValue() as HashSet<ASN1Object>).getOrThrow()
         @Assert(ssss.toString(),"[ASN1Object[ASN1Tag[UNIVERSAL,PRIMITIVE,5]]]")
    }

  
     @TestCase
    func asn_Asn1OutputStream_07(): Unit {

         var objects: HashSet<ASN1Object> = HashSet<ASN1Object>([ASN1ObjectIdentifier("1.3.4")])
         var asn1set:ASN1Set=ASN1Set(objects)
         var ssss:HashSet<ASN1Object> = (asn1set.getValue() as HashSet<ASN1Object>).getOrThrow()
         @Assert(ssss.toString(),"[ASN1Object[ASN1Tag[UNIVERSAL,PRIMITIVE,6]]]")
    }

  
     @TestCase
    func asn_Asn1OutputStream_08(): Unit {

         var objects: HashSet<ASN1Object> = HashSet<ASN1Object>([ASN1Enumerated(20)])
         var asn1set:ASN1Set=ASN1Set(objects)
         var ssss:HashSet<ASN1Object> = (asn1set.getValue() as HashSet<ASN1Object>).getOrThrow()
         @Assert(ssss.toString(),"[ASN1Object[ASN1Tag[UNIVERSAL,PRIMITIVE,10]]]")
    }

    
     @TestCase
    func asn_Asn1OutputStream_09(): Unit {

         var objects: HashSet<ASN1Object> = HashSet<ASN1Object>([ASN1Boolean(true),ASN1Enumerated(20)])
         var asn1set:ASN1Set=ASN1Set(objects)
         var ssss:HashSet<ASN1Object> = (asn1set.getValue() as HashSet<ASN1Object>).getOrThrow()
         @Assert(ssss.toString(),"[ASN1Object[ASN1Tag[UNIVERSAL,PRIMITIVE,1]], ASN1Object[ASN1Tag[UNIVERSAL,PRIMITIVE,10]]]")
    }


     @TestCase
    func asn_Asn1OutputStream_10(): Unit {

         var objects: HashSet<ASN1Object> = HashSet<ASN1Object>([ASN1Boolean(true),ASN1ObjectIdentifier("1.3.4")])
         var asn1set:ASN1Set=ASN1Set(objects)
         var ssss:HashSet<ASN1Object> = (asn1set.getValue() as HashSet<ASN1Object>).getOrThrow()
         @Assert(ssss.toString(),"[ASN1Object[ASN1Tag[UNIVERSAL,PRIMITIVE,1]], ASN1Object[ASN1Tag[UNIVERSAL,PRIMITIVE,6]]]")
    }


     @TestCase
    func asn_Asn1OutputStream_11(): Unit {

         var objects: HashSet<ASN1Object> = HashSet<ASN1Object>([ASN1Boolean(true),ASN1Enumerated(20),ASN1ObjectIdentifier("1.3.4")])
         var asn1set:ASN1Set=ASN1Set(objects)
         var ssss:HashSet<ASN1Object> = (asn1set.getValue() as HashSet<ASN1Object>).getOrThrow()
         @Assert(ssss.toString(),"[ASN1Object[ASN1Tag[UNIVERSAL,PRIMITIVE,1]], ASN1Object[ASN1Tag[UNIVERSAL,PRIMITIVE,10]], ASN1Object[ASN1Tag[UNIVERSAL,PRIMITIVE,6]]]")
    }



     @TestCase
    func asn_Asn1OutputStream_12(): Unit {

         var objects: HashSet<ASN1Object> = HashSet<ASN1Object>([ASN1Boolean(true), ASN1Integer(1), ASN1Boolean(false), ASN1Integer(2)])
         var asn1set:ASN1Set=ASN1Set(objects)
         var ssss:HashSet<ASN1Object> = (asn1set.getValue() as HashSet<ASN1Object>).getOrThrow()
         @Assert(ssss.toString(),"[ASN1Object[ASN1Tag[UNIVERSAL,PRIMITIVE,1]], ASN1Object[ASN1Tag[UNIVERSAL,PRIMITIVE,2]], ASN1Object[ASN1Tag[UNIVERSAL,PRIMITIVE,1]], ASN1Object[ASN1Tag[UNIVERSAL,PRIMITIVE,2]]]")
    }



     @TestCase
    func asn_Asn1OutputStream_13(): Unit {

         var objects: HashSet<ASN1Object> = HashSet<ASN1Object>([ASN1Enumerated(20),ASN1ObjectIdentifier("1.3.4")])
         var asn1set:ASN1Set=ASN1Set(objects)
         var ssss:HashSet<ASN1Object> = (asn1set.getValue() as HashSet<ASN1Object>).getOrThrow()
         @Assert(ssss.toString(),"[ASN1Object[ASN1Tag[UNIVERSAL,PRIMITIVE,10]], ASN1Object[ASN1Tag[UNIVERSAL,PRIMITIVE,6]]]")
    }

 
    @TestCase
    func asn_Asn1OutputStream_14(): Unit {

         var objects: HashSet<ASN1Object> = HashSet<ASN1Object>()
         var asn1set:ASN1Set=ASN1Set(objects)
         var ssss:HashSet<ASN1Object> = (asn1set.getValue() as HashSet<ASN1Object>).getOrThrow()
         @Assert(ssss.toString(),"[]")
    }



    @TestCase
    func asn_Asn1OutputStream_15(): Unit {

         var arr = ArrayList<ASN1Object>([ASN1Boolean(true), ASN1Integer(1), ASN1Boolean(false), ASN1Integer(2)])
         var asn1sequence:ASN1Sequence=ASN1Sequence(arr)	
         var objects: HashSet<ASN1Object> = HashSet<ASN1Object>([asn1sequence])
         var asn1set:ASN1Set=ASN1Set(objects)
         var ssss:HashSet<ASN1Object> = (asn1set.getValue() as HashSet<ASN1Object>).getOrThrow()
         @Assert(ssss.toString(),"[ASN1Object[ASN1Tag[UNIVERSAL,CONSTRUCTED,16]]]")
    }

*/
    @TestCase
    func asn_Asn1OutputStream_16(): Unit {
    var objects2: HashSet<ASN1Object> = HashSet<ASN1Object>([ASN1Boolean(true)])
    var set2: ASN1Set = ASN1Set(objects2)
    var iteratorSet2: Iterator<ASN1Object> = set2.iterator()
    while (true) {
        match (iteratorSet2.next()) {
            case Some(i) => println(i)
            @Assert(i.toString(),"ASN1Object[ASN1Tag[UNIVERSAL,PRIMITIVE,1]]")
            case None => break
        }
    }
    }
           
}