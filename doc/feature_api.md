# asn1-cj 库

## IO操作 - 输出流

### 介绍

写入数据工具，对数据进行编码

### 主要接口

#### class ASN1OutputStream

```cangjie
public class ASN1OutputStream <: OutputStream {
    /*
     * 初始化 ASN1OutputStream
     *
     * 参数 encoder - 编码器
     * 参数 out - 数据流
     */
    public init(encoder: ASN1Encoder, out: OutputStream)

    /*
     * 写入一个 ASN1Object 对象
     *
     * 参数 asn1Object - 要写入的 ASN1Object 对象
     */
    public func writeObject(asn1Object: ASN1Object): Unit

    /*
     * 写入字节数组
     *
     * 参数 b - 要写入的字节数组
     */
    public func write(b: Array<Byte>): Unit

    /*
     * 写入单个字节
     *
     * 参数 b - 要写入的字节（仅低 8 位有效）
     *
     * 注意：内部使用复用缓冲向底层流传递字节，自定义 OutputStream 实现须当场消费传入数组，不得保留数组引用；ASN1OutputStream 单实例不可跨线程并发使用
     */
    public func write(b: Int64): Unit
}
```

### 示例

```cangjie
import asn1.*
import std.io.*

main(): Int64 {
    var value3: Array<Byte> = [0x01, 0x01, 0x00]
    var byteArrayStream3: ByteBuffer = ByteBuffer()
    var asn1OutputStream3: ASN1OutputStream = ASN1OutputStream(DEREncoder(), byteArrayStream3)
    asn1OutputStream3.writeObject(ASN1Boolean(false))
    if (byteArrayStream3.bytes() == value3) {
        println("success")
    }

    var value4: Array<Byte> = [0x01, 0x01, 0x01]
    var byteArrayStream4: ByteBuffer = ByteBuffer()
    var asn1OutputStream4: ASN1OutputStream = ASN1OutputStream(DEREncoder(), byteArrayStream4)
    asn1OutputStream4.writeObject(ASN1Boolean(true))
    if (byteArrayStream4.bytes() == value4) {
        println("success")
    }

    return 0
}
```

## IO操作 - 输入流

### 介绍

读取数据工具，对数据进行解码

### 主要接口

#### class ASN1InputStream

```cangjie
public class ASN1InputStream <: InputStream & Iterable<ASN1Object> {
    /*
     * 初始化 ASN1InputStream
     *
     * 参数 decoder - 解码器
     * 参数 wrapped - 数据流
     */
    public init(decoder: ASN1Decoder, wrapped: InputStream)

    /*
     * 初始化 ASN1InputStream
     *
     * 参数 decoder - 解码器
     * 参数 value - 数组数据
     */
    public init(decoder: ASN1Decoder, value: Array<Byte>)

    /*
     * 获取 ASN1 对象
     *
     * 返回值 ASN1Object - 获取到的 ASN1Object
     * 异常 NoneValueException - 可 Seekable 数据流已到末尾时抛出
     * 异常 ASN1ParseException - 非 Seekable 数据流已到末尾或内容不合法时抛出
     */
    public func readObject(): ASN1Object 

    /*
     * 读取当前值
     *
     * 参数 length - 数据长度
     * 参数 Array<Byte>  - 读取到的数组数据
     * 异常 ASN1ParseException - 数据流剩余数据不足 length 时抛出
     */
    public func readValue(length: Int64): Array<Byte> 

    /*
     * 获取迭代器
     *
     * 返回值 Iterator<ASN1Object> - 返回 ASN1Object 迭代器
     */
    public override func iterator(): Iterator<ASN1Object>

    /*
     * 获取当前数据的 ASN1Tag
     *
     * 返回值 ASN1Tag - 获取到的 ASN1Tag
     * 异常 ASN1ParseException - 数据流已到末尾时抛出
     */
    public func readTag(): ASN1Tag

    /*
     * 获取 ASN1 数据长度
     *
     * 返回值 Int64 - 读取到的长度
     * 异常 ASN1ParseException - 数据流已到末尾时抛出
     */
    public func readLength(): Int64

    /*
     * 读取原始数据
     *
     * 参数 buffer - 要存入的数组
     * 参数 Int64 - 读取到的长度
     */
    public override func read(buffer: Array<Byte>): Int64 
}
```

#### class IteratorASN1Object

```cangjie
class IteratorASN1Object <: Iterator<ASN1Object> {
    /*
     * 获取迭代器 -- 内部接口
     *
     * 返回值 Iterator<ASN1Object> - 返回 ASN1Object 迭代器
     */
    public func iterator(): Iterator<ASN1Object>

    /*
     * 获取下一条数据 -- 内部接口
     *
     * 返回值 ASN1Object
     */
    public func next(): Option<ASN1Object> 
}
```

### 示例

```cangjie
import asn1.*
import std.io.*

main(): Int64 {
    var value: Array<Byte> = [0x01, 0x01, 0x0]
    var byteArrayStream: ByteBuffer = ByteBuffer()
    byteArrayStream.write(value)
    var asn1InputStream: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream)
    var asn1Object: ASN1Object = asn1InputStream.readObject()
    if (asn1Object is ASN1Boolean) {
        println("success")
    }
    var object: ASN1Boolean = (asn1Object as ASN1Boolean).getOrThrow()
    var anyValue: Any = object.getValue()
    var boolValue: Bool = (anyValue as Bool).getOrThrow()
    if (!boolValue) {
        println("success")
    }
    if (object.valueHash() == 1237) {
        println("success")
    }

    var value1: Array<Byte> = [0x01, 0x01, 0x01]
    var byteArrayStream1: ByteBuffer = ByteBuffer()
    byteArrayStream1.write(value1)
    var asn1InputStream1: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream1)
    var asn1Object1: ASN1Object = asn1InputStream1.readObject()
    if (asn1Object1 is ASN1Boolean) {
        println("success")
    }
    var object1: ASN1Boolean = (asn1Object1 as ASN1Boolean).getOrThrow()
    var anyValue1: Any = object1.getValue()
    var boolValue1: Bool = (anyValue1 as Bool).getOrThrow()
    if (boolValue1) {
        println("success")
    }
    if (object1.valueHash() == 1231) {
        println("success")
    }

    return 0
}
```

## Bit类型

### 介绍

Bit类型数据编解码

### 主要接口

#### class  ASN1BitString

```cangjie
public class ASN1BitString <: ASN1String {
    /*
     * 初始化 ASN1BitString  -- 内部接口
     *
     * 参数 tag - 初始化的 ASN1Tag 值
     * 参数 bytes - 初始化的 Array<Byte> 值
     * 参数 unusedBits - 初始化的未使用的byte值
     */
    public init(tag: ASN1Tag, bytes: Array<Byte>, unusedBits: Int64)

    /*
     * 初始化 ASN1BitString  -- 内部接口
     *
     * 参数 tag - 初始化的 ASN1Tag 值
     * 参数 unusedBits - 初始化的未使用的byte值
     */
    public init(bytes: Array<Byte>, unusedBits: Int64)

    /*
     * 初始化 ASN1BitString
     *
     * 参数 bits - 初始化的 Array<Bool> 值
     */
    public init(bits: Array<Bool>)

    /*
     * 获取当前数组数据 -- 内部接口
     *
     * 返回值 String - 当前数组数据
     */
    public override func valueString(): String

    /*
     *  获取当前值
     *
     * 返回值 Any - 获取当前存储值
     */
    public override func getValue(): Any

    /*
     * 检查 ASN.1 中是否设置了 BIT_STRING
     *
     * 参数 x - 检查的位置值
     * 返回值 Bool - 是否设置了值
     */
    public func isSet(x: Int64): Bool

    /*
     * 返回数据长度
     *
     * 返回值 Int64 - 数据长度
     */
    public override func length(): Int64
}
```

#### class BitStringParser

```cangjie
public class BitStringParser <: ASN1Parser {
    /*
     * 初始化 BitStringParser -- 内部接口
     *
     * 参数 decoder - 解码器
     */
    public init(decoder: ASN1Decoder)

    /*
     * 对数据解码 -- 内部接口
     *
     * 参数 asn1Tag - ASN1Tag 对象
     * 参数 value - Byte 数组
     * 返回值 ASN1Object - ASN1Object 对象
     */
    public override func parse(asn1Tag: ASN1Tag, value: Array<Byte>): ASN1Object
}
```

#### class BitStringSerializer

```cangjie
public class BitStringSerializer <: ASN1Serializer {
    /*
     * 初始化 BitStringSerializer -- 内部接口
     *
     * 参数 encoder - 编码器
     */
    public init(encoder: ASN1Encoder)

    /*
     * 获取数组长度 -- 内部接口
     *
     * 参数 asn1Object - ASN1Object 对象
     * 返回值 Int64 - 长度
     */
    public override func serializedLength(asn1Object: ASN1Object): Int64

    /*
     * 对数据编码 --  内部接口
     *
     * 参数 asn1Object - ASN1Object 对象
     * 参数 stream - ASN1OutputStream 对象
     */
    public override func serialize(asn1Object: ASN1Object, stream: ASN1OutputStream): Unit
}
```

### 示例

```cangjie
import asn1.*
import std.io.*

main() {
    let bytesBuf: Array<Byte> = Array<Byte>(10, item: 0)
    let asn = ASN1BitString(bytesBuf, 6)
    let arr: Array<Bool> = Array<Bool>(5, item: true)
    let asn1 = ASN1BitString(arr)
    asn.getValue()
    let indd = asn.isSet(2)
    let src = asn.length()

    let tags = INTEGER
    let dec: BERDecoder = BERDecoder()
    let bitss = BitStringParser(dec)
    bitss.parse(tags, bytesBuf)

    if (indd != false) {
        return 1
    }
    if (src != 74) {
        return 2
    }
    
    return 0
}
```

## Set类型

### 介绍

Set类型数据编解码

### 主要接口

#### class ASN1Set

```cangjie
public class ASN1Set <: ASN1Object & ASN1Constructed {
    /*
     * 初始化 ASN1Set -- 内部接口
     *
     * 参数 objects - ASN1Object 对象集合
     * 参数 bytes - Byte 对象集合
     */
    public init(objects: HashSet<ASN1Object>, bytes: Array<Byte>)

    /*
     * 初始化 ASN1Set
     *
     * 参数 objects - ASN1Object 对象集合
     */
    public init(objects: HashSet<ASN1Object>)

    /*
     * 获取原始数据
     *
     * 返回值 ASN1Object - 返回当前的 ASN1Object 对象集合
     */
    public func getValue(): HashSet<ASN1Object>

    /*
     * 获取迭代器
     *
     * 返回值 Iterator<ASN1Object> - ASN1Object 的迭代器
     */
    public func iterator(): Iterator<ASN1Object>
}
```

#### class SetParser

