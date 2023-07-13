package asn1.util

from std import collection.StringBuilder
from std import math.*
from std import convert.*

foreign func log2(n: Float64): Float64

foreign func ceil(n: Float64): Float64

@OverflowWrapping
func maxPow(b: Int64): (Int64, Int64) {
    var p: Int64 = b
    var n: Int64 = 1
    var max: Int64 = Int64.Max / b
    while (p <= max) {
        p *= b
        n++
    }
    return (p, n)
}

public class BigInt <: Equatable<BigInt> & Hashable & ToString {
    private var sign: Bool

    private var digits: Option<(Array<UInt32>, Int64)> = None

    private var intVal: Option<Int64> = None

    private static let baseLength: Int64 = 32

    private static let base: Int64 = Int64(UInt32.Max) + 1

    private static let smallInts: Array<BigInt> = Array<BigInt>(100, {i => BigInt(i)})

    public init(n: Int64) {
        intVal = Some(n)
        sign = n >= 0
    }

    @OverflowWrapping
    private static func intToDigs(n_: Int64): (Array<UInt32>, Int64) {
        var ret: (Array<UInt32>, Int64)
        if (n_ == Int64.Min) {
            ret = ([2147483648, 0], 0)
        } else {
            var n = abs(n_)
            if (n < base) {
                ret = (Array<UInt32>(1, item: UInt32(n)), 0)
            } else {
                let d = UInt32(n / base)
                let r = UInt32(n % base)
                if (d == 0) {
                    ret = ([r], 0)
                } else {
                    ret = ([d, r], 0)
                }
            }
        }
        ret
    }

    @OverflowWrapping
    private static func digsToInt(a_: (Array<UInt32>, Int64)): Int64 {
        let (a, fst) = a_
        if (a.size - fst == 1) {
            return Int64(a[fst])
        }
        return Int64(a[fst]) * base + Int64(a[fst + 1])
    }

    @OverflowWrapping
    private static func valueOf(n: Int64): BigInt {
        if (n < smallInts.size && n >= 0) {
            return smallInts[n]
        } else {
            return BigInt(n)
        }
    }

    public init(x: BigInt) {
        sign = x.getSign()
        if (x.isInt()) {
            intVal = x.checkedToInt()
        } else {
            digits = x.copyDigits()
        }
    }

    public init(str: String) {
        match (Int64.tryParse(str)) {
            case Some(n) =>
                intVal = n
                sign = (n >= 0)
            case None =>
                if (str.isEmpty()) {
                    throw Exception("")
                }
                if (str.equals("-") || str.equals("+")) {
                    throw Exception("")
                }
                sign = true
                var start: Int64 = 0
                let len: Int64 = str.utf8View.size
                let strUtf8 = str.utf8View
                var size: Int64 = len
                var ch: UInt8 = strUtf8[0]
                if (ch == b'-') {
                    start++
                    size--
                    sign = false
                } else if (ch == b'+') {
                    start++
                    size--
                }
                var flag: Int64 = 10
                var (bn, n) = maxPow(flag)
                var numChunks: Int64 = 1 + size / n
                var chunks: Array<Int64> = Array<Int64>(numChunks, item: 0)
                var dnChunks: Array<(Array<UInt32>, Int64)> = Array<(Array<UInt32>, Int64)>(numChunks + 1,
                    item: intToDigs(bn))
                var chunksPos: Int64 = 0
                var i: Int64 = 0
                var di: Int64 = 0
                for (index in start..len) {
                    ch = strUtf8[index]
                    var d1: Int64 = 0
                    match {
                        case b'0' <= ch && ch <= b'9' => d1 = Int64(ch - b'0')
                        case _ => throw Exception("")
                    }
                    if (d1 >= flag) {
                        throw Exception("")
                    }
                    di = di * flag + d1
                    i++
                    if (i == n) {
                        chunks[chunksPos] = di
                        chunksPos++
                        di = 0
                        i = 0
                    }
                }
                dnChunks[chunksPos] = intToDigs(flag ** UInt64(i))
                chunks[chunksPos] = di
                dnChunks[chunksPos + 1] = (Array<UInt32>(1, item: 1), 0)
                var modRest: (Array<UInt32>, Int64) = (Array<UInt32>(1, item: 1), 0)
                var rest: (Array<UInt32>, Int64) = (Array<UInt32>(1, item: 0), 0)
                for (index in chunksPos..=0 : -1) {
                    modRest = multD(dnChunks[index + 1], modRest)
                    rest = addDMut(rest, multD(modRest, intToDigs(chunks[index])))
                }
                digits = rest
                var isBool0: Bool = this <= Int64.Max
                var isBool1: Bool = this >= Int64.Min
                let isBool: Bool = isBool0 && isBool1
                if (isBool) {
                    intVal = digsToInt(rest)
                }
        }
    }

