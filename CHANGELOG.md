## v1.0.3

1. 更新到cjc_1.2.0
2. 修复并发解码数据错乱、EOF 静默返回错误数据、equals 语义错误、ObjectIdentifier 边界截断、String iterator 无限递归等问题
3. 解码与编码性能优化：readObject 约 -40%，writeObject 约 -16%
4. 补充高 tag 号（>30）的 BER/DER 编码支持，修复解码/编码不对称
5. LLT 用例改写为 @Assert 断言模式

## v1.0.2

1. 更新到cjc_1.1.3

## v1.0.1

1. 更新到cjc_1.0.0

## v1.0.0

1. 更新到cjc_0.58.3

## v0.0.1

ASN.1 编码器和解码器

- 支持字节流的 BER 和 DER 编码规则
