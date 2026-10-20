// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import asn1.*
import std.io.*
import std.math.numeric.*
import std.unittest.*
import std.unittest.testmacro.*

// 从 SEQUENCE 中取出第 i 个 INTEGER 字段的 BigInt 值
func getInt(seq: ASN1Sequence, i: Int64): BigInt {
    let obj = (seq.get(i) as ASN1Integer).getOrThrow()
    return (obj.getValue() as BigInt).getOrThrow()
}

// 解析 DER 字节为 ASN1Sequence
func parseSequence(der: Array<Byte>): ASN1Sequence {
    var buf: ByteBuffer = ByteBuffer()
    buf.write(der)
    var stream: ASN1InputStream = ASN1InputStream(DERDecoder(), buf)
    return (stream.readObject() as ASN1Sequence).getOrThrow()
}

main(): Int64 {
    // ====================================================================
    // PKCS#1 RSA 公钥（PEM 头 -----BEGIN RSA PUBLIC KEY----- 的 DER 内容）
    // RSAPublicKey ::= SEQUENCE {
    //     modulus         INTEGER,   -- n（模数）
    //     publicExponent  INTEGER    -- e（公钥指数）
    // }
    // ====================================================================
    let pubKeyDer: Array<Byte> = [0x30, 0x07, 0x02, 0x02, 0x0C, 0xA1, 0x02, 0x01, 0x11]

    let pubSeq: ASN1Sequence = parseSequence(pubKeyDer)

    let n: BigInt = getInt(pubSeq, 0)   // 模数 n
    let e: BigInt = getInt(pubSeq, 1)   // 公钥指数 e
    println("[PKCS#1 公钥] n = ${n}, e = ${e}")

    @Assert(n, BigInt(3233))
    @Assert(e, BigInt(17))

    // ====================================================================
    // PKCS#1 RSA 私钥（PEM 头 -----BEGIN RSA PRIVATE KEY----- 的 DER 内容）
    // RSAPrivateKey ::= SEQUENCE {
    //     version           INTEGER,   -- 0
    //     modulus           INTEGER,   -- n（模数）
    //     publicExponent    INTEGER,   -- e（公钥指数）
    //     privateExponent   INTEGER,   -- d（私钥指数）
    //     prime1            INTEGER,   -- p
    //     prime2            INTEGER,   -- q
    //     exponent1         INTEGER,   -- d mod (p-1)
    //     exponent2         INTEGER,   -- d mod (q-1)
    //     coefficient       INTEGER    -- q^-1 mod p
    // }
    // ====================================================================
    let privKeyDer: Array<Byte> = [
        0x30, 0x1D,                         // SEQUENCE, 29 字节
        0x02, 0x01, 0x00,                   // version  = 0
        0x02, 0x02, 0x0C, 0xA1,             // n        = 3233
        0x02, 0x01, 0x11,                   // e        = 17
        0x02, 0x02, 0x0A, 0xC1,             // d        = 2753
        0x02, 0x01, 0x3D,                   // p        = 61
        0x02, 0x01, 0x35,                   // q        = 53
        0x02, 0x01, 0x35,                   // dp       = 53
        0x02, 0x01, 0x31,                   // dq       = 49
        0x02, 0x01, 0x26                    // qInv     = 38
    ]

    let privSeq: ASN1Sequence = parseSequence(privKeyDer)

    let version: BigInt = getInt(privSeq, 0)
    let n2: BigInt = getInt(privSeq, 1)     // 模数 n
    let e2: BigInt = getInt(privSeq, 2)     // 公钥指数 e
    let d: BigInt = getInt(privSeq, 3)      // 私钥指数 d
    let p: BigInt = getInt(privSeq, 4)
    let q: BigInt = getInt(privSeq, 5)
    println("[PKCS#1 私钥] version = ${version}, n = ${n2}, e = ${e2}, d = ${d}, p = ${p}, q = ${q}")

    @Assert(version, BigInt(0))
    @Assert(n2, BigInt(3233))
    @Assert(e2, BigInt(17))
    @Assert(d, BigInt(2753))
    @Assert(p, BigInt(61))
    @Assert(q, BigInt(53))

    // ====================================================================
    // X.509 SubjectPublicKeyInfo（PEM 头 -----BEGIN PUBLIC KEY----- 的 DER 内容）
    // SubjectPublicKeyInfo ::= SEQUENCE {
    //     algorithm        AlgorithmIdentifier,  -- SEQUENCE { OID, NULL }
    //     subjectPublicKey BIT STRING            -- 内层是 PKCS#1 RSAPublicKey
    // }
    // ====================================================================
    let spkiDer: Array<Byte> = [
        0x30, 0x1B,                                       // SEQUENCE
        0x30, 0x0D,                                       // AlgorithmIdentifier
        0x06, 0x09, 0x2A, 0x86, 0x48, 0x86, 0xF7, 0x0D, 0x01, 0x01, 0x01,   // OID 1.2.840.113549.1.1.1 (rsaEncryption)
        0x05, 0x00,                                       // NULL
        0x03, 0x0A, 0x00,                                 // BIT STRING（0 个未用位）
        0x30, 0x07, 0x02, 0x02, 0x0C, 0xA1, 0x02, 0x01, 0x11               // 内层 RSAPublicKey
    ]

    let spkiSeq: ASN1Sequence = parseSequence(spkiDer)

    // 第 0 个元素是 AlgorithmIdentifier，第 1 个元素是 BIT STRING
    let bitString: ASN1BitString = (spkiSeq.get(1) as ASN1BitString).getOrThrow()

    // BIT STRING 内容即内层 RSAPublicKey 的 DER，再解析一次
    let rsaPubSeq: ASN1Sequence = parseSequence(bitString.getValueBytes())

    let n3: BigInt = getInt(rsaPubSeq, 0)   // 模数 n
    let e3: BigInt = getInt(rsaPubSeq, 1)   // 公钥指数 e
    println("[X.509 公钥] n = ${n3}, e = ${e3}")

    @Assert(n3, BigInt(3233))
    @Assert(e3, BigInt(17))
    return 0
}