    @OverflowWrapping
    public func getSign(): Bool {
        sign
    }

    @OverflowWrapping
    public func getDigits(): (Array<UInt32>, Int64) {
        match (digits) {
            case Some(d) => digits = d
            case None => digits = intToDigs(toIntUnSafe())
        }
        digits.getOrThrow()
    }

    @OverflowWrapping
    public func copyDigits(): (Array<UInt32>, Int64) {
        let (a, fst) = getDigits()
        (a.clone(), fst)
    }

    @OverflowWrapping
    public func toInt(): Int64 {
        toIntUnSafe()
    }

    private static func signDigsToOptionInt(sign: Bool, ds_: (Array<UInt32>, Int64)): Option<Int64> {
        let ds = ds_[0]
        let fst = ds_[1]
        let size: Int64 = ds.size - fst
        if (size > 2) {
            return None
        }
        if (size == 1) {
            if (sign) {
                return Some(Int64(ds[fst]))
            }
            return Some(-Int64(ds[fst]))
        }
        try {
            let d1: UInt64 = UInt64(ds[fst]) * UInt64(base)
            let d0: UInt64 = UInt64(ds[fst + 1])
            let rest: UInt64 = d1 + d0
            if (sign) {
                return Some(Int64(rest))
            }
            if (rest == UInt64(Int64.Max) + 1) {
                return Some(Int64.Min)
            }
            return Some(-Int64(rest))
        } catch (e: OverflowException) {
            return None
        }
    }

    @OverflowWrapping
    public func checkedToInt(): Option<Int64> {
        intVal
    }

    @OverflowWrapping
    public func toStringDec(): String {
        match (checkedToInt()) {
            case Some(n) => n.toString()
            case None =>
                let b: Int64 = (10 ** 9)
                var q: BigInt = abs()
                var r: BigInt = valueOf(0)
                var str: StringBuilder = StringBuilder()
                var n: Int64 = -1
                while (!q.isZero()) {
                    if (n >= 0) {
                        str.insert(0, n.toString().padLeft(9, paddingChar: '0'))
                    }
                    let qr: (BigInt, BigInt) = q.div(b)
                    q = qr[0]
                    r = qr[1]
                    n = r.toInt()
                }
                str.insert(0, n.toString())
                if (!sign) {
                    str.insert(0, "-")
                }
                return str.toString()
        }
    }

    @OverflowWrapping
    public func toStringHex(): String {
        toStringPo2(4, {n: Int64 => toHexDig(n)})
    }

    @OverflowWrapping
    public func toHexDig(n: Int64): String {
        if (n >= 0 && n <= 9) {
            n.toString()
        } else {
            match (n) {
                case 10 => "A"
                case 11 => "B"
                case 12 => "C"
                case 13 => "D"
                case 14 => "E"
                case 15 => "F"
                case _ => "X"
            }
        }
    }

    @OverflowWrapping
    public func toStringOct(): String {
        toStringPo2(3, {n: Int64 => n.toString()})
    }

    @OverflowWrapping
    public func toStringBin(): String {
        toStringPo2(1, {n: Int64 => n.toString()})
    }

    @OverflowWrapping
    private func toStringPo2(e: Int64, f: (Int64) -> String): String {
        if (isZero()) {
            return "0"
        }
        let b: Int64 = 2 ** UInt64(e)
        var q: (Array<UInt32>, Int64) = getDigits()
        var r: Int64 = 0
        var subStr: StringBuilder = StringBuilder()
        while (!eqI(q, 0)) {
            let qr: ((Array<UInt32>, Int64), Int64) = divI(q, b)
            q = qr[0]
            r = qr[1]
            subStr.insert(0, f(r))
        }
        if (!sign) {
            subStr.insert(0, '-')
        }
        return subStr.toString()
    }

    @OverflowWrapping
    public func toString(): String {
        toStringDec()
    }

    @OverflowWrapping
    public func hashCode(): Int64 {
        toString().hashCode()
    }

    @OverflowWrapping
    public func abs(): BigInt {
        match (checkedToInt()) {
            case Some(n) =>
                if (n != Int64.Min) {
                    valueOf(abs(n))
                } else {
                    BigInt(true, getDigits())
                }
            case None => BigInt(true, getDigits())
        }
    }

    @OverflowWrapping
    public operator func -(): BigInt {
        negate()
    }

    @OverflowWrapping
    private func negate(): BigInt {
        match (checkedToInt()) {
            case Some(n) =>
                if (negationIsSafe(n)) {
                    BigInt(-n)
                } else {
                    let arr = intToDigs(n)
                    BigInt(!(n > 0), arr)
                }
            case None => BigInt(!sign, getDigits())
        }
    }

