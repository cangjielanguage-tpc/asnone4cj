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

#### class  ASN1BitString

```cangjie
public class ASN1BitString <: ASN1String {
    /*
     * 初始化 ASN1BitString
     *
     * 参数 bits - 初始化的 Array<Bool> 值
     */
    public init(bits: Array<Bool>)

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

#### class ASN1Set

```cangjie
public class ASN1Set <: ASN1Object & ASN1Constructed {
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
     *  获取当前值
     *
     * 返回值 Any - 获取当前存储值
     */
    public func getValue(): Any
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
     * 参数 value - 初始化的 CPointer<BIGNUM> 值
     */
    public init(value: CPointer<BIGNUM>)

    /*
     *  获取当前值
     *
     * 返回值 Any - 获取当前存储值
     */
    public override func getValue(): Any
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
}
```

#### class ASN1ObjectIdentifier

```cangjie
public class ASN1ObjectIdentifier <: ASN1PrimitiveValue {
    /*
     * 初始化 ASN1ObjectIdentifier
     * 参数 oid - 初始化的 String 值
     */
    public init(oid: String)

    /*
     *  获取当前值
     *
     * 返回值 Any - 获取当前存储值
     */
    public override func getValue(): Any

}
```

#### class ASN1Sequence

```cangjie
public class ASN1Sequence <: ASN1Object & ASN1Constructed {
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
     * 初始化 ASN1TaggedObject
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

#### class ASN1Enumerated

```cangjie
public class ASN1Enumerated <: ASN1PrimitiveValue {
    /*
     * 初始化 ASN1Enumerated
     *
     * 参数 value - 初始化的 Int64 值
     */
    public init(value: Int64)
}
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
}
```

#### abstract class ASN1Tag

```cangjie
public abstract class ASN1Tag {
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

#### abstract  class ASN1PrimitiveValue

```cangjie
public abstract class ASN1PrimitiveValue <: ASN1Object & ASN1Primitive & Hashable
```

#### abstract class ASN1String

```cangjie
public abstract class ASN1String<T> extends ASN1Object<T> implements ASN1Primitive, ASN1Constructed
```

#### enum ASN1Encoding

```cangjie
public enum ASN1Encoding <: Hashable & Equatable<ASN1Encoding> {
    | PRIMITIVE(Byte)
    | CONSTRUCTED(Byte)
}
```

#### abstract class ASN1Object

```cangjie
public abstract class ASN1Object<T>
```

#### interface ASN1Primitive

```cangjie
public interface ASN1Primitive
```

#### enum ASN1TagClass

```cangjie
public enum ASN1TagClass {
    | UNIVERSAL(Byte)
    | APPLICATION(Byte)
    | CONTEXT_SPECIFIC(Byte)
    | PRIVATE(Byte)
}
```

#### class ASN1ParseException

```cangjie
public class ASN1ParseException <: Exception
```

#### abstract class ASN1Parser

```cangjie
public abstract class ASN1Parser
```

#### abstract class ASN1Serializer

```cangjie
public abstract class ASN1Serializer
```

#### class BERDecoder

```cangjie
public open class BERDecoder <: ASN1Decoder
```

#### class BERDecoder

```cangjie
public class DERDecoder <: BERDecoder
```

#### class DEREncoder

```cangjie
public class DEREncoder <: ASN1Encoder
```

#### interface ASN1Decoder

```cangjie
public interface ASN1Decoder
```

#### interface DEREncoder

```cangjie
public interface DEREncoder
```
