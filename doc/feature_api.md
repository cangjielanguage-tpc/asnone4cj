## asn-one 库

### 介绍

ASN-one 是 ASN.1 编码器和解码器的实现。它支持字节流的 BER 和 DER 编码规则。

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
     * 写入数据长度
     *
     * 参数 b - 数据长度
     */
    public func write(b: Int64): Unit
}
```

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
     */
    public func readObject(): ASN1Object 

    /*
     * 读取当前值
     *
     * 参数 length - 数据长度
     * 参数 Array<Byte>  - 读取到的数组数据
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
     */
    public func readTag(): ASN1Tag

    /*
     * 获取 ASN1 数据长度
     *
     * 参数 Int64 - 数据数据
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
|
```

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

#### abstract class ASN1Object

```cangjie
public abstract class ASN1Object <: Hashable & Equatable<ASN1Object> & ToString{
    /*
     * 对象是否相等 -- 内部接口
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

#### interface ASN1Primitive

```cangjie
public interface ASN1Primitive {
}
```

#### interface ASN1Constructed

```cangjie
public interface ASN1Constructed <: Iterable<ASN1Object> {
}
```

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

#### class BERDecoder

```cangjie
public open class BERDecoder <: ASN1Decoder {
    /*
     * 读取Tag -- 内部接口
     *
     * 参数 inputStream - 数据流
     * 返回值 ASN1Tag - ASN1Tag 数据
     */
    public override func readTag(inputStream: InputStream): ASN1Tag

    /*
     * 读取长度 -- 内部接口
     *
     * 参数 inputStream - 数据流
     * 参数 Int64 - 长度数据
     */
    public override func readLength(inputStream: InputStream): Int64

    /*
     * 读取数据 -- 内部接口
     *
     * 参数 length - 长度
     * 参数 inputStream - 数据流
     * 参数 Array<Byte> - 数据
     */
    public override func readValue(length: Int64, inputStream: InputStream): Array<Byte>
}
```

#### class DERDecoder

```cangjie
public class DERDecoder <: BERDecoder {
}
```

#### class DEREncoder

```cangjie
public class DEREncoder <: ASN1Encoder {
}
```

#### interface ASN1Encoder

```cangjie
public interface ASN1Encoder {
}
```

#### interface ASN1Decoder

```cangjie
public interface ASN1Decoder {
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

#### class DecoderUtils

```cangjie
public class DecoderUtils {
    /*
     * 将Array<Byte>转换成BigInt -- 内部接口
     *
     * 参数 value - Byte 数组数据
     * 返回值 BigInt - BigInt 数据
     */
    public static func asn1Decode(value: Array<Byte>): BigInt
}
```

#### class EncodingUtils

```cangjie
public class EncodingUtils {
    /*
     * 将BigInt转换成Array<Byte> -- 内部接口
     *
     * 参数 value - BigInt 值
     * 返回值 Array<Byte> - Byte 数组数据
     */
    public static func asn1Encoded(value: BigInt): Array<Byte>
}
```
