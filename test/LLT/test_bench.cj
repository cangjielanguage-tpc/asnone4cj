// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from asn1 import asn1.*
from asn1 import asn1.types.*
from asn1 import asn1.util.*
from asn1 import asn1.encodingrules.*
from asn1 import asn1.encodingrules.der.*
from std import io.*
from std import time.*

func runBench(number:Int64):Unit{

    // 缓存的readObject接口耗时数组
    var readObjectTime: Array<Int64> = Array<Int64>(number, item: 0)

    // 缓存的readTag接口耗时数组
    var readTagTime: Array<Int64> = Array<Int64>(number, item: 0)

    // 缓存的readLength接口耗时数组
    var readLengthTime: Array<Int64> = Array<Int64>(number, item: 0)

    // 缓存的readValue接口耗时数组
    var readValueTime: Array<Int64> = Array<Int64>(number, item: 0)

    // 缓存的read接口耗时数组
    var readTime: Array<Int64> = Array<Int64>(number, item: 0)

    // 缓存的writeObject接口耗时数组
    var writeObjectTime: Array<Int64> = Array<Int64>(number, item: 0)

    // 缓存的write(Array)接口耗时数组
    var write1Time: Array<Int64> = Array<Int64>(number, item: 0)

    // 缓存的write(Int64)接口耗时数组
    var write2Time: Array<Int64> = Array<Int64>(number, item: 0)

    for (i in 0..number) {
        var value: Array<Byte> = [0x01, 0x01, 0x01]
        var byteArrayStream: ByteArrayStream = ByteArrayStream()
        byteArrayStream.write(value)
        var asn1InputStream: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream)

        // 性能接口
        var start1 = Time.now().unixTimeStamp().nanoseconds()
        var asn1Object: ASN1Object = asn1InputStream.readObject()
        var end1 = Time.now().unixTimeStamp().nanoseconds()
        readObjectTime[i] = end1 - start1

        var value1: Array<Byte> = [0x01, 0x01, 0x01]
        var byteArrayStream1: ByteArrayStream = ByteArrayStream()
        byteArrayStream1.write(value1)
        var asn1InputStream1: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream1)

        // 性能接口
        var start2 = Time.now().unixTimeStamp().nanoseconds()
        var asn1Tag1: ASN1Tag = asn1InputStream1.readTag()
        var end2 = Time.now().unixTimeStamp().nanoseconds()
        readTagTime[i] = end2 - start2

        // 性能接口
        var start3 = Time.now().unixTimeStamp().nanoseconds()
        var length1: Int64 = asn1InputStream1.readLength()
        var end3 = Time.now().unixTimeStamp().nanoseconds()
        readLengthTime[i] = end3 - start3

        // 性能接口
        var start4 = Time.now().unixTimeStamp().nanoseconds()
        var bytes1: Array<Byte> = asn1InputStream1.readValue(length1);
        var end4 = Time.now().unixTimeStamp().nanoseconds()
        readValueTime[i] = end4 - start4

        var value2: Array<Byte> = [0x01, 0x01, 0x01]
        var byteArrayStream2: ByteArrayStream = ByteArrayStream()
        byteArrayStream2.write(value2)
        var asn1InputStream2: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream2)
        var asn1Tag2: ASN1Tag = asn1InputStream2.readTag()
        var length2: Int64 = asn1InputStream2.readLength()
        var bytes2: Array<Byte> = Array<Byte>(length2, item: 0)

        // 性能接口
        var start5 = Time.now().unixTimeStamp().nanoseconds()
        var int2: Int64 = asn1InputStream2.read(bytes2);
        var end5 = Time.now().unixTimeStamp().nanoseconds()
        readTime[i] = end5 - start5

        var value3: Array<Byte> = [0x01, 0x01, 0x01]
        var byteArrayStream3: ByteArrayStream = ByteArrayStream()
        var asn1OutputStream3: ASN1OutputStream = ASN1OutputStream(DEREncoder(), byteArrayStream3)

         //性能接口
        //var start6 = Time.now().unixTimeStamp().nanoseconds()
        //asn1OutputStream3.writeObject(ASN1Boolean(true))
        //var end6 = Time.now().unixTimeStamp().nanoseconds()
        //writeObjectTime[i] = end6 - start6