    @OverflowWrapping
    public operator func +(x: BigInt): BigInt {
        add(x)
    }

    @OverflowWrapping
    public func add(x: BigInt): BigInt {
        if (x.isZero()) {
            return this
        } else if (isZero()) {
            return x
        }
        match ((checkedToInt(), x.checkedToInt())) {
            case (Some(n), Some(m)) =>
                if (additionIsSafe(n, m)) {
                    BigInt(n + m)
                } else {
                    add(m)
                }
            case (Some(n), None) => x.add(n)
            case (None, Some(m)) => add(m)
            case (_, _) =>
                let xDigs: (Array<UInt32>, Int64) = x.getDigits()
                let digs: (Array<UInt32>, Int64) = getDigits()
                if (sign == x.getSign()) {
                    return BigInt(sign, addD(digs, xDigs))
                }
                if (eqD(digs, xDigs)) {
                    return valueOf(0)
                }
                if (gtD(digs, xDigs)) {
                    return BigInt(sign, diffD(digs, xDigs))
                }
                return BigInt(x.getSign(), diffD(digs, xDigs))
        }
    }

    @OverflowWrapping
    public operator func +(n: Int64): BigInt {
        add(n)
    }

    @OverflowWrapping
    public func add(n: Int64): BigInt {
        if (isInt() && additionIsSafe(toInt(), n)) {
            valueOf(toInt() + n)
        }
        if (n == 0) {
            return this
        }
        if (n < 0) {
            if (sign) {
                let n_ = abs(n)
                let lastVal: Int64 = Int64(getDigits()[0][getDigits()[0].size - 1])
                if (n_ <= lastVal) {
                    let rest: (Array<UInt32>, Int64) = (getDigits()[0].clone(), getDigits()[1])
                    rest[0][rest[0].size - 1] = UInt32(lastVal - n_)
                    return BigInt(true, rest)
                }
                return BigInt(gte(n_), diffD(getDigits(), intToDigs(n_)))
            } else {
                return abs().add(abs(n)).negate()
            }
        }
        if (sign) {
            return BigInt(true, addI(getDigits(), n))
        } else {
            let x_ = abs()
            return BigInt(BigInt(n).gte(x_), diffD(intToDigs(n), x_.getDigits()))
        }
    }

    @OverflowWrapping
    public operator func -(x: BigInt): BigInt {
        add(-x)
    }

    @OverflowWrapping
    public operator func -(n: Int64): BigInt {
        add(-n)
    }

    @OverflowWrapping
    private func toIntUnSafe(): Int64 {
        match (intVal) {
            case Some(n) => n
            case None => throw Exception("")
        }
    }

    @FastCall
    private static func additionIsSafe(x: Int64, y: Int64): Bool {
        try {
            x + y
            true
        } catch (e: OverflowException) {
            false
        }
    }

    @OverflowWrapping
    private func isInt(): Bool {
        match (intVal) {
            case Some(n_) =>
                (n_)
                true
            case None => false
        }
    }

    @OverflowWrapping
    public operator func *(x: BigInt): BigInt {
        mult(x)
    }

    @OverflowWrapping
    private func mult(x: BigInt): BigInt {
        match ((checkedToInt(), x.checkedToInt())) {
            case (Some(n), Some(m)) =>
                if (multiplicationIsSafe(n, m)) {
                    BigInt(n * m)
                } else {
                    mult(m)
                }
            case (Some(n), None) => x.mult(n)
            case (None, Some(m)) => mult(m)
            case (_, _) => BigInt(x.getSign() == sign, multD(getDigits(), x.getDigits()))
        }
    }

    @OverflowWrapping
    public operator func *(n: Int64): BigInt {
        mult(n)
    }

    @OverflowWrapping
    public func mult(n: Int64): BigInt {
        if (isInt() && multiplicationIsSafe(toInt(), n)) {
            return valueOf(toInt() * n)
        }
        if (n == 0) {
            return valueOf(0)
        }
        if (n == 1) {
            return this
        }
        if (n == -1) {
            return negate()
        }
        if (n < 0) {
            if (n > -base) {
                return BigInt(!sign, multD(getDigits(), -n))
            }
            if (n == Int64.Min) {
                let rest: Array<UInt32> = [2147483648, 0]
                return BigInt(!sign, multD(getDigits(), (rest, 0)))
            }
            return BigInt(!sign, multD(getDigits(), intToDigs(-n)))
        }
        if (n < base) {
            return BigInt(sign, multD(getDigits(), n))
        }
        return BigInt(sign, multD(getDigits(), intToDigs(n)))
    }

