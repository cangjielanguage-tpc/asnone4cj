// 3rd_party_lib:asnone4cj/target/release/asn1

import std.io.*
import asn1.*
import std.collection.*
@Test
public class asn_ASN1BitString02{

    @TestCase
    func asn_ASN1BitString_01(): Unit {

         let arr: Array<Bool> = Array<Bool>(5, repeat: true)
         var asn1itstring:ASN1BitString=ASN1BitString(arr)
         var ssss:Array<Bool> = (asn1itstring.getValue() as Array<Bool>).getOrThrow()
         println(ssss)
         println(asn1itstring.isSet(0))
         @Assert(ssss,arr)
         @Assert(asn1itstring.isSet(0),true)    
    }


    @TestCase
    func asn_ASN1BitString_02(): Unit {
         
         let arr: Array<Bool> = [true,true,false,true,false,false].toArray()
         var asn1itstring:ASN1BitString=ASN1BitString(arr)
         var ssss:Array<Bool> = (asn1itstring.getValue() as Array<Bool>).getOrThrow()
         println(ssss)
         @Assert(ssss,arr)  
    }


    @TestCase
    func asn_ASN1BitString_03(): Unit {
         
         let arr: Array<Bool> = [true].toArray()
         var asn1itstring:ASN1BitString=ASN1BitString(arr)
         var ssss:Array<Bool> = (asn1itstring.getValue() as Array<Bool>).getOrThrow()
         println(ssss)
         @Assert(ssss,arr)  
    }



    @TestCase
    func asn_ASN1BitString_04(): Unit {
         
         let arr: Array<Bool> =Array<Bool>()
         var asn1itstring:ASN1BitString=ASN1BitString(arr)
         var ssss:Array<Bool> = (asn1itstring.getValue() as Array<Bool>).getOrThrow()
         println(ssss)
         @Assert(ssss,arr)  
    }

    @TestCase
    func asn_ASN1BitString_23(): Unit {
         
         let arr: Array<Bool> =[true,true,false,true,false,false,true,true,false,true,false,false].toArray()
         var asn1itstring:ASN1BitString=ASN1BitString(arr)
         var ssss:Array<Bool> = (asn1itstring.getValue() as Array<Bool>).getOrThrow()
         println(ssss)
         @Assert(ssss,arr)  
    }


    @TestCase
    func asn_ASN1BitString_25(): Unit {

         let arr: Array<Bool> =[true,true,false,true,false,false,true,true,false,true,false,false].toArray()
         var asn1itstring:ASN1BitString=ASN1BitString(arr)
         @Assert(asn1itstring.isSet(12),false)
    }

    @TestCase
    func asn_ASN1BitString_05(): Unit {

         let arr: Array<Bool> =[true,true,false,true,false,false].toArray()
         var asn1itstring:ASN1BitString=ASN1BitString(arr)
         @Assert(asn1itstring.isSet(0),true)    
    }


    @TestCase
    func asn_ASN1BitString_06(): Unit {
         
         let arr: Array<Bool> =[true,true,false,true,false,false].toArray()
         var asn1itstring:ASN1BitString=ASN1BitString(arr)
         @Assert(asn1itstring.isSet(7),false)      
    }

    @TestCase
    func asn_ASN1BitString_07(): Unit {                           
           
         let arr: Array<Bool> =[true,true,false,true,false,false].toArray()
         var asn1itstring:ASN1BitString=ASN1BitString(arr)
         println(asn1itstring.isSet(-7))
         @Assert(asn1itstring.isSet(-7),true)      
    }


    @TestCase
    func asn_ASN1BitString_08(): Unit {
         
         let arr: Array<Bool> =[true].toArray()
         var asn1itstring:ASN1BitString=ASN1BitString(arr)
        @Assert(asn1itstring.isSet(0),true)      

    }


    @TestCase
    func asn_ASN1BitString_09(): Unit {
         
        try {
            let arr: Array<Bool> =Array<Bool>()
            var asn1itstring:ASN1BitString=ASN1BitString(arr)
            @Assert(asn1itstring.isSet(0),true)
        } catch (e: Exception) {
        @Assert(e.toString(),"IndexOutOfBoundsException")
    }      
    }



        @TestCase
    func asn_ASN1BitString_10(): Unit {

         let arr: Array<Bool> =[true,true,false,true,false,false].toArray()
         var asn1itstring:ASN1BitString=ASN1BitString(arr)
         @Assert(asn1itstring.length(),6)    
    }



    @TestCase
    func asn_ASN1BitString_11(): Unit {                            
           
         let arr: Array<Bool> =[true,true,true,true,true,true].toArray()
         var asn1itstring:ASN1BitString=ASN1BitString(arr)
         println(asn1itstring.length())
         @Assert(asn1itstring.length(),6)      
    }

    @TestCase
    func asn_ASN1BitString_12(): Unit {
         
         let arr: Array<Bool> =[true].toArray()
         var asn1itstring:ASN1BitString=ASN1BitString(arr)
        @Assert(asn1itstring.length(),1)      
    }


    @TestCase
    func asn_ASN1BitString_13(): Unit {
         
         let arr: Array<Bool> =Array<Bool>()
         var asn1itstring:ASN1BitString=ASN1BitString(arr)
        @Assert(asn1itstring.length(),-8)      
    }


}