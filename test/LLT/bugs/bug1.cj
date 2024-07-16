// EXEC: cjc %import-path %L %l %f
// EXEC: ./main
import asn1.*
import std.io.*
import std.collection.*
import std.time.*

main() {
    let arr: Array<Bool> = Array<Bool>([true, true, false, true, false, false])
    var asn1itstring: ASN1BitString = ASN1BitString(arr)
    if (!asn1itstring.isSet(-7)) {
        return 1
    }
    if (!asn1itstring.isSet(-6)) {
        return 1
    }
    if (!asn1itstring.isSet(-5)) {
        return 1
    }
    if (!asn1itstring.isSet(-4)) {
        return 1
    }
    if (!asn1itstring.isSet(-3)) {
        return 1
    }
    if (!asn1itstring.isSet(-2)) {
        return 1
    }
    if (!asn1itstring.isSet(-1)) {
        return 1
    }
    if (!asn1itstring.isSet(0)) {
        return 1
    }
    if (!asn1itstring.isSet(1)) {
        return 1
    }
    if (asn1itstring.isSet(2)) {
        return 1
    }
    if (!asn1itstring.isSet(3)) {
        return 1
    }
    if (asn1itstring.isSet(4)) {
        return 1
    }
    if (asn1itstring.isSet(5)) {
        return 1
    }
    if (asn1itstring.isSet(6)) {
        return 1
    }
    if (asn1itstring.isSet(7)) {
        return 1
    }
    return 0
}