    @OverflowWrapping
    private func isZero(): Bool {
        match (checkedToInt()) {
            case Some(0) => true
            case Some(_) => false
            case None =>
                let (ds, fst) = getDigits()
                for (i in 0..ds.size - fst) {
                    if (ds[fst + i] != 0) {
                        return false
                    }
                }
                return true
        }
    }

    @OverflowWrapping
    private static func diffD(arr0: (Array<UInt32>, Int64), arr1: (Array<UInt32>, Int64)): (Array<UInt32>, Int64) {
        var a0_: (Array<UInt32>, Int64)
        var a1_: (Array<UInt32>, Int64)
        if (gteD(arr0, arr1)) {
            a0_ = arr0
            a1_ = arr1
        } else {
            a0_ = arr1
            a1_ = arr0
        }
        let (a0, _) = a0_
        let (a1, _) = a1_
        let a0Size = a0.size
        let a1Size = a1.size
        let rest: Array<UInt32> = Array<UInt32>(a0Size, item: 0)
        var borrow: Int64 = 0
        var newFst: Int64 = a0Size - 1
        for (i in 0..a0Size) {
            let j: Int64 = a0.size - 1 - i
            let n0: Int64 = Int64(a0[j]) - borrow
            let n1: Int64 = if (i < a1Size) {
                Int64(a1[a1Size - 1 - i])
            } else {
                0
            }
            if (n0 >= n1) {
                let val: Int64 = n0 - n1
                rest[rest.size - 1 - i] = UInt32(val)
                if (val != 0) {
                    newFst = rest.size - 1 - i
                }
                borrow = 0
            } else {
                let val: Int64 = n0 - n1 + base
                rest[rest.size - 1 - i] = UInt32(val)
                if (val != 0) {
                    newFst = rest.size - 1 - i
                }
                borrow = 1
            }
        }
        return (rest, newFst)
    }

    @FastCall
    @OverflowWrapping
    private static func negationIsSafe(x: Int64): Bool {
        return x != Int64.Min
    }

    @OverflowWrapping
    public operator func /(x: BigInt): BigInt {
        div(x)[0]
    }

    public init(s: Bool, ds: (Array<UInt32>, Int64)) {
        if (ds[0].size == 0) {
            throw Exception("")
        }
        sign = s
        digits = ds
        intVal = signDigsToOptionInt(s, ds)
    }

    @OverflowWrapping
    private static func addI(a: (Array<UInt32>, Int64), n: Int64): (Array<UInt32>, Int64) {
        if (n < base) {
            return addD(a, n)
        }
        return addD(a, intToDigs(n))
    }

    @OverflowWrapping
    private static func addD(a0_: (Array<UInt32>, Int64), a1_: (Array<UInt32>, Int64)): (Array<UInt32>, Int64) {
        let (a0, fst0) = a0_
        let (a1, fst1) = a1_
        let a0Size: Int64 = a0.size - fst0
        let a1Size: Int64 = a1.size - fst1
        if (a0Size < a1Size) {
            return addD(a1_, a0_)
        }
        let rest: Array<UInt32> = Array<UInt32>(a0Size + 1, item: 0)
        var carry: UInt64 = 0
        var newFst: Int64 = a0Size
        for (i in 0..a0Size) {
            let j0: Int64 = a0.size - 1 - i
            let j1: Int64 = a1.size - 1 - i
            let putIndex: Int64 = rest.size - 1 - i
            var val: UInt64 = UInt64(a0[j0]) + carry
            if (i < a1Size) {
                val += UInt64(a1[j1])
            }
            let putVal = val & 0xFFFF_FFFF
            rest[putIndex] = UInt32(putVal)
            if (val != 0) {
                newFst = putIndex
            }
            carry = val >> baseLength
        }
        if (carry == 0) {
            return (rest, newFst)
        } else {
            rest[newFst - 1] = UInt32(carry)
            return (rest, newFst - 1)
        }
    }

    @OverflowWrapping
    private static func addDMut(a0_: (Array<UInt32>, Int64), a1_: (Array<UInt32>, Int64), c: Int64): (Array<UInt32>, 
        Int64) {
        let (a0, fst0) = a0_
        let (a1, fst1) = a1_
        let a0Size: Int64 = a0.size - fst0
        let a1Size: Int64 = a1.size - fst1
        if (a0Size < a1Size) {
            return addD(a1_, a0_)
        }
        var carry: UInt64 = 0
        var newFst: Int64 = a0.size - 1
        for (i in 0..c) {
            var j0: Int64 = a0.size - 1 - i
            let j1: Int64 = a1.size - 1 - i
            var val: UInt64 = UInt64(a0[j0]) + carry
            if (i < a1Size) {
                val += UInt64(a1[j1])
            }
            let putVal = val & 0xFFFF_FFFF
            a0[j0] = UInt32(putVal)
            if (val != 0) {
                newFst = j0
            }
            carry = val >> baseLength
        }
        if (carry != 0) {
            let j0: Int64 = a0.size - 1 - (c - 1) - 1
            if (j0 == -1) {
                let ret = (Array<UInt32>(a0Size + 1, {
                        item => if (item == 0) {
                            0
                        } else {
                            a0[item + fst0 - 1]
                        }
                    }), 0)
                ret[0][0] = UInt32(carry)
                return ret
            } else {
                a0[j0] = UInt32(carry)
                return (a0, min(fst0 + 1, j0))
            }
        }
        (a0, min(fst0 + 1, newFst))
    }

