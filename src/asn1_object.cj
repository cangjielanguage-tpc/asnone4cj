/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2023-2024. All rights reserved.
 */
 
package asn1

public abstract class ASN1Object <: Hashable & Equatable<ASN1Object> & ToString {
    protected var tag: ASN1Tag

    protected init(tag: ASN1Tag) {
        this.tag = tag
    }

    public func getValue(): Any

    public func equals(o: Object): Bool {
        if (refEq(this, o)) {
            return true
        }
        match (o as ASN1Object) {
            case Some(that) =>
                // tag 按值语义比较（ASN1Tag.equals 内部有引用快路径），
                // 不能用 refEq：contextSpecific/application 的 tag 每次构造返回新实例
                if (!this.tag.equals(that.tag)) {
                    return false
                }
                return this.valueEquals(that)
            case None => return false
        }
    }

    // 值相等比较：默认按值字符串比较，子类可覆写为类型化比较
    protected open func valueEquals(other: ASN1Object): Bool {
        return this.valueString() == other.valueString()
    }

    public func hashCode(): Int64 {
        var result: Int64 = tag.getTag()
        return result
    }

    public open func toString(): String {
        return "ASN1Object" + "[" + valueString() + "]"
    }

    protected open func valueString(): String {
        return tag.toString()
    }

    public func getTag(): ASN1Tag {
        return tag
    }

    public operator func ==(that: ASN1Object): Bool {
        return this.equals(that)
    }

    public operator func !=(that: ASN1Object): Bool {
        return !(this == that)
    }
}
