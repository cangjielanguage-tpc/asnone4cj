// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import asn1.*
import std.io.*
import std.unittest.*
import std.unittest.testmacro.*

// 非 Seekable 输入流：用于验证 lengthData() 返回 -1 时的读取与迭代行为
class NonSeekableStream <: InputStream {
    private var data: Array<Byte>
    private var pos: Int64 = 0

    init(data: Array<Byte>) {
        this.data = data
    }

    public func read(buffer: Array<Byte>): Int64 {
        if (pos >= data.size || buffer.isEmpty()) {
            return 0
        }
        var count: Int64 = 0
        while (count < buffer.size && pos < data.size) {
            buffer[count] = data[pos]
            count++
            pos++
        }
        return count
    }
}

main(): Int64 {
    let decodetd: BERDecoder = BERDecoder()
    let wrapped: ByteBuffer = ByteBuffer()
    let asn = ASN1InputStream(decodetd,wrapped)
    let bytesBuf: Array<Byte> = Array<Byte>(10, repeat: 0)
    let asn1 = ASN1InputStream(decodetd,bytesBuf)
    let src1 = asn.iterator()
    src1.iterator()
    // 空流上各读取操作均应抛异常
    var caught1: Bool = false
    try {
        asn1.readObject()
    } catch (e: Exception) {
        caught1 = true
    }
    @Assert(caught1, true)

    // 空流上 iterator.next() 返回 None，不抛异常
    src1.next()

    var caught3: Bool = false
    try {
        asn.readTag()
    } catch (e: Exception) {
        caught3 = true
    }
    @Assert(caught3, true)

    var caught4: Bool = false
    try {
        asn.readValue(1)
    } catch (e: Exception) {
        caught4 = true
    }
    @Assert(caught4, true)

    var caught5: Bool = false
    try {
        asn.readLength()
    } catch (e: Exception) {
        caught5 = true
    }
    @Assert(caught5, true)

    var data: Array<Byte> = Array<Byte>()
    asn.read(data)

    // 非 Seekable 流：readObject 可正常读取对象
    let ns: NonSeekableStream = NonSeekableStream([0x01, 0x01, 0x01])
    let nsStream: ASN1InputStream = ASN1InputStream(BERDecoder(), ns)
    let nsObj: ASN1Object = nsStream.readObject()
    @Assert(nsObj is ASN1Boolean, true)

    // 非 Seekable 空流迭代：EOF 时 next() 返回 None，迭代正常结束
    let nsEmpty: NonSeekableStream = NonSeekableStream(Array<Byte>())
    let nsEmptyStream: ASN1InputStream = ASN1InputStream(BERDecoder(), nsEmpty)
    var emptyCount: Int64 = 0
    for (o in nsEmptyStream) {
        emptyCount++
    }
    @Assert(emptyCount, 0)

    // 非 Seekable 流多对象迭代：读完所有对象后正常结束
    let ns2: NonSeekableStream = NonSeekableStream([0x01, 0x01, 0x01, 0x01, 0x01, 0x00])
    let ns2Stream: ASN1InputStream = ASN1InputStream(BERDecoder(), ns2)
    var objCount: Int64 = 0
    for (o in ns2Stream) {
        @Assert(o is ASN1Boolean, true)
        objCount++
    }
    @Assert(objCount, 2)
    return 0
}