    @OverflowWrapping
    private static func addDMut(a0_: (Array<UInt32>, Int64), a1_: (Array<UInt32>, Int64)): (Array<UInt32>, Int64) {
        addDMut(a0_, a1_, a0_[0].size - a0_[1])
    }

    @OverflowWrapping
    private static func sumordered(arr: Array<(Array<UInt32>, Int64)>): (Array<UInt32>, Int64) {
        let arrSize = arr.size
        let arr0Fst = arr[0][1]
        let arr0Size = arr[0][0].size - arr0Fst
        if (arrSize == 1) {
            (Array<UInt32>(arr0Size, {item => arr[0][0][item + arr0Fst]}), 0)
        } else {
            let size = arr[arrSize - 1][0].size + 1
            var rest: (Array<UInt32>, Int64) = (Array<UInt32>(size, item: 0), size - arr0Size)
            arr[0][0].copyTo(rest[0], arr0Fst, size - arr0Size, arr0Size)
            for (i in 1..arrSize) {
                rest = addDMut(rest, arr[i], arr[i][0].size - arr[i][1])
            }
            rest
        }
    }

    @FastCall
    private static func multiplicationIsSafe(x: Int64, y: Int64): Bool {
        try {
            x * y
            true
        } catch (e: OverflowException) {
            false
        }
    }

    @OverflowWrapping
    private static func eqD(arr0: (Array<UInt32>, Int64), arr1: (Array<UInt32>, Int64)): Bool {
        let (a0, fst0): (Array<UInt32>, Int64) = arr0
        let (a1, fst1): (Array<UInt32>, Int64) = arr1
        let a0Size = a0.size - fst0
        let a1Size = a1.size - fst1
        if (a0Size == a1Size) {
            for (i in 0..a0Size) {
                if (a0[fst0 + i] != a1[fst1 + i]) {
                    return false
                }
            }
            return true
        }
        return false
    }

    @OverflowWrapping
    private static func gtD(arr0: (Array<UInt32>, Int64), arr1: (Array<UInt32>, Int64)): Bool {
        let (a0, fst0) = arr0
        let (a1, fst1) = arr1
        let s0: Int64 = a0.size - fst0
        let s1: Int64 = a1.size - fst1
        if (s0 > s1) {
            return true
        }
        if (s0 == s1) {
            for (i in 0..s0) {
                if (a0[fst0 + i] != a1[fst1 + i]) {
                    return (a0[fst0 + i] > a1[fst1 + i])
                }
            }
            return false
        }
        return false
    }

    @OverflowWrapping
    private func gte(x: BigInt): Bool {
        match ((sign, x.getSign())) {
            case (true, false) => return true
            case (false, true) => return false
            case (true, true) =>
                match ((checkedToInt(), x.checkedToInt())) {
                    case (Some(n), Some(m)) => return n >= m
                    case _ => return gteD(getDigits(), x.getDigits())
                }
            case (false, false) =>
                match ((checkedToInt(), x.checkedToInt())) {
                    case (Some(n), Some(m)) => n >= m
                    case _ => return gteD(x.getDigits(), getDigits())
                }
        }
    }

    @OverflowWrapping
    private static func gteD(arr0: (Array<UInt32>, Int64), arr1: (Array<UInt32>, Int64)): Bool {
        let (a0, fst0) = arr0
        let (a1, fst1) = arr1
        let s0: Int64 = a0.size - fst0
        let s1: Int64 = a1.size - fst1
        if (s0 > s1) {
            return true
        }
        if (s0 == s1) {
            for (i in 0..s0) {
                if (a0[fst0 + i] != a1[fst1 + i]) {
                    return (a0[fst0 + i] > a1[fst1 + i])
                }
            }
            return true
        }
        return false
    }

    @OverflowWrapping
    private static func eqI(a: (Array<UInt32>, Int64), n: Int64): Bool {
        eqD(a, intToDigs(n))
    }