```cangjie
class SetParser <: ASN1Parser {
    /*
     * 初始化 SetParser -- 内部接口
     *
     * 参数 decoder - 解码器
     */
    public init(decoder: ASN1Decoder)

    /*
     * 对数据解码 -- 内部接口
     *
     * 参数 asn1Tag - ASN1Tag 对象
     * 参数 value - Byte 数组
     * 返回值 ASN1Object - ASN1Object 对象
     */
    public func parse(asn1Tag: ASN1Tag, value: Array<Byte>): ASN1Object
}
```

#### class SetSerializer

```cangjie
class SetSerializer <: ASN1Serializer {
    /*
     * 初始化 SetSerializer -- 内部接口
     *
     * 参数 encoder - 编码器
     */
    public init(encoder: ASN1Encoder)

    /*
     * 获取数组长度 -- 内部接口
     *
     * 参数 asn1Object - ASN1Object 对象
     * 返回值 Int64 - 长度
     */
    public func serializedLength(asn1Object: ASN1Object): Int64

    /*
     * 对数据编码 --  内部接口
     *
     * 参数 asn1Object - ASN1Object 对象
     * 参数 stream - ASN1OutputStream 对象
     */
    public func serialize(asn1Object: ASN1Object, stream: ASN1OutputStream): Unit
}
```

### 示例

```cangjie
import asn1.*
import std.collection.*

main() {
    var arr = HashSet<ASN1Object>()
    let buf: Array<Byte> = [1]
    var sets = ASN1Set(arr,buf)
    var sets1 = ASN1Set(arr)

    let src = sets.getValue()
    let src1 = sets.iterator()

    println(src.size)
    if (src.size != 0){
        return 1
    }

    return 0
}
```

## Boolean类型

### 介绍

Boolean类型数据编解码

### 主要接口

#### class ASN1Boolean

```cangjie
public class ASN1Boolean <: ASN1PrimitiveValue {
    /*
     * 初始化 ASN1Boolean
     *
     * 参数 value - 初始化的 Bool 值
     */
    public init(value: Bool)

    /*
     * 初始化 ASN1Boolean -- 内部接口
     *
     * 参数 value - 初始化的 Bool 值
     * 参数 value - Byte 对象集合
     */
    public init(value: Bool, valueBytes: Array<Byte>)

    /*
     *  获取当前值
     *
     * 返回值 Any - 获取当前存储值
     */
    public func getValue(): Any

    /*
     * 获取value的Hash值  -- 内部接口
     *
     * 返回值 Int64 - value的Hash值
     */
    public func valueHash(): Int64
}
```

#### class BooleanParser

```cangjie
public class BooleanParser <: ASN1Parser {
    /*
     * 初始化 BooleanParser -- 内部接口
     *
     * 参数 decoder - 解码器
     */
    public init(decoder: ASN1Decoder)

    /*
     * 对数据解码 -- 内部接口
     *
     * 参数 asn1Tag - ASN1Tag 对象
     * 参数 value - Byte 数组
     * 返回值 ASN1Object - ASN1Object 对象
     */
    public override func parse(asn1Tag: ASN1Tag, value: Array<Byte>): ASN1Object
}
```

#### class BooleanSerializer

```cangjie
public class BooleanSerializer <: ASN1Serializer {
    /*
     * 初始化 BooleanSerializer -- 内部接口
     *
     * 参数 encoder - 编码器
     */
    public init(encoder: ASN1Encoder)

    /*
     * 获取数组长度 -- 内部接口
     *
     * 参数 asn1Object - ASN1Object 对象
     * 返回值 Int64 - 长度
     */
    public override func serializedLength(asn1Object: ASN1Object): Int64

    /*
     * 对数据编码 --  内部接口
     *
     * 参数 asn1Object - ASN1Object 对象
     * 参数 stream - ASN1OutputStream 对象
     */
    public override func serialize(asn1Object: ASN1Object, stream: ASN1OutputStream): Unit
}
```

### 示例

```cangjie
import asn1.*
import std.io.*

// 数组第一位0x01代表ASN1Boolean类型
// 数组第二位0x01代表数组长度为1
// 数组第三位0x0代表false,0x01代表true,默认值是true
main(): Int64 {
    // false
    var value: Array<Byte> = [0x01, 0x01, 0x0]
    var byteArrayStream: ByteBuffer = ByteBuffer()
    byteArrayStream.write(value)
    var asn1InputStream: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream)
    var asn1Object: ASN1Object = asn1InputStream.readObject()
    if (!(asn1Object is ASN1Boolean)) {
        return 1
    }
    var object: ASN1Boolean = (asn1Object as ASN1Boolean).getOrThrow()
    var anyValue: Any = object.getValue()
    var boolValue: Bool = (anyValue as Bool).getOrThrow()
    if (boolValue) {
        return 1
    }
    if (object.valueHash() != 1237) {
        return 1
    }

    // true
    var value1: Array<Byte> = [0x01, 0x01, 0x01]
    var byteArrayStream1: ByteBuffer = ByteBuffer()
    byteArrayStream1.write(value1)
    var asn1InputStream1: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream1)
    var asn1Object1: ASN1Object = asn1InputStream1.readObject()
    if (!(asn1Object1 is ASN1Boolean)) {
        return 1
    }
    var object1: ASN1Boolean = (asn1Object1 as ASN1Boolean).getOrThrow()
    var anyValue1: Any = object1.getValue()
    var boolValue1: Bool = (anyValue1 as Bool).getOrThrow()
    if (!boolValue1) {
        return 1
    }
    if (object1.valueHash() != 1231) {
        return 1
    }

    // true
    var value2: Array<Byte> = [0x01, 0x01, 0xFF]
    var byteArrayStream2: ByteBuffer = ByteBuffer()
    byteArrayStream2.write(value2)
    var asn1InputStream2: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream2)
    var asn1Object2: ASN1Object = asn1InputStream2.readObject()
    if (!(asn1Object2 is ASN1Boolean)) {
        return 1
    }
    var object2: ASN1Boolean = (asn1Object2 as ASN1Boolean).getOrThrow()
    var anyValue2: Any = object2.getValue()
    var boolValue2: Bool = (anyValue2 as Bool).getOrThrow()
    if (!boolValue2) {
        return 1
    }
    if (object2.valueHash() != 1231) {
        return 1
    }

    var value3: Array<Byte> = [0x01, 0x01, 0x00]
    var byteArrayStream3: ByteBuffer = ByteBuffer()
    var asn1OutputStream3: ASN1OutputStream = ASN1OutputStream(DEREncoder(), byteArrayStream3)
    asn1OutputStream3.writeObject(ASN1Boolean(false))
    if (byteArrayStream3.bytes() != value3) {
        return 1
    }

    var value4: Array<Byte> = [0x01, 0x01, 0x01]
    var byteArrayStream4: ByteBuffer = ByteBuffer()
    var asn1OutputStream4: ASN1OutputStream = ASN1OutputStream(DEREncoder(), byteArrayStream4)
    asn1OutputStream4.writeObject(ASN1Boolean(true))
    if (byteArrayStream4.bytes() != value4) {
        return 1
    }

    var value5: Array<Byte> = [0x01, 0x01, 0x00]
    var byteArrayStream5: ByteBuffer = ByteBuffer()
    var asn1OutputStream5: ASN1OutputStream = ASN1OutputStream(DEREncoder(), byteArrayStream5)
    asn1OutputStream5.writeObject(ASN1Boolean(false, Array<Byte>()))
    if (byteArrayStream5.bytes() != value5) {
        return 1
    }

    var value6: Array<Byte> = [0x01, 0x01, 0x01]
    var byteArrayStream6: ByteBuffer = ByteBuffer()
    var asn1OutputStream6: ASN1OutputStream = ASN1OutputStream(DEREncoder(), byteArrayStream6)
    asn1OutputStream6.writeObject(ASN1Boolean(true, Array<Byte>()))
    if (byteArrayStream6.bytes() != value6) {
        return 1
    }

    return 0
}
```

## Integer类型

### 介绍

Integer类型数据编解码

### 主要接口

#### class ASN1Integer

```cangjie
public class ASN1Integer <: ASN1PrimitiveValue {
    /*
     * 初始化 ASN1Integer
     *
     * 参数 value - 初始化的 Int64 值
     */
    public init(value: Int64)

    /*
     * 初始化 ASN1Integer
     *
     * 参数 value - 初始化的 BigInt 值
     */
    public init(value: BigInt)

    /*
     * 初始化 ASN1Integer -- 内部接口
     *
     * 参数 value - 初始化的 BigInt 值
     * 参数 valueBytes - Byte 对象集合
     */
    public init(value: BigInt, valueBytes: Array<Byte>)

    /*
     *  获取当前值
     *
     * 返回值 Any - 获取当前存储值
     */
    public override func getValue(): Any

    /*
     * 获取value的Hash值  -- 内部接口
     *
     * 返回值 Int64 - value的Hash值
     */
    public func valueHash(): Int64
}
```

#### class IntegerParser

```cangjie
public class IntegerParser <: ASN1Parser {
    /*
     * 初始化 IntegerParser -- 内部接口
     *
     * 参数 decoder - 解码器
     */
    public init(decoder: ASN1Decoder)

    /*
     * 对数据解码 -- 内部接口
     *
     * 参数 asn1Tag - ASN1Tag 对象
     * 参数 value - Byte 数组
     * 返回值 ASN1Object - ASN1Object 对象
     */
    public override func parse(asn1Tag: ASN1Tag, value: Array<Byte>): ASN1Object
}
```

#### class IntegerSerializer

```cangjie
public class IntegerSerializer <: ASN1Serializer {
    /*
     * 初始化 IntegerSerializer -- 内部接口
     *
     * 参数 encoder - 编码器
     */
    public init(encoder: ASN1Encoder)
    
    /*
     * 获取数组长度 -- 内部接口
     *
     * 参数 asn1Object - ASN1Object 对象
     * 返回值 Int64 - 长度
     */
    public override func serializedLength(asn1Object: ASN1Object): Int64

    /*
     * 对数据编码 --  内部接口
     *
     * 参数 asn1Object - ASN1Object 对象
     * 参数 stream - ASN1OutputStream 对象
     */
    public override func serialize(asn1Object: ASN1Object, stream: ASN1OutputStream): Unit
}
```

### 示例

