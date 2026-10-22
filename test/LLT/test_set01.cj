// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import asn1.*
import std.collection.*
import std.unittest.*
import std.unittest.testmacro.*

main(): Int64 {
    var arr = HashSet<ASN1Object>()
    let buf: Array<Byte> = [1]
    var sets = ASN1Set(arr,buf)
    ASN1Set(arr)

    let src = sets.getValue()
    sets.iterator()

    println(src.size)
    @Assert(src.size, 0)

    // 入参集合拷贝隔离：构造后修改外部集合不影响内部状态
    var arr2 = HashSet<ASN1Object>()
    arr2.add(ASN1Boolean(true))
    var sets2 = ASN1Set(arr2)
    arr2.add(ASN1Boolean(false))
    @Assert(sets2.getValue().size, 1)
    return 0
}
