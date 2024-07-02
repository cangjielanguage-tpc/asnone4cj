// 3rd_party_lib:asn1-cj/build/asn1
from asn1 import asn1.EnumeratedSerializer
from asn1 import asn1.BERDecoder
from asn1 import asn1.ASN1Tag
from asn1 import asn1.BIT_STRING
from asn1 import asn1.ASN1Null
from asn1 import asn1.ASN1Integer
from asn1 import asn1.NullSerializer
from asn1 import asn1.IntegerSerializer
from asn1 import asn1.BooleanParser
from asn1 import asn1.ASN1OutputStream
from asn1 import asn1.ASN1TaggedObject
from std import io.*
from asn1 import asn1.ASN1ParseException
from asn1 import asn1.ASN1Object
from asn1 import asn1.ASN1Sequence
from asn1 import asn1.BitStringParser
from asn1 import asn1.*
from std import collection.*
@Test
public class asn_Asn1Tag01{


    @TestCase     
    func asn_Asn1Tag01(): Unit {

        var tags = BIT_STRING
        let a:ASN1Tag=ASN1Tag.forTag(ASN1TagClass.APPLICATION(0x40),0x0)
        @Assert(tags.constructed().toString(),"ASN1Tag[UNIVERSAL,CONSTRUCTED,3]")
        @Assert(tags.primitive().toString(),"ASN1Tag[UNIVERSAL,PRIMITIVE,3]")
        @Assert(a.getTag(),0)
        @Assert(tags.getTag(),3)
        @Assert(tags.getAsn1TagClass().getValue().toString(),"0")
        @Assert(tags.getAsn1Encoding()==ASN1Encoding.PRIMITIVE(0*0),true)
        @Assert(tags.equals(BIT_STRING),true)
        @Assert(tags.toString(),"ASN1Tag[UNIVERSAL,PRIMITIVE,3]")

    }




    @TestCase
    func asn_Asn1Tag02(): Unit {

        let tags = ASN1_BOOLEAN
        @Assert(tags.primitive().toString(),"ASN1Tag[UNIVERSAL,PRIMITIVE,1]")
        let a:ASN1Tag=ASN1Tag.forTag(ASN1TagClass.APPLICATION(0x40),0x0)
        @Assert(a.getTag(),0)
        @Assert(tags.getTag(),1)
        @Assert(tags.getAsn1TagClass().getValue().toString(),"0")
        @Assert(tags.getAsn1Encoding()==ASN1Encoding.PRIMITIVE(0*0),true)
        @Assert(tags.equals(BIT_STRING),false)
        @Assert(tags.toString(),"ASN1Tag[UNIVERSAL,PRIMITIVE,1]")   
    }


    @TestCase
    func asn_Asn1Tag03(): Unit {

        let tags = INTEGER  
        @Assert(tags.primitive().toString(),"ASN1Tag[UNIVERSAL,PRIMITIVE,2]")
        let a:ASN1Tag=ASN1Tag.forTag(ASN1TagClass.APPLICATION(0x40),0x0)
        @Assert(a.getTag(),0)
        @Assert(tags.getTag(),2)
        @Assert(tags.getAsn1TagClass().getValue().toString(),"0")
        @Assert(tags.getAsn1Encoding()==ASN1Encoding.PRIMITIVE(0*0),true)
        @Assert(tags.equals(BIT_STRING),false)
        @Assert(tags.toString(),"ASN1Tag[UNIVERSAL,PRIMITIVE,2]")       
    }


    @TestCase
    func asn_Asn1Tag04(): Unit {

        let tags = OBJECT_IDENTIFIER
        @Assert(tags.primitive().toString(),"ASN1Tag[UNIVERSAL,PRIMITIVE,6]")
        let a:ASN1Tag=ASN1Tag.forTag(ASN1TagClass.APPLICATION(0x40),0x0)
        @Assert(a.getTag(),0)
        @Assert(tags.getTag(),6)
        @Assert(tags.getAsn1TagClass().getValue().toString(),"0")
        @Assert(tags.getAsn1Encoding()==ASN1Encoding.PRIMITIVE(0*0),true)
        @Assert(tags.equals(BIT_STRING),false)
        @Assert(tags.toString(),"ASN1Tag[UNIVERSAL,PRIMITIVE,6]")     
    }