    @OverflowWrapping
    private static func divI(a_: (Array<UInt32>, Int64), n: Int64): ((Array<UInt32>, Int64), Int64) {
        if (n == 0) {
            throw Exception("")
        }
        if (n == 1) {
            return (a_, 0)
        }
        if (n >= base) {
            let rest: ((Array<UInt32>, Int64), (Array<UInt32>, Int64)) = divD(a_, intToDigs(n))
            return (rest[0], digsToInt(rest[1]))
        }
        let (a, fst) = a_
        var rem: Int64 = 0
        let size: Int64 = a.size - fst
        let rest: Array<UInt32> = Array<UInt32>(size, item: 0)
        var newFst = 0
        for (i in 0..size) {
            let d: UInt64 = UInt64(a[i + fst]) + UInt64(rem) * UInt64(base)
            let putVal = UInt32(d / UInt64(n))
            if (newFst == i && putVal == 0 && newFst < size - 1) {
                newFst++
            }
            rest[i] = putVal
            rem = Int64(d % UInt64(n))
        }
        return ((rest, newFst), rem)
    }

    @OverflowWrapping
    private static func divD(a_0: (Array<UInt32>, Int64), a_1: (Array<UInt32>, Int64)): ((Array<UInt32>, Int64), (Array<UInt32>, 
        Int64)) {
        let (a0, fst0) = a_0
        let (a1, fst1) = a_1
        var quot: (Array<UInt32>, Int64) = (Array<UInt32>(1, item: 0), 0)
        var rem: (Array<UInt32>, Int64) = (a0.clone(), fst0)
        while (gteD(rem, a_1)) {
            var scaleFactor: Int64 = (baseLength - 1) * ((rem[0].size - rem[1]) - (a1.size - fst1))
            var num: UInt32 = rem[0][rem[1]]
            var den: UInt32 = a1[fst1]
            while (num < den) {
                den = den >> 1
                scaleFactor--
            }
            if (num > den) {
                den++
            }
            let quotPart: (Array<UInt32>, Int64) = (valueOf(Int64(num) / Int64(den)).shiftLeft(scaleFactor)).getDigits()
            rem = diffDM(rem, multD(a_1, quotPart))
            quot = addDMut(quot, quotPart)
        }
        return (quot, rem)
    }

    @OverflowWrapping
    public func shiftLeft(n: Int64): BigInt {
        if (n < 0) {
            throw Exception("")
        }
        if (n < 64 && isInt() && multiplicationIsSafe(toInt(), 1 << n)) {
            return valueOf(toInt() * (1 << n))
        } else {
            let (d, m) = (n / baseLength, n % baseLength)
            return BigInt(sign, multD(getDigits(), 2 ** UInt64(m), d))
        }
    }

    @OverflowWrapping
    private static func diffDM(a0_: (Array<UInt32>, Int64), a1_: (Array<UInt32>, Int64)): (Array<UInt32>, Int64) {
        let (a0, fst0) = a0_
        let (a1, fst1) = a1_
        let a0Size = a0.size - fst0
        let a1Size = a1.size - fst1
        var borrow: Int64 = 0
        var newFst: Int64 = a0.size - 1
        for (i in 0..a0Size) {
            let j: Int64 = a0.size - i - 1
            let n0: Int64 = Int64(a0[j]) - borrow
            var n1: Int64 = if (i < a1Size) {
                Int64(a1[a1.size - 1 - i])
            } else {
                0
            }
            if (n0 >= n1) {
                let val = n0 - n1
                a0[j] = UInt32(val)
                if (val != 0) {
                    newFst = j
                }
                borrow = 0
            } else {
                let val = n0 - n1 + base
                a0[j] = UInt32(val)
                if (val != 0) {
                    newFst = j
                }
                borrow = 1
            }
        }
        (a0, newFst)
    }

    @FastCall
    @OverflowWrapping
    private static func multD(a0: (Array<UInt32>, Int64), a1: (Array<UInt32>, Int64)): (Array<UInt32>, Int64) {
        sumordered(
            Array<(Array<UInt32>, Int64)>(
                a1[0].size - a1[1],
                {
                    item => multD(a0, Int64(a1[0][a1[0].size - item - 1]), item)
                }
            )
        )
    }

    @OverflowWrapping
    private static func multD(a_: (Array<UInt32>, Int64), d: Int64, k: Int64): (Array<UInt32>, Int64) {
        let (a, fst) = a_
        let aSize = a.size - fst
        if (d == 1) {
            let rest: Array<UInt32> = Array<UInt32>(aSize + k, item: 0)
            a.copyTo(rest, fst, 0, aSize)
            return (rest, 0)
        }
        if (d > 1) {
            let size: Int64 = aSize + k + 1
            let rest: Array<UInt32> = Array<UInt32>(size, item: 0)
            var carry: UInt64 = 0
            var newFst: Int64 = size - 1
            for (i in 0..aSize) {
                let j = a.size - i - 1
                let val: UInt64 = UInt64(a[j]) * UInt64(d) + carry
                carry = val >> baseLength
                let putVal = val & 0xFFFF_FFFF
                rest[rest.size - k - i - 1] = UInt32(putVal)
                if (putVal != 0) {
                    newFst = rest.size - k - i - 1
                }
            }
            if (carry != 0) {
                rest[0] = UInt32(carry)
                newFst = 0
            }
            return (rest, newFst)
        }
        return (Array<UInt32>(1, item: 0), 0)
    }