////
        //var value4: Array<Byte> = [0x01, 0x01, 0x01]
        //var byteArrayStream4: ByteArrayStream = ByteArrayStream()
        //var asn1OutputStream4: ASN1OutputStream = ASN1OutputStream(DEREncoder(), byteArrayStream4)
////
        //// 性能接口
        //var start7 = Time.now().unixTimeStamp().nanoseconds()
        //asn1OutputStream4.write(Array<Byte>(10000, item: 0x01))
        //var end7 = Time.now().unixTimeStamp().nanoseconds()
        //write1Time[i] = end7 - start7
////
        //// 性能接口
        //var start8 = Time.now().unixTimeStamp().nanoseconds()
        //asn1OutputStream4.write(100)
        //var end8 = Time.now().unixTimeStamp().nanoseconds()
        //write2Time[i] = end8 - start8
    }

    var intReadObjectTime: Int64 = 0
    for (i in 0..number) {
        intReadObjectTime = intReadObjectTime + readObjectTime[i]
    }
    print("[ PASSED ] CASE: ReadObject_${number} (${intReadObjectTime} ns, ${intReadObjectTime/number} ns/op)\n", flush:true)

    var intReadTagTime: Int64 = 0
    for (i in 0..number) {
        intReadTagTime = intReadTagTime + readTagTime[i]
    }
    print("[ PASSED ] CASE: ReadTag_${number} (${intReadTagTime} ns, ${intReadTagTime/number} ns/op)\n", flush:true)


    var intReadLengthTime: Int64 = 0
    for (i in 0..number) {
        intReadLengthTime = intReadLengthTime + readLengthTime[i]
    }
    print("[ PASSED ] CASE: ReadLength_${number} (${intReadLengthTime} ns, ${intReadLengthTime/number} ns/op)\n", flush:true)

    var intReadValueTime: Int64 = 0
    for (i in 0..number) {
        intReadValueTime = intReadValueTime + readValueTime[i]
    }
    print("[ PASSED ] CASE: ReadValue_${number} (${intReadValueTime} ns, ${intReadValueTime/number} ns/op)\n", flush:true)


    var intReadTime: Int64 = 0
    for (i in 0..number) {
        intReadTime = intReadTime + readTime[i]
    }
    print("[ PASSED ] CASE: Read_${number} (${intReadTime} ns, ${intReadTime/number} ns/op)\n", flush:true)


   //var intWriteObjectTime: Int64 = 0
   //for (i in 0..number) {
   //    intWriteObjectTime = intWriteObjectTime + writeObjectTime[i]
   //}
   //print("[ PASSED ] CASE: WriteObject_${number} (${intWriteObjectTime} ns, ${intWriteObjectTime/number} ns/op)\n", flush:true)
//
   //var intWrite1Time: Int64 = 0
   //for (i in 0..number) {
   //    intWrite1Time = intWrite1Time + write1Time[i]
   //}
   //print("[ PASSED ] CASE: WriteBytes_${number} (${intWrite1Time} ns, ${intWrite1Time/number} ns/op)\n", flush:true)
//
//
   //var intWrite2Time: Int64 = 0
   //for (i in 0..number) {
   //    intWrite2Time = intWrite2Time + write2Time[i]
   //}
   //print("[ PASSED ] CASE: WriteInt_${number} (${intWrite2Time} ns, ${intWrite2Time/number} ns/op)\n", flush:true)


}


main(){
	println("TCS: asn, time elapsed: 1 ns, RESULT:")
    let count = [10000]
    for (n in count){
        runBench(n)
    }
}