    @TestCase
    func asn_Asn1Tag05(): Unit {

        let tags = ENUMERATED 
        @Assert(tags.primitive().toString(),"ASN1Tag[UNIVERSAL,PRIMITIVE,10]")
        let a:ASN1Tag=ASN1Tag.forTag(ASN1TagClass.APPLICATION(0x40),0x0)
        @Assert(a.getTag(),0)
        @Assert(tags.getTag(),10)
        @Assert(tags.getAsn1TagClass().getValue().toString(),"0")
        @Assert(tags.getAsn1Encoding()==ASN1Encoding.PRIMITIVE(0*0),true)
        @Assert(tags.equals(BIT_STRING),false)
        @Assert(tags.toString(),"ASN1Tag[UNIVERSAL,PRIMITIVE,10]")   
    }




    @TestCase
    func asn_Asn1Tag06(): Unit {
        try{
        let tags = ENUMERATED 
        let a:ASN1Tag=ASN1Tag.forTag(ASN1TagClass.UNIVERSAL(0x40),0x0)
        @Assert(a.getTag(),0)
        @Assert(tags.getTag(),10)
        } catch (e: Exception) {
        @Assert(e.toString(),"Exception: Unknown ASN.1 tag")
    } 
    }



    @TestCase
    func asn_Asn1Tag07(): Unit {

        let tags = ENUMERATED 
        let a:ASN1Tag=ASN1Tag.forTag(ASN1TagClass.APPLICATION(0x40),9223372036854775807)
        @Assert(tags.getTag(),10)
        @Assert(a.getTag(),9223372036854775807) 
    }



    @TestCase
    func asn_Asn1Tag08(): Unit {

   
        let a:ASN1Tag=ASN1Tag.forTag(ASN1TagClass.APPLICATION(0x40),-9223372036854775808)
        @Assert(a.getTag(),-9223372036854775808) 

    }



    @TestCase
    func asn_Asn1Tag09(): Unit {

   
        let a:ASN1Tag=ASN1Tag.forTag(ASN1TagClass.CONTEXT_SPECIFIC(0x80),-9223372036854775808)
        @Assert(a.getTag(),-9223372036854775808)
 
    }


    @TestCase
    func asn_Asn1Tag10(): Unit {

    
        let a:ASN1Tag=ASN1Tag.forTag(ASN1TagClass.PRIVATE(0xc0),-9223372036854775808)
        @Assert(a.getTag(),-9223372036854775808) 
     
    }





    @TestCase  
    func asn_Asn1Tag11(): Unit {

        let tags = BIT_STRING
        @Assert(ASN1Tag.contextSpecific(-9223372036854775808).toString(),"ASN1Tag[CONTEXT_SPECIFIC,PRIMITIVE,-9223372036854775808]")
        @Assert(ASN1Tag.application(-9223372036854775808).toString(),"ASN1Tag[APPLICATION,PRIMITIVE,-9223372036854775808]")
        @Assert(tags.hashCode(),568646418)
    }



    @TestCase   
    func asn_Asn1Tag12(): Unit {

        let tags = BIT_STRING
        @Assert(ASN1Tag.contextSpecific(9223372036854775807).toString(),"ASN1Tag[CONTEXT_SPECIFIC,PRIMITIVE,9223372036854775807]")
        @Assert(ASN1Tag.application(9223372036854775807).toString(),"ASN1Tag[APPLICATION,PRIMITIVE,9223372036854775807]")
        @Assert(tags.hashCode(),568646418)
    }


    @TestCase   
    func asn_Asn1Tag13(): Unit {

        let tags = BIT_STRING
        @Assert(ASN1Tag.contextSpecific(0).toString(),"ASN1Tag[CONTEXT_SPECIFIC,PRIMITIVE,0]")
        @Assert(ASN1Tag.application(0).toString(),"ASN1Tag[APPLICATION,PRIMITIVE,0]")
        @Assert(tags.hashCode(),568646418)
    }



    @TestCase   
    func asn_Asn1Tag014(): Unit {

        let tags = BIT_STRING
        @Assert(ASN1Tag.application(0).toString(),"ASN1Tag[APPLICATION,PRIMITIVE,0]")
        @Assert(ASN1Tag.contextSpecific(0).toString(),"ASN1Tag[CONTEXT_SPECIFIC,PRIMITIVE,0]")
        @Assert(tags.hashCode(),568646418)
    }


}