    @OverflowWrapping
    private static func multD(a: (Array<UInt32>, Int64), d: Int64): (Array<UInt32>, Int64) {
        multD(a, d, 0)
    }

    @OverflowWrapping
    public operator func /(n: Int64): BigInt {
        div(n)[0]
    }

    @OverflowWrapping
    private func div(n: Int64): (BigInt, BigInt) {
        if (eq(n)) {
            return (valueOf(1), valueOf(0))
        }
        var isBool0: Bool = this < n
        var isBool: Bool = sign && isBool0
        if (isBool) {
            return (valueOf(0), this)
        }
        if (isInt() && divisionIsSafe(toInt(), n)) {
            (valueOf(toInt() / n), valueOf(toInt() % n))
        }
        if (n == Int64.Min) {
            return div(BigInt(n))
        }
        var nSign: Bool = n >= 0
        var m: Int64 = if (nSign) {
            n
        } else {
            -n
        }
        let rest: ((Array<UInt32>, Int64), Int64) = divI(getDigits(), m)
        let quot: BigInt = BigInt(sign == nSign, rest[0])
        if (sign) {
            return (quot, valueOf(rest[1]))
        }
        return (quot, valueOf(-rest[1]))
    }

    @OverflowWrapping
    private func div(x: BigInt): (BigInt, BigInt) {
        if (eq(x)) {
            return (valueOf(1), valueOf(0))
        } else if (sign) {
            if (x.gt(this)) {
                return (valueOf(0), this)
            }
        }
        match ((checkedToInt(), x.checkedToInt())) {
            case (Some(n), Some(m)) =>
                if (divisionIsSafe(n, m)) {
                    return (BigInt(n / m), BigInt(n % m))
                } else {
                    return div(m)
                }
            case (None, Some(m)) => return div(m)
            case (_, _) =>
                let (xBigs, xFst): (Array<UInt32>, Int64) = x.getDigits()
                if (xBigs.size - xFst == 1) {
                    let rest: ((Array<UInt32>, Int64), Int64) = divI(getDigits(), Int64(xBigs[xFst]))
                    let quot: BigInt = BigInt(sign == x.getSign(), rest[0])
                    let rem: BigInt = if (sign) {
                        valueOf(rest[1])
                    } else {
                        valueOf(-rest[1])
                    }
                    return (quot, rem)
                }
                let rest: ((Array<UInt32>, Int64), (Array<UInt32>, Int64)) = divD(getDigits(), (xBigs, xFst))
                let quot: BigInt = BigInt(sign == x.getSign(), rest[0])
                let rem: BigInt = BigInt(sign, rest[1])
                return (quot, rem)
        }
    }

    @FastCall
    private static func divisionIsSafe(x: Int64, y: Int64): Bool {
        try {
            x / y
            true
        } catch (e: OverflowException) {
            false
        }
    }

    @OverflowWrapping
    private func gt(x: BigInt): Bool {
        match ((sign, x.getSign())) {
            case (true, false) => return true
            case (false, true) => return false
            case (true, true) =>
                match ((checkedToInt(), x.checkedToInt())) {
                    case (Some(n), Some(m)) => return n > m
                    case _ => return gtD(getDigits(), x.getDigits())
                }
            case (false, false) =>
                match ((checkedToInt(), x.checkedToInt())) {
                    case (Some(n), Some(m)) => return n > m
                    case _ => return gtD(x.getDigits(), getDigits())
                }
        }
    }

    @OverflowWrapping
    private func gt(n: Int64): Bool {
        match ((sign, checkedToInt())) {
            case (_, Some(m)) => m > n
            case (true, None) =>
                if (n < 0) {
                    true
                } else {
                    gtD(getDigits(), intToDigs(n))
                }
            case (false, None) =>
                if (n >= 0) {
                    false
                } else {
                    gtD(intToDigs(-n), getDigits())
                }
        }
    }

    @OverflowWrapping
    private func eq(x: BigInt): Bool {
        if (isZero()) {
            return x.isZero()
        }
        match {
            case (sign != x.getSign()) => false
            case _ =>
                match ((checkedToInt(), x.checkedToInt())) {
                    case (Some(n), Some(m)) => n == m
                    case (Some(n), None) => x.eq(n)
                    case (None, Some(m)) => eq(m)
                    case (None, None) => eqD(getDigits(), x.getDigits())
                }
        }
    }