```cangjie
from numeric import bigint.*
import asn1.*
import std.io.*

// 数组第一位0x02代表ASN1Integer类型
// 数组第二位0x01代表数组长度为1
// 数组第三位开始代表数组内容
main(): Int64 {
    var value: Array<Byte> = [0x02, 0x01, 0x03]
    var byteArrayStream: ByteBuffer = ByteBuffer()
    byteArrayStream.write(value)
    var asn1InputStream: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream)
    var asn1Object: ASN1Object = asn1InputStream.readObject()
    if (!(asn1Object is ASN1Integer)) {
        return 1
    }
    var object: ASN1Integer = (asn1Object as ASN1Integer).getOrThrow()
    var anyValue: Any = object.getValue()
    var bigValue: BigInt = (anyValue as BigInt).getOrThrow()
    var intValue: String = bigValue.toStringDec()
    if (!(intValue.equals("3"))) {
        return 2
    }
    var intHashcode: Int64 = object.valueHash()
    if (intHashcode != 3) {
        return 3
    }

    var value0: Array<Byte> = [0x02, 0x01, 0x33]
    var byteArrayStream0: ByteBuffer = ByteBuffer()
    byteArrayStream0.write(value0)
    var asn1InputStream0: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream0)
    var asn1Object0: ASN1Object = asn1InputStream0.readObject()
    if (!(asn1Object0 is ASN1Integer)) {
        return 4
    }
    var object0: ASN1Integer = (asn1Object0 as ASN1Integer).getOrThrow()
    var anyValue0: Any = object0.getValue()
    var bigValue0: BigInt = (anyValue0 as BigInt).getOrThrow()
    var intValue0: String = bigValue0.toStringDec()
    if (!(intValue0.equals("51"))) {
        return 5
    }
    var intHashcode0: Int64 = object0.valueHash()
    if (intHashcode0 != 51) {
        return 6
    }

    var value1: Array<Byte> = [0x02, 0x01, 0x44]
    var byteArrayStream1: ByteBuffer = ByteBuffer()
    byteArrayStream1.write(value1)
    var asn1InputStream1: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream1)
    var asn1Object1: ASN1Object = asn1InputStream1.readObject()
    if (!(asn1Object1 is ASN1Integer)) {
        return 7
    }
    var object1: ASN1Integer = (asn1Object1 as ASN1Integer).getOrThrow()
    var anyValue1: Any = object1.getValue()
    var bigValue1: BigInt = (anyValue1 as BigInt).getOrThrow()
    var intValue1: String = bigValue1.toStringDec()
    if (!(intValue1.equals("68"))) {
        return 8
    }
    var intHashcode1: Int64 = object1.valueHash()
    if (intHashcode1 != 68) {
        return 9
    }

    var value2: Array<Byte> = [0x02, 0x01, 0x55]
    var byteArrayStream2: ByteBuffer = ByteBuffer()
    byteArrayStream2.write(value2)
    var asn1InputStream2: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream2)
    var asn1Object2: ASN1Object = asn1InputStream2.readObject()
    if (!(asn1Object2 is ASN1Integer)) {
        return 10
    }
    var object2: ASN1Integer = (asn1Object2 as ASN1Integer).getOrThrow()
    var anyValue2: Any = object2.getValue()
    var bigValue2: BigInt = (anyValue2 as BigInt).getOrThrow()
    var intValue2: String = bigValue2.toStringDec()
    if (!(intValue2.equals("85"))) {
        return 11
    }
    var intHashcode2: Int64 = object2.valueHash()
    if (intHashcode2 != 85) {
        return 12
    }

    var value3: Array<Byte> = [0x02, 0x01, 0x66]
    var byteArrayStream3: ByteBuffer = ByteBuffer()
    byteArrayStream3.write(value3)
    var asn1InputStream3: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream3)
    var asn1Object3: ASN1Object = asn1InputStream3.readObject()
    if (!(asn1Object3 is ASN1Integer)) {
        return 13
    }
    var object3: ASN1Integer = (asn1Object3 as ASN1Integer).getOrThrow()
    var anyValue3: Any = object3.getValue()
    var bigValue3: BigInt = (anyValue3 as BigInt).getOrThrow()
    var intValue3: String = bigValue3.toStringDec()
    if (!(intValue3.equals("102"))) {
        return 14
    }
    var intHashcode3: Int64 = object3.valueHash()
    if (intHashcode3 != 102) {
        return 15
    }

    var value4: Array<Byte> = [0x02, 0x01, 0x7F]
    var byteArrayStream4: ByteBuffer = ByteBuffer()
    byteArrayStream4.write(value4)
    var asn1InputStream4: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream4)
    var asn1Object4: ASN1Object = asn1InputStream4.readObject()
    if (!(asn1Object4 is ASN1Integer)) {
        return 16
    }
    var object4: ASN1Integer = (asn1Object4 as ASN1Integer).getOrThrow()
    var anyValue4: Any = object4.getValue()
    var bigValue4: BigInt = (anyValue4 as BigInt).getOrThrow()
    var intValue4: String = bigValue4.toStringDec()
    if (!(intValue4.equals("127"))) {
        return 17
    }
    var intHashcode4: Int64 = object4.valueHash()
    if (intHashcode4 != 127) {
        return 18
    }

    var value5: Array<Byte> = [0x02, 0x01, 0xFF]
    var byteArrayStream5: ByteBuffer = ByteBuffer()
    byteArrayStream5.write(value5)
    var asn1InputStream5: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream5)
    var asn1Object5: ASN1Object = asn1InputStream5.readObject()
    if (!(asn1Object5 is ASN1Integer)) {
        return 19
    }
    var object5: ASN1Integer = (asn1Object5 as ASN1Integer).getOrThrow()
    var anyValue5: Any = object5.getValue()
    var bigValue5: BigInt = (anyValue5 as BigInt).getOrThrow()
    var intValue5: String = bigValue5.toStringDec()
    if (!(intValue5.equals("-1"))) {
        return 20
    }
    var intHashcode5: Int64 = object5.valueHash()
    if (intHashcode5 != -1) {
        return 21
    }

    var value6: Array<Byte> = [0x02, 0x02, 0x01, 0x00]
    var byteArrayStream6: ByteBuffer = ByteBuffer()
    byteArrayStream6.write(value6)
    var asn1InputStream6: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream6)
    var asn1Object6: ASN1Object = asn1InputStream6.readObject()
    if (!(asn1Object6 is ASN1Integer)) {
        return 22
    }
    var object6: ASN1Integer = (asn1Object6 as ASN1Integer).getOrThrow()
    var anyValue6: Any = object6.getValue()
    var bigValue6: BigInt = (anyValue6 as BigInt).getOrThrow()
    var intValue6: String = bigValue6.toStringDec()
    if (!(intValue6.equals("256"))) {
        return 23
    }
    var intHashcode6: Int64 = object6.valueHash()
    if (intHashcode6 != 256) {
        return 24
    }

    var value7: Array<Byte> = [0x02, 0x02, 0xff, 0xff]
    var byteArrayStream7: ByteBuffer = ByteBuffer()
    byteArrayStream7.write(value7)
    var asn1InputStream7: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream7)
    var asn1Object7: ASN1Object = asn1InputStream7.readObject()
    if (!(asn1Object7 is ASN1Integer)) {
        return 25
    }
    var object7: ASN1Integer = (asn1Object7 as ASN1Integer).getOrThrow()
    var anyValue7: Any = object7.getValue()
    var bigValue7: BigInt = (anyValue7 as BigInt).getOrThrow()
    var intValue7: String = bigValue7.toStringDec()
    if (!(intValue7.equals("-1"))) {
        return 26
    }
    var intHashcode7: Int64 = object7.valueHash()
    if (intHashcode7 != -1) {
        return 27
    }

    var value8: Array<Byte> = [0x02, 0x03, 0x01, 0xff, 0xff]
    var byteArrayStream8: ByteBuffer = ByteBuffer()
    byteArrayStream8.write(value8)
    var asn1InputStream8: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream8)
    var asn1Object8: ASN1Object = asn1InputStream8.readObject()
    if (!(asn1Object8 is ASN1Integer)) {
        return 28
    }
    var object8: ASN1Integer = (asn1Object8 as ASN1Integer).getOrThrow()
    var anyValue8: Any = object8.getValue()
    var bigValue8: BigInt = (anyValue8 as BigInt).getOrThrow()
    var intValue8: String = bigValue8.toStringDec()
    if (!(intValue8.equals("131071"))) {
        return 29
    }
    var intHashcode8: Int64 = object8.valueHash()
    if (intHashcode8 != 131071) {
        return 30
    }

    var value9: Array<Byte> = [0x02, 0x04, 0x01, 0x01, 0xff, 0xff]
    var byteArrayStream9: ByteBuffer = ByteBuffer()
    byteArrayStream9.write(value9)
    var asn1InputStream9: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream9)
    var asn1Object9: ASN1Object = asn1InputStream9.readObject()
    if (!(asn1Object9 is ASN1Integer)) {
        return 31
    }
    var object9: ASN1Integer = (asn1Object9 as ASN1Integer).getOrThrow()
    var anyValue9: Any = object9.getValue()
    var bigValue9: BigInt = (anyValue9 as BigInt).getOrThrow()
    var intValue9: String = bigValue9.toStringDec()
    if (!(intValue9.equals("16908287"))) {
        return 32
    }
    var intHashcode9: Int64 = object9.valueHash()
    if (intHashcode9 != 16908287) {
        return 33
    }

    var value10: Array<Byte> = [0x02, 0x01, 0x03]
    var byteArrayStream10: ByteBuffer = ByteBuffer()
    var asn1OutputStream10: ASN1OutputStream = ASN1OutputStream(encode(), byteArrayStream10)
    asn1OutputStream10.writeObject(ASN1Integer(3))
    if (byteArrayStream10.bytes() != value10) {
        return 34
    }

    var value12: Array<Byte> = [0x02, 0x01, 0x33]
    var byteArrayStream12: ByteBuffer = ByteBuffer()
    var asn1OutputStream12: ASN1OutputStream = ASN1OutputStream(encode(), byteArrayStream12)
    asn1OutputStream12.writeObject(ASN1Integer(51))
    if (byteArrayStream12.bytes() != value12) {
        return 35
    }

    var value14: Array<Byte> = [0x02, 0x01, 0x44]
    var byteArrayStream14: ByteBuffer = ByteBuffer()
    var asn1OutputStream14: ASN1OutputStream = ASN1OutputStream(encode(), byteArrayStream14)
    asn1OutputStream14.writeObject(ASN1Integer(68))
    if (byteArrayStream14.bytes() != value14) {
        return 36
    }

    var value16: Array<Byte> = [0x02, 0x01, 0x55]
    var byteArrayStream16: ByteBuffer = ByteBuffer()
    var asn1OutputStream16: ASN1OutputStream = ASN1OutputStream(encode(), byteArrayStream16)
    asn1OutputStream16.writeObject(ASN1Integer(85))
    if (byteArrayStream16.bytes() != value16) {
        return 37
    }

    var value18: Array<Byte> = [0x02, 0x01, 0x66]
    var byteArrayStream18: ByteBuffer = ByteBuffer()
    var asn1OutputStream18: ASN1OutputStream = ASN1OutputStream(encode(), byteArrayStream18)
    asn1OutputStream18.writeObject(ASN1Integer(102))
    if (byteArrayStream18.bytes() != value18) {
        return 38
    }

    var value20: Array<Byte> = [0x02, 0x01, 0x7F]
    var byteArrayStream20: ByteBuffer = ByteBuffer()
    var asn1OutputStream20: ASN1OutputStream = ASN1OutputStream(encode(), byteArrayStream20)
    asn1OutputStream20.writeObject(ASN1Integer(127))
    if (byteArrayStream20.bytes() != value20) {
        return 39
    }

    var value22: Array<Byte> = [0x02, 0x01, 0xFF]
    var byteArrayStream22: ByteBuffer = ByteBuffer()
    var asn1OutputStream22: ASN1OutputStream = ASN1OutputStream(encode(), byteArrayStream22)
    asn1OutputStream22.writeObject(ASN1Integer(-1))
    if (byteArrayStream22.bytes() != value22) {
        return 40
    }

    var value24: Array<Byte> = [0x02, 0x02, 0x01, 0x00]
    var byteArrayStream24: ByteBuffer = ByteBuffer()
    var asn1OutputStream24: ASN1OutputStream = ASN1OutputStream(encode(), byteArrayStream24)
    asn1OutputStream24.writeObject(ASN1Integer(256))
    if (byteArrayStream24.bytes() != value24) {
        return 41
    }

    var value28: Array<Byte> = [0x02, 0x03, 0x01, 0xff, 0xff]
    var byteArrayStream28: ByteBuffer = ByteBuffer()
    var asn1OutputStream28: ASN1OutputStream = ASN1OutputStream(encode(), byteArrayStream28)
    asn1OutputStream28.writeObject(ASN1Integer(131071))
    if (byteArrayStream28.bytes() != value28) {
        return 42
    }

    var value30: Array<Byte> = [0x02, 0x04, 0x01, 0x01, 0xff, 0xff]
    var byteArrayStream30: ByteBuffer = ByteBuffer()
    var asn1OutputStream30: ASN1OutputStream = ASN1OutputStream(encode(), byteArrayStream30)
    asn1OutputStream30.writeObject(ASN1Integer(16908287))
    if (byteArrayStream30.bytes() != value30) {
        return 43
    }

    return 0
}

class encode <: ASN1Encoder {}
```

