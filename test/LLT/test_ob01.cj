// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

import std.io.*
import asn1.*
import std.unittest.*
import std.unittest.testmacro.*

main(): Int64 {
    let tags = INTEGER
    let dec: BERDecoder = BERDecoder()
    let bitss = BooleanParser(dec)
    let Buf: Array<Byte> = [1]
    let Buf2: Array<Byte> = [0]
    let ssc = bitss.parse(tags,Buf)
    let ssc2 = bitss.parse(tags,Buf2)
    let scc3 = ssc.equals(ssc2)

    @Assert(scc3, false)
    @Assert(ssc == ssc2, false)
    @Assert(ssc != ssc2, true)
    return 0
}
