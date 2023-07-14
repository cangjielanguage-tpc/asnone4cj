<div align="center">
<h1>asn1-cj</h1>
</div>

<p align="center">
<img alt="" src="https://img.shields.io/badge/release-v0.0.1-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/build-pass-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/cjc-v0.39.4-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/cjcov-91.8%25-brightgreen" style="display: inline-block;" />
<img alt="" src="https://img.shields.io/badge/project-open-brightgreen" style="display: inline-block;" />
</p>


## <img alt="" src="./doc/assets/readme-icon-introduction.png" style="display: inline-block;" width=3%/> 介绍

asn1-cj 是 ASN.1 编码器和解码器的实现。它支持字节流的 BER 和 DER 编码规则。

### 特性

- 🚀 支持 Ber,Der 编码规则

- 🚀 支持 Sequence，Set，Tagged 构造类型

- 💪 支持 Boolean，Enumerated，Integer，Null，ObjectIdentifier，PrimitiveValue 原始类型数据

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
│   └── feature_api.md
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

- `doc` 是库的设计文档、提案、库的使用文档、LLT 用例覆盖报告
- `src` 是库源码目录
- `test` 是存放测试用例，包括 HLT 用例、LLT 用例和 UT 用例

### 接口说明

主要是核心类和成员函数说明，详情见 [API](./doc/feature_api.md)

## <img alt="" src="./doc/assets/readme-icon-compile.png" style="display: inline-block;" width=3%/> 使用说明

### 编译

#### linux环境编译

编译描述和具体shell命令

```shell
git clone https://gitee.com/HW-PLLab/asn1-cj.git;
git clone https://gitee.com/HW-PLLab/testJekins.git;
cd okhttp-idling-resource;
cp -r ../testJekins/src/ci_test .;

python3 ci_test/main.py build   ---> 编译
python3 ci_test/main.py test;   ---> 执行 test/LLT 用例 
```

#### Window环境编译

编译描述和具体cmd命令

```git bash here
git clone https://gitee.com/HW-PLLab/asn1-cj.git;
```

```cmd
cd asn1-cj
cpm build -V   ---> 编译
cpm test - V   ---> 执行 test/LLT 用例 
```

### 功能示例

#### 编码

功能示例描述: Bool类型编码

示例代码如下：

```cangjie
from asn1 import asn1.*
from asn1 import asn1.types.*
from asn1 import asn1.util.*
from asn1 import asn1.encodingrules.*
from asn1 import asn1.encodingrules.der.*
from std import io.*

main(): Int64 {
    var value3: Array<Byte> = [0x01, 0x01, 0x00]
    var byteArrayStream3: ByteArrayStream = ByteArrayStream()
    var asn1OutputStream3: ASN1OutputStream = ASN1OutputStream(DEREncoder(), byteArrayStream3)
    asn1OutputStream3.writeObject(ASN1Boolean(false))
    if (byteArrayStream3.bytes() == value3) {
        return 1
    }

    var value4: Array<Byte> = [0x01, 0x01, 0x01]
    var byteArrayStream4: ByteArrayStream = ByteArrayStream()
    var asn1OutputStream4: ASN1OutputStream = ASN1OutputStream(DEREncoder(), byteArrayStream4)
    asn1OutputStream4.writeObject(ASN1Boolean(true))
    if (byteArrayStream4.bytes() == value4) {
        return 1
    }
}
```

执行结果如下：

```shell
success
success
```

#### 解码

功能示例描述: Bool类型解码

示例代码如下：

```cangjie
from asn1 import asn1.*
from asn1 import asn1.types.*
from asn1 import asn1.util.*
from asn1 import asn1.encodingrules.*
from asn1 import asn1.encodingrules.der.*
from std import io.*

main(): Int64 {
    var value: Array<Byte> = [0x01, 0x01, 0x0]
    var byteArrayStream: ByteArrayStream = ByteArrayStream()
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
    var byteArrayStream1: ByteArrayStream = ByteArrayStream()
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

执行结果如下：

```shell
success
success
success
success
success
success
```

## <img alt="" src="./doc/assets/readme-icon-contribute.png" style="display: inline-block;" width=3%/> 参与贡献

欢迎给我们提交PR，欢迎给我们提交Issue，欢迎参与任何形式的贡献。