## Null类型

### 介绍

Null类型数据编解码

### 主要接口

#### class ASN1Null

```cangjie
public class ASN1Null <: ASN1PrimitiveValue {
    /*
     * 初始化 ASN1Null
     */
    public init()

    /*
     *  获取当前值
     *
     * 返回值 Any - 获取当前存储值
     */
    public override func getValue(): Any

    /*
     * 获取value的Hash值  -- 内部接口
     *
     * 返回值 Int64 - value的Hash值
     */
    public func valueHash(): Int64
}
```

#### class NullParser

```cangjie
public class NullParser <: ASN1Parser {
    /*
     * 初始化 NullParser -- 内部接口
     *
     * 参数 decoder - 解码器
     */
    public init(decoder: ASN1Decoder)

    /*
     * 对数据解码 -- 内部接口
     *
     * 参数 asn1Tag - ASN1Tag 对象
     * 参数 value - Byte 数组
     * 返回值 ASN1Object - ASN1Object 对象
     */
    public override func parse(asn1Tag: ASN1Tag, value: Array<Byte>): ASN1Object
}
```

#### class NullSerializer

```cangjie
public class NullSerializer <: ASN1Serializer {
    /*
     * 初始化 NullSerializer -- 内部接口
     *
     * 参数 encoder - 编码器
     */
    public init(encoder: ASN1Encoder)
    
    /*
     * 获取数组长度 -- 内部接口
     *
     * 参数 asn1Object - ASN1Object 对象
     * 返回值 Int64 - 长度
     */
    public override func serializedLength(asn1Object: ASN1Object): Int64

    /*
     * 对数据编码 --  内部接口
     *
     * 参数 asn1Object - ASN1Object 对象
     * 参数 stream - ASN1OutputStream 对象
     */
    public override func serialize(asn1Object: ASN1Object, stream: ASN1OutputStream): Unit
}
```

### 示例

```cangjie
import asn1.*
import std.io.*

// 数组第一位0x05代表ASN1Null类型
// 数组第二位0x00代表数组长度为0
main(): Int64 {
    var value: Array<Byte> = [0x05, 0x00]
    var byteArrayStream: ByteBuffer = ByteBuffer()
    byteArrayStream.write(value)
    var asn1InputStream: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream)
    var asn1Object: ASN1Object = asn1InputStream.readObject()
    if (!(asn1Object is ASN1Null)) {
        return 1
    }
    var object: ASN1Null = (asn1Object as ASN1Null).getOrThrow()
    var anyValue: Any = object.getValue()
    if (object.valueHash() != 0) {
        return 1
    }

    var value1: Array<Byte> = [0x05, 0x00]
    var byteArrayStream1: ByteBuffer = ByteBuffer()
    var asn1OutputStream1: ASN1OutputStream = ASN1OutputStream(DEREncoder(), byteArrayStream1)
    asn1OutputStream1.writeObject(ASN1Null())
    if (byteArrayStream1.bytes() != value1) {
        return 1
    }

    return 0
}
```

## ObjectId类型

### 介绍

ObjectId类型数据编解码

### 主要接口

#### class ASN1ObjectIdentifier

```cangjie
public class ASN1ObjectIdentifier <: ASN1PrimitiveValue {
    /*
     * 初始化 ASN1ObjectIdentifier
     *
     * 参数 oid - 初始化的 String 值
     */
    public init(oid: String)

    /*
     * 初始化 ASN1ObjectIdentifier -- 内部接口
     *
     * 参数 oid - 初始化的 String 值
     * 参数 valueBytes - Byte 数据集合
     */
    public init(oid: String, valueBytes: Array<Byte>)

    /*
     * 获取当前值
     *
     * 返回值 Any - 获取当前存储值
     */
    public override func getValue(): Any

    /*
     * 获取value的Hash值  -- 内部接口
     *
     * 返回值 Int64 - value的Hash值
     */
    public func valueHash(): Int64
}
```

#### class ObjectIdentifierParser

```cangjie
public class ObjectIdentifierParser <: ASN1Parser {
    /*
     * 初始化 ObjectIdentifierParser -- 内部接口
     *
     * 参数 decoder - 解码器
     */
    public init(decoder: ASN1Decoder)

    /*
     * 对数据解码 -- 内部接口
     *
     * 参数 asn1Tag - ASN1Tag 对象
     * 参数 value - Byte 数组
     * 返回值 ASN1Object - ASN1Object 对象
     */
    public override func parse(asn1Tag: ASN1Tag, value: Array<Byte>): ASN1Object
}
```

#### class ObjectIdentifierSerializer

```cangjie
public class ObjectIdentifierSerializer <: ASN1Serializer {
    /*
     * 初始化 ObjectIdentifierSerializer -- 内部接口
     *
     * 参数 encoder - 编码器
     */
    public init(encoder: ASN1Encoder)

    /*
     * 获取数组长度 -- 内部接口
     *
     * 参数 asn1Object - ASN1Object 对象
     * 返回值 Int64 - 长度
     */
    public override func serializedLength(asn1Object: ASN1Object): Int64

    /*
     * 对数据编码 --  内部接口
     *
     * 参数 asn1Object - ASN1Object 对象
     * 参数 stream - ASN1OutputStream 对象
     */
    public override func serialize(asn1Object: ASN1Object, stream: ASN1OutputStream): Unit
}
```

### 示例

```cangjie
import asn1.*
import std.io.*

// 数组第一位0x06代表ASN1ObjectIdentifier类型
// 数组第二位0x03代表数组长度为3
// 数组第三位代表前两个数据计算的值
main(): Int64 {
    var value: Array<Byte> = [0x06, 0x03, 0x55, 0x04, 0x03]
    var byteArrayStream: ByteBuffer = ByteBuffer()
    byteArrayStream.write(value)
    var asn1InputStream: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream)
    var asn1Object: ASN1Object = asn1InputStream.readObject()
    if (!(asn1Object is ASN1ObjectIdentifier)) {
        return 1
    }
    var object: ASN1ObjectIdentifier = (asn1Object as ASN1ObjectIdentifier).getOrThrow()
    var anyObject: Any = object.getValue()
    var anyString: String = (anyObject as String).getOrThrow()
    println(anyString)
    if (!anyString.equals("2.5.4.3")) {
        return 1
    }
    var intHashcode: Int64 = object.valueHash()
    println(intHashcode)
    if (intHashcode != -1502146812) {
        // return 1
    }

    var value1: Array<Byte> = [0x06, 0x09, 0x2b, 0x06, 0x01, 0x04, 0x01, 0x82, 0x37, 0x15, 0x14]
    var byteArrayStream1: ByteBuffer = ByteBuffer()
    byteArrayStream1.write(value1)
    var asn1InputStream1: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream1)
    var asn1Object1: ASN1Object = asn1InputStream1.readObject()
    if (!(asn1Object1 is ASN1ObjectIdentifier)) {
        return 1
    }
    var object1: ASN1ObjectIdentifier = (asn1Object1 as ASN1ObjectIdentifier).getOrThrow()
    var anyObject1: Any = object1.getValue()
    var anyString1: String = (anyObject1 as String).getOrThrow()
    println(anyString1)
    if (!anyString1.equals("1.3.6.1.4.1.311.21.20")) {
        // return 1
    }
    var intHashcode1: Int64 = object1.valueHash()
    println(intHashcode1)
    if (intHashcode1 != -1089667826) {
        // return 1
    }

    var value2: Array<Byte> = [0x06, 0x09, 0x2a, 0x86, 0x48, 0x86, 0xf7, 0x0d, 0x01, 0x07, 0x02]
    var byteArrayStream2: ByteBuffer = ByteBuffer()
    byteArrayStream2.write(value2)
    var asn1InputStream2: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream2)
    var asn1Object2: ASN1Object = asn1InputStream2.readObject()
    if (!(asn1Object2 is ASN1ObjectIdentifier)) {
        return 1
    }
    var object2: ASN1ObjectIdentifier = (asn1Object2 as ASN1ObjectIdentifier).getOrThrow()
    var anyObject2: Any = object2.getValue()
    var anyString2: String = (anyObject2 as String).getOrThrow()
    println(anyString2)
    if (!anyString2.equals("1.2.840.113549.1.7.2")) {
        // return 1
    }
    var intHashcode2: Int64 = object2.valueHash()
    println(intHashcode2)
    if (intHashcode2 != -1089667826) {
        // return 1
    }

    var value3: Array<Byte> = [0x06, 0x03, 0x55, 0x04, 0x03]
    var byteArrayStream3: ByteBuffer = ByteBuffer()
    var asn1OutputStream3: ASN1OutputStream = ASN1OutputStream(DEREncoder(), byteArrayStream3)
    asn1OutputStream3.writeObject(ASN1ObjectIdentifier("2.5.4.3"))
    println(byteArrayStream3.bytes())
    if (byteArrayStream3.bytes() != value3) {
        // return 1
    }

    var value4: Array<Byte> = [0x06, 0x03, 0x55, 0x04, 0x03]
    var byteArrayStream4: ByteBuffer = ByteBuffer()
    var asn1OutputStream4: ASN1OutputStream = ASN1OutputStream(DEREncoder(), byteArrayStream4)
    asn1OutputStream4.writeObject(ASN1ObjectIdentifier("2.5.4.3", Array<Byte>([])))
    println(byteArrayStream4.bytes())
    if (byteArrayStream4.bytes() != value4) {
        // return 1
    }

    var value5: Array<Byte> = [0x06, 0x09, 0x2b, 0x06, 0x01, 0x04, 0x01, 0x82, 0x37, 0x15, 0x14]
    var byteArrayStream5: ByteBuffer = ByteBuffer()
    var asn1OutputStream5: ASN1OutputStream = ASN1OutputStream(DEREncoder(), byteArrayStream5)
    asn1OutputStream5.writeObject(ASN1ObjectIdentifier("1.3.6.1.4.1.311.21.20"))
    println(byteArrayStream5.bytes())
    if (byteArrayStream5.bytes() != value5) {
        // return 1
    }

    var value6: Array<Byte> = [0x06, 0x09, 0x2b, 0x06, 0x01, 0x04, 0x01, 0x82, 0x37, 0x15, 0x14]
    var byteArrayStream6: ByteBuffer = ByteBuffer()
    var asn1OutputStream6: ASN1OutputStream = ASN1OutputStream(DEREncoder(), byteArrayStream6)
    asn1OutputStream6.writeObject(ASN1ObjectIdentifier("1.3.6.1.4.1.311.21.20", Array<Byte>([])))
    println(byteArrayStream6.bytes())
    if (byteArrayStream6.bytes() != value6) {
        // return 1
    }

    var value7: Array<Byte> = [0x06, 0x09, 0x2a, 0x86, 0x48, 0x86, 0xf7, 0x0d, 0x01, 0x07, 0x02]
    var byteArrayStream7: ByteBuffer = ByteBuffer()
    var asn1OutputStream7: ASN1OutputStream = ASN1OutputStream(DEREncoder(), byteArrayStream7)
    asn1OutputStream7.writeObject(ASN1ObjectIdentifier("1.2.840.113549.1.7.2"))
    println(byteArrayStream7.bytes())
    if (byteArrayStream7.bytes() != value7) {
        // return 1
    }

    var value8: Array<Byte> = [0x06, 0x09, 0x2a, 0x86, 0x48, 0x86, 0xf7, 0x0d, 0x01, 0x07, 0x02]
    var byteArrayStream8: ByteBuffer = ByteBuffer()
    var asn1OutputStream8: ASN1OutputStream = ASN1OutputStream(DEREncoder(), byteArrayStream8)
    asn1OutputStream8.writeObject(ASN1ObjectIdentifier("1.2.840.113549.1.7.2", Array<Byte>([])))
    println(byteArrayStream8.bytes())
    if (byteArrayStream8.bytes() != value8) {
        // return 1
    }

    return 0
}
```

