# 三方库设计说明

## 1 需求场景分析

ASN-one 是 ASN.1 编码器和解码器的实现。它支持字节流的 BER 和 DER 编码规则。

## 2 三方库对外提供的特性

    （1）支持 Sequence，Set，Tagged 构造类型编解码
    （2）支持 Boolean，Enumerated，Integer，Null，ObjectIdentifier，PrimitiveValue 原始类型数据编解码
    （3）支持 BitString，Octet String，String 字符串类型编解码

## 3 License分析

    Apache-2.0

    |  Permissions   | Limitations  |
    |  ----  | ----  |
    | Commercial use |  Trademark use  |
    | Modification  |  Liability  |
    | Distribution  |  Warranty  |
    | Patent use  |   |
    | Private use   |   |

## 4 依赖分析

    依赖
    cangjie库：cryptocj

    使用其中BIGNUM大数功能

## 5 特性设计文档

### 5.1 ASN.1 输入输出流生成/解析/校验

#### 5.1.1 特性介绍

    外部操作的入口， ASN.1 输入输出流生成/解析/校验

#### 5.1.2 实现方案

##### ASN1InputStream

    public init(decoder: ASN1Decoder, value: Array<Byte>) //初始化
    public func readObject(): ASN1Object //获取 ASN1 类对象
    public func readValue(length: Int64): Array<Byte> //读取值域
    public func readTag(): ASN1Tag //读取 tag
    public func readLength(): Int64 //读取长度
    public override func read(buffer: Array<Byte>): Int64 // 读取原始值

##### ASN1OutputStream

    public init(encoder: ASN1Encoder, out: OutputStream) //初始化
    public func writeObject(asn1Object: ASN1Object): Unit //写入 ASN1  类对象
    public func write(b: Array<Byte>): Unit //写入数据
    public func write(b: Int64): Unit //初始化长度

### 5.2 ASN,1 BER 编解码规则

#### 5.2.1 特性介绍

    基本编码规则（BER）

#### 5.2.2 实现方案

    标识域（tag）编码 ：
    BER_TYPE_BOOLEAN				0x01
    BER_TYPE_INTEGER				0x02
    BER_TYPE_BIT_STRING				0x03
    BER_TYPE_OCTET_STRING				0x04
    BER_TYPE_NULL					0x05
    BER_TYPE_OID					0x06
    BER_TYPE_SEQUENCE				0x30
    BER_TYPE_COUNTER				0x41
    BER_TYPE_GAUGE					0x42
    BER_TYPE_TIME_TICKS				0x43
    BER_TYPE_NO_SUCH_OBJECT				0x80
    BER_TYPE_NO_SUCH_INSTANCE			0x81
    BER_TYPE_END_OF_MIB_VIEW			0x82
    BER_TYPE_SNMP_GET				0xA0
    BER_TYPE_SNMP_GETNEXT				0xA1
    BER_TYPE_SNMP_RESPONSE				0xA2
    BER_TYPE_SNMP_SET				0xA3
    BER_TYPE_SNMP_GETBULK				0xA5
    BER_TYPE_SNMP_INFORM				0xA6
    BER_TYPE_SNMP_TRAP				0xA7
    BER_TYPE_SNMP_REPORT				0xA8

    长度域(length) 编码 :
    短格式： length=30=>1E
    长格式：1（1bit） K（7bit） K个八位组长度（K Byte）

    值域 (value) 编码：
    整型 Integer 的编码 integer::=0x02 length{byte}
    字符串类型的编码 string::=0x04 length{byte}
    空类型的编码 null::=0x05 0x00
    对象标识 ObjectID(oid) 编码  objectID::=0x06  length  {subidentifier}*
