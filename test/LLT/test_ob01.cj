// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from std import io.*
from asn1 import asn1.*

main() {
    let tags = INTEGER
    let dec: BERDecoder = BERDecoder()
    let bitss = BooleanParser(dec)
    let Buf: Array<Byte> = [1]
    let Buf2: Array<Byte> = [0]
    let ssc = bitss.parse(tags,Buf)
    let ssc2 = bitss.parse(tags,Buf2)
    let scc3 = ssc.equals(ssc2)
    if (scc3) {
        return 1
    }
    if (ssc == ssc2) {
        return 2
    }
    if (ssc != ssc2) {
        return 0
    }
    return 3
}