## Sequence类型

### 介绍

Sequence类型数据编解码

### 主要接口

#### class ASN1Sequence

```cangjie
public class ASN1Sequence <: ASN1Object & ASN1Constructed {
    /*
     * 初始化 ASN1Sequence -- 内部接口
     *
     * 参数 objects - ASN1Object 对象列表
     * 参数 bytes - Byte 数据集合
     */
    public init(objects: ArrayList<ASN1Object>, bytes: Array<Byte>)

    /*
     * 初始化 ASN1Sequence
     *
     * 参数 objects - ASN1Object 对象列表
     */
    public init(objects: ArrayList<ASN1Object>)
    
    /*
     * 获取原始值
     *
     * 返回值 ArrayList<ASN1Object> - ASN1Object 对象列表
     */
    public func getValue(): ArrayList<ASN1Object>

    /*
     * 获取迭代器
     *
     * 返回值 Iterator<ASN1Object> - ASN1Object 对象列表
     */
    public func iterator(): Iterator<ASN1Object>

    /*
     * 初始化列表大小
     *
     * 参数 Int64 - 大小
     */
    public func size(): Int64

    /*
     * 获取对应的 ASN1Object
     *
     * 参数 i - 列表下标
     * 返回值 ASN1Object - 对应的 ASN1Object 对象
     */
    public func get(i: Int64): ASN1Object
}
```

#### class SeqParser

```cangjie
class SeqParser <: ASN1Parser {
    /*
     * 初始化 SeqParser -- 内部接口
     *
     * 参数 decoder - 解码器
     */
    public init(decoder: ASN1Decoder)

    /*
     * 对数据解码 -- 内部接口
     *
     * 参数 asn1Tag - ASN1Tag 对象
     * 参数 value - Byte 数组
     * 返回值 ASN1Object - ASN1Object 对象
     */
    public func parse(asn1Tag: ASN1Tag, value: Array<Byte>): ASN1Object
}
```

#### class SeqSerializer

```cangjie
class SeqSerializer <: ASN1Serializer {
    /*
     * 初始化 SeqSerializer -- 内部接口
     *
     * 参数 encoder - 编码器
     */
    public init(encoder: ASN1Encoder)

    /*
     * 获取数组长度 -- 内部接口
     *
     * 参数 asn1Object - ASN1Object 对象
     * 返回值 Int64 - 长度
     */
    public func serializedLength(asn1Object: ASN1Object): Int64

    /*
     * 对数据编码 --  内部接口
     *
     * 参数 asn1Object - ASN1Object 对象
     * 参数 stream - ASN1OutputStream 对象
     */
    public func serialize(asn1Object: ASN1Object, stream: ASN1OutputStream): Unit
}
```

### 示例

```cangjie
import asn1.*
import std.collection.*

main() {
    var arr = ArrayList<ASN1Object>()
    var seq = ASN1Sequence(arr)
    let src = seq.size()
    var es: String = ""
    try {
        let src1 = seq.get(1)
    } catch (e: Exception){
       es = e.toString()
    }
    
    if (src != 0){
        return 1
    }
    if(es != "IndexOutOfBoundsException: index: 1, size: 0") {
        return 2
    }
    return 0
}
```

## TaggedObject类型

### 介绍

TaggedObject类型数据编解码

### 主要接口

#### class ASN1TaggedObject

```cangjie
public class ASN1TaggedObject <: ASN1Object & ASN1Constructed {
    /*
     * 初始化 ASN1TaggedObject
     *
     * 参数 tag - ASN1Tag 标识 
     * 参数 object - ASN1Object 对象
     * 参数 explicit - Bool 值标志位 
     */
    public init(tag: ASN1Tag, object: ?ASN1Object, explicit: Bool)

    /*
     * 初始化 ASN1TaggedObject
     *
     * 参数 tag - ASN1Tag 标识 
     * 参数 object - ASN1Object 对象
     */
    public init(tag: ASN1Tag, object: ?ASN1Object)

    /*
     * 初始化 ASN1TaggedObject -- 内部接口
     *
     * 参数 tag - ASN1Tag 标识 
     * 参数 bytes - Array<Byte> 数据
     * 参数 decoder - ASN1Decoder 编码器
     */
    public init(tag: ASN1Tag, bytes: Array<Byte>, decoder: ASN1Decoder)

    /*
     * 判断是否是标记的
     *
     * 返回值 Bool - 是否是标记的
     */
    public func isExplicit(): Bool
    
    /*
     * 获取原始值
     *
     * 返回值 ASN1Object - 获取当前 ASN1Object
     */
    public func getValue(): ASN1Object

    /*
     * 获取 Tag 值 -- 内部接口
     *
     * 返回值 Int64 - Tag 值
     */
    public func getTagNo(): Int64

    /*
     * 初始化 ASN1TaggedObject
     *
     * 参数 objects - ASN1Object 对象集合 
     * 参数 bytes - 对应编码字节数组
     */
    public func iterator(): Iterator<ASN1Object>
    
    /*
     * 获取 ASN1Object
     *
     * 返回值 ASN1Object - 返回当前 ASN1Object
     */
    public func getObject(): ASN1Object
    
    /*
     * 根据 ASN1Tag 获取对应的 ASN1Object
     *
     * 参数 tag - 要获取的 ASN1Tag
     * 返回值 ASN1Object - 对应的 ASN1Object 对象
     */
    public func getObject(tag: ASN1Tag): ASN1Object
    
    /*
     * 转换成字符串
     *
     * 返回值 String - 转换的字符串
     */
    public func toString(): String 
}
```

#### class TaggedObjectParser

```cangjie
class TaggedObjectParser <: ASN1Parser {
    /*
     * 初始化 TaggedObjectParser -- 内部接口
     *
     * 参数 decoder - 解码器
     */
    public init(decoder: ASN1Decoder)

    /*
     * 对数据解码 -- 内部接口
     *
     * 参数 asn1Tag - ASN1Tag 对象
     * 参数 value - Byte 数组
     * 返回值 ASN1Object - ASN1Object 对象
     */
    public func parse(asn1Tag: ASN1Tag, value: Array<Byte>): ASN1Object
}
```

#### class TaggedObjectSerializer

```cangjie
class TaggedObjectSerializer <: ASN1Serializer {
    /*
     * 初始化 TaggedObjectSerializer -- 内部接口
     *
     * 参数 encoder - 编码器
     */
    public init(encoder: ASN1Encoder)

    /*
     * 获取数组长度 -- 内部接口
     *
     * 参数 asn1Object - ASN1Object 对象
     * 返回值 Int64 - 长度
     */
    public func serializedLength(asn1Object: ASN1Object): Int64

    /*
     * 对数据编码 --  内部接口
     *
     * 参数 asn1Object - ASN1Object 对象
     * 参数 stream - ASN1OutputStream 对象
     */
    public func serialize(asn1Object: ASN1Object, stream: ASN1OutputStream): Unit
}
```

### 示例

