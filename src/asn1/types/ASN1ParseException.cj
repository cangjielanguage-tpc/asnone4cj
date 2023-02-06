package asn1.types

public class ASN1ParseException <: Exception {
    public init() {
        super()
    }

    public init(message: String) {
        super(message)
    }

    public init(messageFormat: String, args: Array<ToString>) {
        super(formatMessage(messageFormat, args))
    }

    public init(cause: Exception, messageFormat: String, args: Array<ToString>) {
        super(cause.message + formatMessage(messageFormat, args))
    }

    func formatMessage(messageFormat: String, args: Array<ToString>): String {
        var message: String = messageFormat
        for (arg in args) {
            message = message + args.toString()
        }
        return message
    }
}