package asn1

from std import format.*

public class ASN1ParseException <: Exception {
    public init() {
        super()
    }

    public init(message: String) {
        super(message)
    }

    public init(messageFormat: String, args: Array<Formatter>) {
        super(formatMessage(messageFormat, args))
    }

    public init(cause: Exception, messageFormat: String, args: Array<Formatter>) {
        super(cause.message + formatMessage(messageFormat, args))
    }

    func formatMessage(messageFormat: String, args: Array<Formatter>): String {
        var message: String = ""
        for (arg in args) {
            message = message + arg.format(messageFormat)
        }
        return message
    }
}