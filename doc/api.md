## asn-one 库

### 介绍
ASN-one 是 ASN.1 编码器和解码器的实现。它支持字节流的 BER 和 DER 编码规则。

### 主要接口

#### class BERDecoder

```cangjie
public open class BERDecoder <: ASN1Decoder {
    /*
     * 读取 asn1 标签
     *
     * 参数 inputStream - 数据输入流
     * 返回值 ASN1Tag - 读取到的 asn1 标签
     */
    public override func readTag(inputStream: InputStream): ASN1Tag

    /*
     * 读取 asn1 数据长度
     *
     * 参数 inputStream - 数据输入流
     * 返回值 Int64 - 数据长度
     */
    public override func readLength(inputStream: InputStream): Int64

    /*
     * 读取 asn1 数据
     *
     * 参数 length - 读取的长度
     * 参数 inputStream - 数据输入流
     * 返回值 Array<Byte> - 读取的数据
     */
    public override func readValue(length: Int64, inputStream: InputStream): Array<Byte>
}
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
public interface ASN1Decoder {
    /*
     * 读取 asn1 标签
     *
     * 参数 inputStream - 数据输入流
     * 返回值 ASN1Tag - 读取到的 asn1 标签
     */
    func readTag(inputStream: InputStream): ASN1Tag

     /*
     * 读取 asn1 数据长度
     *
     * 参数 inputStream - 数据输入流
     * 返回值 Int64 - 数据长度
     */
    func readLength(inputStream: InputStream): Int64
    
    /*
     * 读取 asn1 数据
     *
     * 参数 length - 读取的长度
     * 参数 inputStream - 数据输入流
     * 返回值 Array<Byte> - 读取的数据
     */
    func readValue(length: Int64, inputStream: InputStream): Array<Byte>
}
```

#### interface DEREncoder

```cangjie
public interface DEREncoder
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

#### class ASN1Set

```cangjie
public class ASN1Set <: ASN1Object & ASN1Constructed {
    /*
     * 初始化 ASN1Set
     *
     * 参数 objects - ASN1Object 对象列表
     */
    public init(objects: ArrayList<ASN1Object>)
    
    public init(objects: HashSet<ASN1Object>)

    public func getValue(): HashSet<ASN1Object>

    public func iterator(): Iterator<ASN1Object>
}
```
#### class ASN1TaggedObject

```cangjie
public class ASN1TaggedObject <: ASN1Object & ASN1Constructed {
    public init(tag: ASN1Tag, object: ?ASN1Object)
    public func isExplicit(): Bool
    public func getValue(): ASN1Object
    public func getTagNo(): Int64
    public func iterator(): Iterator<ASN1Object>
    public func getObject(): ASN1Object
    public func getObject(tag: ASN1Tag): ASN1Object
    public func toString(): String
}
```