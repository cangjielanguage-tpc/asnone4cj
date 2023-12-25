package asn1.util

public class BigIntException <: Exception {
    public init(message: String) {
        super(message)
    }

    public override func toString(): String {
        return if (message == "") {
            return "BigIntException"
        } else {
            return "BigIntException: ${message}"
        }
    }
}