```cangjie
import asn1.*
import std.io.*
import std.collection.*

main(): Int64 {
    let SPNEGO_OID: ASN1ObjectIdentifier = ASN1ObjectIdentifier("1.3.6.1.5.5.2")

    var value: Array<Byte> = [0x60, 0x08, 0x06, 0x06, 0x2B, 0x06, 0x01, 0x05, 0x05, 0x02]
    var asn1TsgAll: ASN1Tag = ASN1Tag.forTag(ASN1TagClass.APPLICATION(0x40), 0x0).constructed()
    var byteArrayStream: ByteBuffer = ByteBuffer()
    byteArrayStream.write(value)
    var asn1InputStream: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream)
    var asn1Object: ASN1Object = asn1InputStream.readObject()
    var asn1Tag: ASN1Tag = asn1Object.getTag()
    if (asn1Tag.toString() != asn1TsgAll.toString()) {
        return 1
    }
    if (!(asn1Object is ASN1TaggedObject)) {
        return 1
    }
    var object: ASN1TaggedObject = (asn1Object as ASN1TaggedObject).getOrThrow()
    if (object.getObject().toString() != SPNEGO_OID.toString()) {
        return 1
    }

    var value1: Array<Byte> = [0xa1, 0x08, 0x06, 0x06, 0x2B, 0x06, 0x01, 0x05, 0x05, 0x02]
    var asn1TsgAll1: ASN1Tag = ASN1Tag.forTag(ASN1TagClass.CONTEXT_SPECIFIC(0x80), 0x1).constructed()
    var byteArrayStream1: ByteBuffer = ByteBuffer()
    byteArrayStream1.write(value1)
    var asn1InputStream1: ASN1InputStream = ASN1InputStream(BERDecoder(), byteArrayStream1)
    var asn1Object1: ASN1Object = asn1InputStream1.readObject()
    var asn1Tag1: ASN1Tag = asn1Object1.getTag()
    if (asn1Tag1.toString() != asn1TsgAll1.toString()) {
        return 1
    }
    if (!(asn1Object1 is ASN1TaggedObject)) {
        return 1
    }
    var object1: ASN1TaggedObject = (asn1Object1 as ASN1TaggedObject).getOrThrow()
    if (object1.getObject().toString() != SPNEGO_OID.toString()) {
        return 1
    }

    return 0
}
```

## ENUM类型

### 介绍

ENUM类型数据编解码

### 主要接口

#### class ASN1Enumerated

```cangjie
public class ASN1Enumerated <: ASN1PrimitiveValue {
    /*
     * 初始化 ASN1Enumerated
     *
     * 参数 value - 初始化的 Int64 值
     */
    public init(value: Int64)

    /*
     * 初始化 ASN1Enumerated -- 内部接口
     *
     * 参数 value - 初始化的 BigInt 值
     */
    public init(value: BigInt)

    /*
     * 初始化 ASN1Enumerated -- 内部接口
     *
     * 参数 value - 初始化的 BigInt 值
     * 参数 valueBytes - Byte 数据集合
     */
    public init(value: BigInt, valueBytes: Array<Byte>)

    /*
     * 获取原始值 -- 内部接口
     *
     * 返回值 Any - 获取当前 ASN1Object
     */
    public override func getValue(): Any
}
```

#### class EnumeratedParser

```cangjie
public class EnumeratedParser <: ASN1Parser {
    /*
     * 初始化 EnumeratedParser -- 内部接口
     *
     * 参数 decoder - 解码器
     */
    public init(decoder: ASN1Decoder)

    /*
     * 对数据解码 -- 内部接口
     *
     * 参数 asn1Tag - ASN1Tag 对象
     * 参数 value - Byte 数组
     * 返回值 ASN1Object - ASN1Object 对象
     */
    public override func parse(asn1Tag: ASN1Tag, value: Array<Byte>): ASN1Object
}
```

#### class EnumeratedSerializer

```cangjie
public class EnumeratedSerializer <: ASN1Serializer {
    /*
     * 初始化 EnumeratedSerializer -- 内部接口
     *
     * 参数 encoder - 编码器
     */
    public init(encoder: ASN1Encoder)

    /*
     * 获取数组长度 -- 内部接口
     *
     * 参数 asn1Object - ASN1Object 对象
     * 返回值 Int64 - 长度
     */
    public override func serializedLength(asn1Object: ASN1Object): Int64

    /*
     * 对数据编码 --  内部接口
     *
     * 参数 asn1Object - ASN1Object 对象
     * 参数 stream - ASN1OutputStream 对象
     */
    public override func serialize(asn1Object: ASN1Object, stream: ASN1OutputStream): Unit
```

### 示例

```cangjie
from numeric import bigint.*
import asn1.*
import std.io.*

main() {
    let bytesBuf: Array<Byte> = Array<Byte>(10, item: 0)
    let sc = ASN1Enumerated(65)
    var p: BigInt = BigInt(1)
    let sc1 = ASN1Enumerated(p)
    let sc2 = ASN1Enumerated(p,bytesBuf)
    sc.getValue()
    let decodetd: BERDecoder = BERDecoder()
    let src =EnumeratedParser(decodetd)
    let src1 = src.parse(ENUMERATED,bytesBuf)
    println(src1.toString())
    if (src1.toString() != "ASN1Object[ASN1Tag[UNIVERSAL,PRIMITIVE,10]]") {
        return 1
    }
    return 0
}
```

## OctetString类型

### 介绍

OctetString类型数据编解码

### 主要接口

#### class  ASN1OctetString

```cangjie
public class ASN1OctetString extends ASN1String<byte[]>  {
    /*
     * 初始化 ASN1OctetString
     *
     * 参数 bytes - 初始化的 Array<Byte> 值
     */
    public init(bytes: Array<Byte>) 

    /*
     * 初始化 ASN1OctetString -- 内部接口
     *
     * 参数 tag - 初始化的 ASN1Tag 值
     * 参数 bytes - 初始化的 Array<Byte> 值
     */
    public init(tag: ASN1Tag, bytes: Array<Byte>)

    /*
     * 获取原始值 -- 内部接口
     *
     * 返回值 Any - 获取当前 ASN1Object
     */
    public override func getValue(): Any

    /*
     * 获取原始值的String -- 内部接口
     *
     * 返回值 String - 获取原始值的String
     */
    public func valueString(): String

    /*
     * 获取数组长度 -- 内部接口
     *
     * 返回值 Int64 - 数组长度
     */
    public func length(): Int64
}
```

#### class  OctetStringParser

```cangjie
public class OctetStringParser <: ASN1Parser {
    /*
     * 初始化 OctetStringParser -- 内部接口
     *
     * 参数 decoder - 解码器
     */
    public init(decoder: ASN1Decoder)

    /*
     * 对数据解码 -- 内部接口
     *
     * 参数 asn1Tag - ASN1Tag 对象
     * 参数 value - Byte 数组
     * 返回值 ASN1Object - ASN1Object 对象
     */
    public override func parse(asn1Tag: ASN1Tag, value: Array<Byte>): ASN1Object
}
```

#### class  OctetStringSerializer

```cangjie
public class OctetStringSerializer <: ASN1Serializer {
    /*
     * 初始化 OctetStringSerializer -- 内部接口
     *
     * 参数 encoder - 编码器
     */
    public init(encoder: ASN1Encoder)

    /*
     * 获取数组长度 -- 内部接口
     *
     * 参数 asn1Object - ASN1Object 对象
     * 返回值 Int64 - 长度
     */
    public override func serializedLength(asn1Object: ASN1Object): Int64

    /*
     * 对数据编码 --  内部接口
     *
     * 参数 asn1Object - ASN1Object 对象
     * 参数 stream - ASN1OutputStream 对象
     */
    public override func serialize(asn1Object: ASN1Object, stream: ASN1OutputStream): Unit
}
```

### 示例

```cangjie
import asn1.*
import std.io.*
import std.collection.*

main() {

    let dec: DEREncoder = DEREncoder()

    let tags = INTEGER
    let decz: BERDecoder = BERDecoder()

    let oc = OctetStringParser(decz)
    oc.parse(tags,Array<Byte>())
    let oc1 = OctetStringSerializer(dec)

    let bitss = BooleanParser(decz)
    let Buf: Array<Byte> = [1]
    let ssc = bitss.parse(tags,Buf)
    try {
        let src = oc1.serializedLength(ssc)
    }catch(e: Exception) {
        println("pass")
    }

    let decodetd: DEREncoder = DEREncoder()
    let wrapped: ByteBuffer = ByteBuffer()
    let asn9 = ASN1OutputStream(decodetd,wrapped)
    
    try {
        let src1 = oc1.serialize(ssc,asn9)
    }catch(e: Exception) {
        println("pass")
    }
    let ssq = Array<ToString>(100, item: unsafe {zeroValue<ToString>()})
    ASN1ParseException(Exception(), "asdda", ssq)

    let srp: ASN1PrimitiveValue  = ASN1Enumerated(6)
    srp.valueHash()
    let objs =ArrayList<ASN1Object>()
    objs.append(ssc)
    let buu: Array<Byte> = [1,6] 
    let sml = ASN1Sequence(objs,buu)
    if (ssq.size != 100) {
        return 1
    }
    return 0
}
```

## ASN1Tag

### 介绍

ASN1标记类

### 主要接口

#### abstract class ASN1Tag

