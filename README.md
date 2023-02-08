<div align="center">
<h1>asn-one</h1>
</div>

<p align="center">
<img alt="" src="https://img.shields.io/badge/release-v0.0.1-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/build-pass-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/cjc-v0.36.4-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/cjcov-80%25-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/project-open-brightgreen" style="display: inline-block;" />
</p>


## <img alt="" src="./doc/assets/readme-icon-introduction.png" style="display: inline-block;" width=3%/> 介绍

ASN-one 是 ASN.1 编码器和解码器的实现。它支持字节流的 BER 和 DER 编码规则。

### 特性

- 🚀 支持 Ber,Der 编码规则

- 🚀 支持 Sequence，Set，Tagged 构造类型

- 💪 支持 Boolean，Enumerated，Integer，Null，ObjectIdentifier，PrimitiveValue<T> 原始类型数据

- 🛠️ 支持 BitString，Octet String，String 字符串类型

### 路线

<p align="center">
<img src="./doc/assets/milestone.png" width="100%" >
</p>

## <img alt="" src="./doc/assets/readme-icon-framework.png" style="display: inline-block;" width=3%/> 软件架构

### 源码目录

```shell
.
├── README.md
├── doc
│   ├── assets
│   ├── cjcov
│   ├── design.md
│   ├── proposal.md
│   └── xxx_lib.md
│   └── api.md
├── src
│   └── asn1
│        └── encodingrules
│        └── types
│        └── util
└── test
    ├── HLT
    ├── LLT
    └── UT
```

- `doc` 是库的设计文档、提案、库的使用文档、LLT 用例覆盖报告（小于 90%，在此说明）
- `src` 是库源码目录
- `test` 是存放测试用例，包括 HLT 用例、LLT 用例和 UT 用例

### 接口说明

主要是核心类和成员函数说明，详情见 [API](./doc/api.md)

## <img alt="" src="./doc/assets/readme-icon-compile.png" style="display: inline-block;" width=3%/> 使用说明

### 编译

编译描述和具体shell命令

```shell
cpm update
cpm build
```

### 功能示例

#### primitive 类型解码示例

功能示例描述:

示例代码如下：

```cangjie
from asn1 import asn1.types.*

main(): Int64 {
    var data: Array<Byte> =  [
            0x02, 0x7f, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d,
            0x0e, 0x0f, 0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18, 0x19, 0x1a, 0x1b, 0x1c,
            0x1d, 0x1e, 0x1f, 0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, 0x28, 0x29, 0x2a, 0x2b,
            0x2c, 0x2d, 0x2e, 0x2f, 0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x39, 0x3a,
            0x3b, 0x3c, 0x3d, 0x3e, 0x3f, 0x40, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46, 0x47, 0x48, 0x49,
            0x4a, 0x4b, 0x4c, 0x4d, 0x4e, 0x4f, 0x50, 0x51, 0x52, 0x53, 0x54, 0x55, 0x56, 0x57, 0x58,
            0x59, 0x5a, 0x5b, 0x5c, 0x5d, 0x5e, 0x5f, 0x60, 0x61, 0x62, 0x63, 0x64, 0x65, 0x66, 0x67,
            0x68, 0x69, 0x6a, 0x6b, 0x6c, 0x6d, 0x6e, 0x6f, 0x70, 0x71, 0x72, 0x73, 0x74, 0x75, 0x76,
            0x77, 0x78, 0x79, 0x7a, 0x7b, 0x7c, 0x7d, 0x7e, 0x7f]
    var test: ASN1InputStream = ASN1InputStream(BERDecoder(),  data )
    if (ASN1Tag.INTEGER.equals(test.readTag()) ) { //readTag == INTEGER
        if (test.readLength() == 127) { //readLength == 127
            println("success")
            return 0
        }
    }
    return 1
}
```

执行结果如下：

```shell
success
```

#### primitive 类型编码示例

功能示例描述:

示例代码如下：

```cangjie
from std import io.*
from asn1 import asn1.types.*


main(): Int64 {
    let data1: Array<Byte> =  [0x01, 0x01, 0x0] //false
    let data2: Array<Byte> =  [0x01, 0x01, 0x01] //true
    var output = ByteArrayStream()
    var stream = ASN1OutputStream(encode(), output).writeObject(ASN1Boolean(false))
    var decodedata = output.readToEnd()
    if (decodedata !=data1) {
        println(decodedata)
        return 1
    }
    println("success")
    return 0
}
class encode <:  ASN1Encoder {}
```

执行结果如下：

```shell
success
```
## <img alt="" src="./doc/assets/readme-icon-contribute.png" style="display: inline-block;" width=3%/> 参与贡献

欢迎给我们提交PR，欢迎给我们提交Issue，欢迎参与任何形式的贡献。