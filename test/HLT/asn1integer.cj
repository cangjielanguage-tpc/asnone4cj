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
public class asn_Asn1OutputStream01{


    @TestCase
    func asn_Asn1Integer_01(): Unit {

         var value1:BigInt = BigInt(0)                          
         var asn1integer: ASN1Integer = ASN1Integer(value1)
         var ssss: BigInt= (asn1integer.getValue() as BigInt).getOrThrow()
         var intValue: String = ssss.toStringDec()
         @Assert(intValue,"0")  
    }



    @TestCase
    func asn_Asn1Integer_02(): Unit {

         var value1:BigInt = BigInt(184467440737)                          
         var asn1integer: ASN1Integer = ASN1Integer(value1)
         var ssss: BigInt= (asn1integer.getValue() as BigInt).getOrThrow()
         var intValue: String = ssss.toStringDec()
         @Assert(intValue,"184467440737") 
  
    }



    @TestCase
    func asn_Asn1Integer_03(): Unit {

          var value1:BigInt = BigInt(10)                          
         var asn1integer: ASN1Integer = ASN1Integer(value1)
         var ssss: BigInt= (asn1integer.getValue() as BigInt).getOrThrow()
         var intValue: String = ssss.toStringDec()
         @Assert(intValue,"10") 
    }


    @TestCase
    func asn_Asn1Integer_04(): Unit {

          var value1:BigInt = BigInt(9999)                          
         var asn1integer: ASN1Integer = ASN1Integer(value1)
         var ssss: BigInt= (asn1integer.getValue() as BigInt).getOrThrow()
         var intValue: String = ssss.toStringDec()
         @Assert(intValue,"9999") 
    }


    @TestCase
    func asn_Asn1Integer_05(): Unit {

         var value1:BigInt = BigInt(184467440737)                          
         var asn1integer: ASN1Integer = ASN1Integer(value1)
         var ssss: BigInt= (asn1integer.getValue() as BigInt).getOrThrow()
         var intValue: String = ssss.toStringDec()
         @Assert(intValue,"184467440737") 
    }


    @TestCase
    func asn_Asn1Integer_06(): Unit {

    
          var value1:BigInt = BigInt(-9223372036854775807)                          
          var asn1integer: ASN1Integer = ASN1Integer(value1)
          var ssss: BigInt= (asn1integer.getValue() as BigInt).getOrThrow()
          var intValue: String = ssss.toStringDec()
          @Assert(intValue,"-9223372036854775807") 
    }




    @TestCase
    func asn_Asn1Integer_07(): Unit {

    
          var value1:BigInt = BigInt(-2)                          
          var asn1integer: ASN1Integer = ASN1Integer(value1)
          var ssss: BigInt= (asn1integer.getValue() as BigInt).getOrThrow()
          var intValue: String = ssss.toStringDec()
          @Assert(intValue,"-2") 
  
    }
}