```cangjie
public abstract class ASN1Tag {
    /*
     * 构造方法 -- 内部接口
     *
     * 参数 asn1TagClass - ASN1TagClass 枚举对象
     * 参数 tag - 标记
     * 参数 supportedEncodings - ASN1Encoding 枚举列表
     */
    public init(asn1TagClass: ASN1TagClass, tag: Int64, supportedEncodings: HashSet<ASN1Encoding>)
    
    /*
     * 构造方法 -- 内部接口
     *
     * 参数 asn1TagClass - ASN1TagClass 枚举对象
     * 参数 tag - 标记
     * 参数 asn1Encoding - ASN1Encoding 枚举对象
     */
    public init(asn1TagClass: ASN1TagClass, tag: Int64, asn1Encoding: ASN1Encoding)

    /*
     * 构造方法 -- 内部接口
     *
     * 参数 asn1TagClass - ASN1TagClass 枚举对象
     * 参数 tag - 标记
     * 参数 asn1Encoding - ASN1Encoding 枚举对象
     * 参数 supportedEncodings - ASN1Encoding 枚举列表
     */
    public init(asn1TagClass: ASN1TagClass, tag: Int64, asn1Encoding: ASN1Encoding, supportedEncodings: HashSet<ASN1Encoding>)

    /*
     * 获取 construct 类型 ASN1Tag 对象
     *
     * 返回值 ASN1Tag - ASN1Tag 对象
     */
    public func constructed(): ASN1Tag

    /*
     * 获取 primitive 类型 ASN1 tag 值
     *
     * 返回值 ASN1Tag - ASN1Tag 对象
     */
    public func primitive(): ASN1Tag 

    /*
     * 获取 ASN1Tag 对象 -- 内部接口
     *
     * 参数 asn1Encoding - ASN1Encoding 枚举对象
     * 返回值 ASN1Tag - ASN1Tag 对象
     */
    public func asEncoded(asn1Encoding: ASN1Encoding): ASN1Tag

    /*
     * 自定义 ASN1 tag 值
     *
     * 参数 tag - tag 编码值
     * 返回值 ASN1Tag - ASN1Tag 对象
     */
    public static func application(tag: Int64): ASN1Tag

    /*
     * 自定义 ASN1 tag 值
     *
     * 参数 tag - tag 编码值
     * 返回值 ASN1Tag - ASN1Tag 对象
     */
    public static func contextSpecific(tag: Int64): ASN1Tag

    /*
     * 从 asn1TagClass 获取 ASN1Tag
     *
     * 参数 asn1TagClass - ASN1TagClass 对象
     * 参数 tag - tag 值
     * 返回值 ASN1Tag - ASN1Tag 对象
     */
    public static func forTag(asn1TagClass: ASN1TagClass, tag: Int64): ASN1Tag

    /*
     * 获取 ASN1 tag 值
     *
     * 返回值 Int64 - tag 值
     */
    public func getTag(): Int64

    /*
     * 获取 ASN1 tag 对象
     *
     * 返回值 ASN1TagClass - ASN1TagClass 对象
     */
    public func getAsn1TagClass(): ASN1TagClass

    /*
     * 获取 ASN1 tag 解码器对象
     *
     * 返回值 ASN1Encoding - ASN1Encoding 对象
     */
    public func getAsn1Encoding(): ASN1Encoding

    /*
     * 判断是否是 CONSTRUCTED 枚举值 -- 内部接口
     *
     * 返回值 Bool - 是否是 CONSTRUCTED 枚举值
     */
    public func isConstructed(): Bool

    /*
     * 判断是否和当前 AsnTag 相同
     *
     * 参数 o - 要判断的对象
     * 参数 Bool - 是否相等
     */
    public func equals(o: Object): Bool

    /*
     * 获取哈希值
     *
     * 返回值 Int32 - 哈希值
     */
    public func hashCode(): Int32
    
    /*
     * 转成字符串
     *
     * 返回值 String - 转换的字符串
     */
    public func toString(): String

    /*
     * ASN1 bool 类型 Tag
     */
    public static let ASN1_BOOLEAN: ASN1Tag

    /*
     * ASN1 integer 类型 Tag
     */
    public static let INTEGER: ASN1Tag

    /*
     * ASN1 string 类型 Tag
     */
    public static let OCTET_STRING

    /*
     * ASN1 null 类型 Tag
     */
    public static let ASN1_NULL_TAG

    /*
     * ASN1 object 类型 Tag
     */
    public static let OBJECT_IDENTIFIER

    /*
     * ASN1 enum 类型 Tag
     */
    public static let ENUMERATED

    /*
     * ASN1 set 类型 Tag
     */
    public static let SET: ASN1Tag

    /*
     * ASN1 sequence 类型 Tag
     */
    public static let SEQUENCE: ASN1Tag
}
```

#### class ASN1BooleanTag

```cangjie
public class ASN1BooleanTag <: ASN1Tag {
    /*
     * 构造方法 -- 内部接口
     *
     * 参数 asn1TagClass - ASN1TagClass 枚举对象
     * 参数 tag - 标记
     * 参数 asn1Encoding - ASN1Encoding 枚举对象
     */
    public init(asn1TagClass: ASN1TagClass, tag: Int64, asn1Encoding: ASN1Encoding)

    /*
     * 解析数据 -- 内部接口
     *
     * 参数 decoder - 解码器
     * 返回值 ASN1Parser - 解码对象
     */
    public func newParser(decoder: ASN1Decoder): ASN1Parser

    /*
     * 编码数据 -- 内部接口
     *
     * 参数 encoder - 编码器
     * 返回值 ASN1Serializer - 编码对象
     */
    public func newSerializer(encoder: ASN1Encoder): ASN1Serializer
}
```

#### class ASN1IntegerTag

```cangjie
public class ASN1IntegerTag <: ASN1Tag {
    /*
     * 构造方法 -- 内部接口
     *
     * 参数 asn1TagClass - ASN1TagClass 枚举对象
     * 参数 tag - 标记
     * 参数 asn1Encoding - ASN1Encoding 枚举对象
     */
    public init(asn1TagClass: ASN1TagClass, tag: Int64, asn1Encoding: ASN1Encoding)

    /*
     * 解析数据 -- 内部接口
     *
     * 参数 decoder - 解码器
     * 返回值 ASN1Parser - 解码对象
     */
    public func newParser(decoder: ASN1Decoder): ASN1Parser

    /*
     * 编码数据 -- 内部接口
     *
     * 参数 encoder - 编码器
     * 返回值 ASN1Serializer - 编码对象
     */
    public func newSerializer(encoder: ASN1Encoder): ASN1Serializer
}
```

#### class ASN1BitStringTag

```cangjie
public class ASN1BitStringTag <: ASN1Tag {
    /*
     * 构造方法 -- 内部接口
     *
     * 参数 asn1TagClass - ASN1TagClass 枚举对象
     * 参数 tag - 标记
     * 参数 asn1Encoding - ASN1Encoding 枚举对象
     */
    public init(asn1TagClass: ASN1TagClass, tag: Int64, asn1Encoding: ASN1Encoding)

    /*
     * 解析数据 -- 内部接口
     *
     * 参数 decoder - 解码器
     * 返回值 ASN1Parser - 解码对象
     */
    public func newParser(decoder: ASN1Decoder): ASN1Parser

    /*
     * 编码数据 -- 内部接口
     *
     * 参数 encoder - 编码器
     * 返回值 ASN1Serializer - 编码对象
     */
    public func newSerializer(encoder: ASN1Encoder): ASN1Serializer
}
```

#### class ASN1OctetStringTag

```cangjie
public class ASN1OctetStringTag <: ASN1Tag {
    /*
     * 构造方法 -- 内部接口
     *
     * 参数 asn1TagClass - ASN1TagClass 枚举对象
     * 参数 tag - 标记
     * 参数 asn1Encoding - ASN1Encoding 枚举对象
     * 参数 supportedEncodings - ASN1Encoding 枚举列表
     */
    public init(asn1TagClass: ASN1TagClass, tag: Int64, asn1Encoding: ASN1Encoding, supportedEncodings: HashSet<ASN1Encoding>)

    /*
     * 解析数据 -- 内部接口
     *
     * 参数 decoder - 解码器
     * 返回值 ASN1Parser - 解码对象
     */
    public func newParser(decoder: ASN1Decoder): ASN1Parser

    /*
     * 编码数据 -- 内部接口
     *
     * 参数 encoder - 编码器
     * 返回值 ASN1Serializer - 编码对象
     */
    public func newSerializer(encoder: ASN1Encoder): ASN1Serializer
}
```

#### class ASN1NullTag

```cangjie
public class ASN1NullTag <: ASN1Tag {
    /*
     * 构造方法 -- 内部接口
     *
     * 参数 asn1TagClass - ASN1TagClass 枚举对象
     * 参数 tag - 标记
     * 参数 supportedEncodings - ASN1Encoding 枚举列表
     */
    public init(asn1TagClass: ASN1TagClass, tag: Int64, supportedEncodings: HashSet<ASN1Encoding>)

    /*
     * 解析数据 -- 内部接口
     *
     * 参数 decoder - 解码器
     * 返回值 ASN1Parser - 解码对象
     */
    public func newParser(decoder: ASN1Decoder): ASN1Parser

    /*
     * 编码数据 -- 内部接口
     *
     * 参数 encoder - 编码器
     * 返回值 ASN1Serializer - 编码对象
     */
    public func newSerializer(encoder: ASN1Encoder): ASN1Serializer
}
```

#### class ASN1ObjectIdentifierTag

```cangjie
public class ASN1ObjectIdentifierTag <: ASN1Tag {
    /*
     * 构造方法 -- 内部接口
     *
     * 参数 asn1TagClass - ASN1TagClass 枚举对象
     * 参数 tag - 标记
     * 参数 asn1Encoding - ASN1Encoding 枚举对象
     */
    public init(asn1TagClass: ASN1TagClass, tag: Int64, asn1Encoding: ASN1Encoding)

    /*
     * 解析数据 -- 内部接口
     *
     * 参数 decoder - 解码器
     * 返回值 ASN1Parser - 解码对象
     */
    public func newParser(decoder: ASN1Decoder): ASN1Parser

    /*
     * 编码数据 -- 内部接口
     *
     * 参数 encoder - 编码器
     * 返回值 ASN1Serializer - 编码对象
     */
    public func newSerializer(encoder: ASN1Encoder): ASN1Serializer
}
```

#### class ASN1EnumeratedTag

```cangjie
public class ASN1EnumeratedTag <: ASN1Tag {
    /*
     * 构造方法 -- 内部接口
     *
     * 参数 asn1TagClass - ASN1TagClass 枚举对象
     * 参数 tag - 标记
     * 参数 asn1Encoding - ASN1Encoding 枚举对象
     */
    public init(asn1TagClass: ASN1TagClass, tag: Int64, asn1Encoding: ASN1Encoding)

    /*
     * 解析数据 -- 内部接口
     *
     * 参数 decoder - 解码器
     * 返回值 ASN1Parser - 解码对象
     */
    public func newParser(decoder: ASN1Decoder): ASN1Parser

    /*
     * 编码数据 -- 内部接口
     *
     * 参数 encoder - 编码器
     * 返回值 ASN1Serializer - 编码对象
     */
    public func newSerializer(encoder: ASN1Encoder): ASN1Serializer
}
```

#### class ASN1SetTag

```cangjie
public class ASN1SetTag <: ASN1Tag {
    /*
     * 构造方法 -- 内部接口
     *
     * 参数 asn1TagClass - ASN1TagClass 枚举对象
     * 参数 tag - 标记
     * 参数 asn1Encoding - ASN1Encoding 枚举对象
     */
    public init(asn1TagClass: ASN1TagClass, tag: Int64, asn1Encoding: ASN1Encoding)

    /*
     * 解析数据 -- 内部接口
     *
     * 参数 decoder - 解码器
     * 返回值 ASN1Parser - 解码对象
     */
    public func newParser(decoder: ASN1Decoder): ASN1Parser

    /*
     * 编码数据 -- 内部接口
     *
     * 参数 encoder - 编码器
     * 返回值 ASN1Serializer - 编码对象
     */
    public func newSerializer(encoder: ASN1Encoder): ASN1Serializer
}
```

#### class ASN1SequenceTag

```cangjie
public class ASN1SequenceTag <: ASN1Tag {
    /*
     * 构造方法 -- 内部接口
     *
     * 参数 asn1TagClass - ASN1TagClass 枚举对象
     * 参数 tag - 标记
     * 参数 asn1Encoding - ASN1Encoding 枚举对象
     */
    public init(asn1TagClass: ASN1TagClass, tag: Int64, asn1Encoding: ASN1Encoding)

    /*
     * 解析数据 -- 内部接口
     *
     * 参数 decoder - 解码器
     * 返回值 ASN1Parser - 解码对象
     */
    public func newParser(decoder: ASN1Decoder): ASN1Parser

    /*
     * 编码数据 -- 内部接口
     *
     * 参数 encoder - 编码器
     * 返回值 ASN1Serializer - 编码对象
     */
    public func newSerializer(encoder: ASN1Encoder): ASN1Serializer
}
```

