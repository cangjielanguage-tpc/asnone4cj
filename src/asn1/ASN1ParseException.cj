package asn1

public class ASN1ParseException <: Exception {
    public init() {
        super()
    }

    public init(message: String) {
        super(message)
    }

    public init(message: String, args: Array<Any>) {
        // TODO
        super(message)
    }

    public init(cause: Any, message: String, args: Array<Any>) {
        // TODO
        super(message)
    }
}
