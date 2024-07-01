// EXEC: cjc %import-path %L %l %f
// EXEC: ./main

from asn1 import asn1.*
from std import io.*
from std import collection.*

main(): Int64 {
    var objects: HashSet<ASN1Object> = HashSet<ASN1Object>([ASN1Boolean(true)])
    var set: ASN1Set = ASN1Set(objects)
    var any: Any = set.getValue()
    var anySet: HashSet<ASN1Object> = (any as HashSet<ASN1Object>).getOrThrow()
    if (anySet.size != 1) {
        return 1
    }
    var iteratorSet: Iterator<ASN1Object> = anySet.iterator()
    while (true) {
        match (iteratorSet.next()) {
            case Some(i) => println(i)
            case None => break
        }
    }

    var objects1: HashSet<ASN1Object> = HashSet<ASN1Object>([ASN1Boolean(true), ASN1Integer(1)])
    var set1: ASN1Set = ASN1Set(objects1)
    var any1: Any = set1.getValue()
    var anySet1: HashSet<ASN1Object> = (any1 as HashSet<ASN1Object>).getOrThrow()
    if (anySet1.size != 2) {
        return 1
    }
    var iteratorSet1: Iterator<ASN1Object> = anySet1.iterator()
    while (true) {
        match (iteratorSet1.next()) {
            case Some(i) => println(i)
            case None => break
        }
    }

    var objects2: HashSet<ASN1Object> = HashSet<ASN1Object>(
        [ASN1Boolean(true), ASN1Integer(1), ASN1Boolean(false), ASN1Integer(2)])
    var set2: ASN1Set = ASN1Set(objects2)
    var any2: Any = set2.getValue()
    var anySet2: HashSet<ASN1Object> = (any2 as HashSet<ASN1Object>).getOrThrow()
    if (anySet2.size != 4) {
        return 1
    }
    var iteratorSet2: Iterator<ASN1Object> = anySet2.iterator()
    while (true) {
        match (iteratorSet2.next()) {
            case Some(i) => println(i)
            case None => break
        }
    }

    return 0
}