    @OverflowWrapping
    private func eq(n: Int64): Bool {
        match {
            case (sign != (n >= 0)) => false
            case _ =>
                match (checkedToInt()) {
                    case Some(m) => m == n
                    case None => eqD(getDigits(), intToDigs(n))
                }
        }
    }

    @OverflowWrapping
    private func gte(n: Int64): Bool {
        match ((sign, checkedToInt())) {
            case (_, Some(m)) => m >= n
            case (true, None) =>
                if (n <= 0) {
                    true
                } else {
                    gteD(getDigits(), intToDigs(n))
                }
            case (false, None) =>
                if (n >= 0) {
                    false
                } else {
                    gteD(intToDigs(-n), getDigits())
                }
        }
    }

    @OverflowWrapping
    public operator func ==(x: BigInt): Bool {
        return eq(x)
    }

    @OverflowWrapping
    public operator func !=(x: BigInt): Bool {
        return !eq(x)
    }

    @OverflowWrapping
    private static func addD(a_: (Array<UInt32>, Int64), d: Int64): (Array<UInt32>, Int64) {
        if (d == 0) {
            return a_
        }
        let (a, fst) = a_
        if (a[fst] == 0) {
            return intToDigs(d)
        }
        let aSize: Int64 = a.size - fst
        let rest: Array<UInt32> = Array<UInt32>(aSize + 1, item: 0)
        a.copyTo(rest, fst, 1, aSize)
        var carry: UInt64 = UInt64(d)
        for (i in 0..aSize) {
            let j: Int64 = rest.size - 1 - i
            var val: UInt64 = UInt64(rest[j]) + carry
            let putVal = val & 0xFFFF_FFFF
            rest[j] = UInt32(putVal)
            carry = val >> baseLength
            if (carry == 0) {
                return (rest, 1)
            }
        }
        rest[0] = UInt32(carry)
        return (rest, 0)
    }

    @OverflowWrapping
    public operator func >=(x: BigInt): Bool {
        gte(x)
    }

    @OverflowWrapping
    public operator func <=(x: BigInt): Bool {
        x.gte(this)
    }

    @OverflowWrapping
    public operator func >=(n: Int64): Bool {
        gte(n)
    }

    @OverflowWrapping
    public operator func <=(n: Int64): Bool {
        !(this > n)
    }

    @OverflowWrapping
    public func shiftRight(n: Int64): BigInt {
        if (n < 0) {
            throw Exception("")
        }
        if (n <= 61) {
            return this / (1 << n)
        }
        return this / valueOf(n).powerOf2()
    }

    @OverflowWrapping
    public operator func <(x: BigInt): Bool {
        x.gt(this)
    }

    @OverflowWrapping
    public operator func >(x: BigInt): Bool {
        gt(x)
    }

    @OverflowWrapping
    public operator func >(n: Int64): Bool {
        gt(n)
    }

    @OverflowWrapping
    public operator func <(n: Int64): Bool {
        !gte(n)
    }

    @OverflowWrapping
    public func isNegative(): Bool {
        !sign
    }

    @OverflowWrapping
    public func powerOf2(): BigInt {
        if (isNegative()) {
            return valueOf(0)
        }
        if (isZero()) {
            return valueOf(1)
        }
        match (checkedToInt()) {
            case Some(n) =>
                if (n < 63) {
                    return valueOf(1 << n)
                } else {
                    return BigInt(true, powerOf2D(getDigits()))
                }
            case None => return BigInt(true, powerOf2D(getDigits()))
        }
    }

    @OverflowWrapping
    private static func powerOf2D(a: (Array<UInt32>, Int64)): (Array<UInt32>, Int64) {
        if (eqI(a, 0)) {
            return (Array<UInt32>(1, item: 1), 0)
        }
        let (q, r): ((Array<UInt32>, Int64), Int64) = divI(a, 61)
        let step: (Array<UInt32>, Int64) = intToDigs(2 ** 61)
        var rest: (Array<UInt32>, Int64) = intToDigs(2 ** UInt64(r))
        while (gtI(q, 0)) {
            rest = multD(rest, step)
            decrement(q[0])
        }
        return rest
    }

    @OverflowWrapping
    private static func decrement(a: Array<UInt32>): Unit {
        if (a.size > 1 || a[0] > 0) {
            var i: Int64 = a.size - 1
            while (i >= 0 && a[i] == 0) {
                a[i] = UInt32(base) - 1
                i = i - 1
            }
            a[i] = a[i] - 1
        }
    }

    @OverflowWrapping
    private static func gtI(a: (Array<UInt32>, Int64), n: Int64): Bool {
        gtD(a, intToDigs(n))
    }
}