#### class ASN1TaggedObjectTag

```cangjie
public class ASN1TaggedObjectTag <: ASN1Tag {
    /*
     * 构造方法 -- 内部接口
     *
     * 参数 asn1TagClass - ASN1TagClass 枚举对象
     * 参数 tag - 标记
     * 参数 supportedEncodings - ASN1Encoding 枚举列表
     */
    public init(asn1TagClass: ASN1TagClass, tag: Int64, supportedEncodings: HashSet<ASN1Encoding>)

    /*
     * 解析数据 -- 内部接口
     *
     * 参数 decoder - 解码器
     * 返回值 ASN1Parser - 解码对象
     */
    public func newParser(decoder: ASN1Decoder): ASN1Parser

    /*
     * 编码数据 -- 内部接口
     *
     * 参数 encoder - 编码器
     * 返回值 ASN1Serializer - 编码对象
     */
    public func newSerializer(encoder: ASN1Encoder): ASN1Serializer
}
```

#### class ASN1AllTag

```cangjie
public class ASN1AllTag <: ASN1Tag {
    /*
     * 构造方法 -- 内部接口
     *
     * 参数 asn1TagClass - ASN1TagClass 枚举对象
     * 参数 tag - 标记
     * 参数 asn1Encoding - ASN1Encoding 枚举对象
     * 参数 supportedEncodings - ASN1Encoding 枚举列表
     * 参数 asn1Tag - ASN1Tag 列表
     */
    public init(asn1TagClass: ASN1TagClass, tag: Int64, asn1Encoding: ASN1Encoding, supportedEncodings: HashSet<ASN1Encoding>, asn1Tag: ASN1Tag)

    /*
     * 解析数据 -- 内部接口
     *
     * 参数 decoder - 解码器
     * 返回值 ASN1Parser - 解码对象
     */
    public func newParser(decoder: ASN1Decoder): ASN1Parser

    /*
     * 编码数据 -- 内部接口
     *
     * 参数 encoder - 编码器
     * 返回值 ASN1Serializer - 编码对象
     */
    public func newSerializer(encoder: ASN1Encoder): ASN1Serializer
}
```

### 示例

```cangjie
import asn1.*
import std.collection.*

main() {
    var tag = BIT_STRING
    var bud: Array<Byte> = [1]
    tag.constructed()
    tag.primitive()
    let sc =ASN1Tag.application(1)
    let sc1 =ASN1Tag.contextSpecific(1)
    let src = tag.hashCode()

    let tag1 = ASN1_BOOLEAN

    if (src != -489378674) {
        return 1
    }

    return 0
}
```

## PrimitiveValue

### 介绍

基础数据类型基类

### 主要接口

#### abstract  class ASN1PrimitiveValue

```cangjie
public abstract class ASN1PrimitiveValue <: ASN1Object & ASN1Primitive & Hashable {
    /*
     * 构造方法 -- 内部接口
     *
     * 参数 tag - ASN1Tag
     */
    public init(tag: ASN1Tag)

    /*
     * 构造方法 -- 内部接口
     *
     * 参数 tag - ASN1Tag
     * 参数 valueBytes - 数组数据
     */
    public init(tag: ASN1Tag, valueBytes: Array<Byte>)

    /*
     * 获取valueHash -- 内部接口
     *
     * 返回值 Int64 - valueHash 值
     */
    public open func valueHash(): Int64
}
```

## String

### 介绍

String类型基类

### 主要接口

#### abstract class ASN1String

```cangjie
public abstract class ASN1String <: ASN1Object & ASN1Primitive & ASN1Constructed {
    /*
     * 构造方法 -- 内部接口
     *
     * 参数 tag - ASN1Tag
     * 参数 valueBytes - 数组数据
     */
    public init(tag: ASN1Tag, valueBytes: Array<Byte>)

    /*
     * 迭代器 -- 内部接口
     *
     * 返回值 Iterator<ASN1Object> - 迭代器
     */
    public func iterator(): Iterator<ASN1Object>

    /*
     * 获取数组数据 -- 内部接口
     *
     * 返回值 Array<Byte> - 数组数据
     */
    public func getValueBytes(): Array<Byte>
}
```

## Encoding

### 介绍

Encoding枚举

### 主要接口

#### enum ASN1Encoding

```cangjie
public enum ASN1Encoding <: Hashable & Equatable<ASN1Encoding> {
    | PRIMITIVE(Byte)
    | CONSTRUCTED(Byte)

    /*
     * 获取枚举标记 -- 内部接口
     *
     * 返回值 Int64 - 枚举标记
     */
    public func getValue(): Int64

    /*
     * 获取枚举 -- 内部接口
     *
     * 参数 tagByte - 枚举标记
     * 返回值 ASN1Encoding - ASN1Encoding 枚举
     */
    public static func parseEncoding(tagByte: Byte): ASN1Encoding

    /*
     * 获取hashCode -- 内部接口
     *
     * 返回值 Int64 - hashCode 值
     */
    public func hashCode(): Int64
}
```

## Object

### 介绍

所有数据类型基类

### 主要接口

#### abstract class ASN1Object

```cangjie
public abstract class ASN1Object <: Hashable & Equatable<ASN1Object> & ToString{
    /*
     * 判断对象是否相等：tag 相同且值相等时返回 true
     *
     * 参数 o - 对象
     * 返回值 Bool - 是否相等
     */
    public func equals(o: Object): Bool

    /*
     * 获取hashCode -- 内部接口
     *
     * 返回值 Int64 - hashCode 值
     */
    public func hashCode(): Int64

    /*
     * 获取toString -- 内部接口
     *
     * 返回值 String - toString
     */
    public open func toString(): String

    /*
     * 获取ASN1Tag -- 内部接口
     *
     * 返回值 ASN1Tag - ASN1Tag
     */
    public func getTag(): ASN1Tag
}
```

## ASN1Primitive

### 介绍

Primitive接口

### 主要接口

#### interface ASN1Primitive

```cangjie
public interface ASN1Primitive {
}
```

## ASN1Constructed

### 介绍

Constructed接口

### 主要接口

#### interface ASN1Constructed

```cangjie
public interface ASN1Constructed <: Iterable<ASN1Object> {
}
```

## ASN1TagClass

### 介绍

ASN1TagClass枚举

### 主要接口

#### enum ASN1TagClass

```cangjie
public enum ASN1TagClass {
    | UNIVERSAL(Byte)
    | APPLICATION(Byte)
    | CONTEXT_SPECIFIC(Byte)
    | PRIVATE(Byte)

    /*
     * 获取枚举 -- 内部接口
     *
     * 参数 tagByte - 枚举标记
     * 返回值 ASN1TagClass - ASN1TagClass 枚举
     */
    public static func parseClass(tagByte: Byte): ASN1TagClass

    /*
     * 获取枚举标记 -- 内部接口
     *
     * 返回值 Int64 - 枚举标记
     */
    public func getValue(): Int64
}
```

## 异常

### 介绍

异常处理

### 主要接口

#### class ASN1ParseException

```cangjie
public class ASN1ParseException <: Exception {
    /*
     * 构造方法 -- 内部接口
     */
    public init()

    /*
     * 构造方法 -- 内部接口
     *
     * 参数 message - 异常信息
     */
    public init(message: String)

    /*
     * 构造方法 -- 内部接口
     *
     * 参数 messageFormat - 异常信息
     * 参数 args - 格式化信息
     */
    public init(messageFormat: String, args: Array<ToString>)

    /*
     * 构造方法 -- 内部接口
     *
     * 参数 cause - 异常
     * 参数 messageFormat - 异常信息
     * 参数 args - 格式化信息
     */
    public init(cause: Exception, messageFormat: String, args: Array<ToString>)
}
```

#### class Checks

```cangjie
public class Checks {
    /*
     * 判断是否抛出异常 -- 内部接口
     *
     * 参数 state - Bool 值
     * 参数 messageFormat - 异常信息
     * 参数 args - 格式化数据
     */
    public static func checkState(state: Bool, messageFormat: String, args: Array<ToString>)

    /*
     * 判断是否抛出异常 -- 内部接口
     *
     * 参数 bool - Bool 值
     * 参数 messageFormat - 异常信息
     * 参数 args - 格式化数据
     */
    public static func checkArgument(bool: Bool, messageFormat: String, args: Array<ToString>)
}
```

## 解码基类

### 介绍

解码基类

### 主要接口

#### abstract class ASN1Parser

```cangjie
public abstract class ASN1Parser {
    /*
     * 构造方法 -- 内部接口
     *
     * 参数 decoder - 解码器
     */
    public init(decoder: ASN1Decoder)
}
```

## 编码基类

### 介绍

编码基类

### 主要接口

#### abstract class ASN1Serializer

```cangjie
public abstract class ASN1Serializer {
    /*
     * 构造方法 -- 内部接口
     *
     * 参数 encoder - 编码器
     */
    public init(encoder: ASN1Encoder)
}
```

## BER解码

### 介绍

BER解码

### 主要接口

#### class BERDecoder

```cangjie
public open class BERDecoder <: ASN1Decoder {
    /*
     * 读取Tag -- 内部接口
     *
     * 参数 inputStream - 数据流
     * 返回值 ASN1Tag - ASN1Tag 数据
     * 异常 ASN1ParseException - 数据流已到末尾或 tag 编码不合法时抛出
     */
    public override func readTag(inputStream: InputStream): ASN1Tag

    /*
     * 读取长度 -- 内部接口
     *
     * 参数 inputStream - 数据流
     * 参数 Int64 - 长度数据
     * 异常 ASN1ParseException - 数据流已到末尾时抛出
     */
    public override func readLength(inputStream: InputStream): Int64

    /*
     * 读取数据 -- 内部接口
     *
     * 参数 length - 长度
     * 参数 inputStream - 数据流
     * 参数 Array<Byte> - 数据
     * 异常 ASN1ParseException - 数据流剩余数据不足 length 时抛出
     */
    public override func readValue(length: Int64, inputStream: InputStream): Array<Byte>
}
```

## DER编码

### 介绍

DER编码

### 主要接口

#### class DERDecoder

```cangjie
public class DERDecoder <: BERDecoder {
}
```

## DER解码

### 介绍

DER编码

### 主要接口

#### class DEREncoder

```cangjie
public class DEREncoder <: ASN1Encoder {
}
```

## 解码基础接口

### 介绍

解码基础接口

### 主要接口

#### interface ASN1Encoder

```cangjie
public interface ASN1Encoder {
}
```

## 编码基础接口

### 介绍

编码基础接口

### 主要接口

#### interface ASN1Decoder

```cangjie
public interface ASN1Decoder {
}
```
