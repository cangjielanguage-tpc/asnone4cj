package asn1.util

public class Checks {
    private init() {}

    public static func checkState(state: Bool, messageFormat: String, args: Array<ToString>) {
        if (!state) {
            throw Exception(formatMessage(messageFormat, args))
        }
    }

    public static func checkArgument(bool: Bool, messageFormat: String, args: Array<ToString>) {
        if (!bool) {
            throw IllegalArgumentException(formatMessage(messageFormat, args))
        }
    }

    static func formatMessage(messageFormat: String, args: Array<ToString>): String {
        var message: String = "IllegalStateException:" + messageFormat
        for (arg in args) {
            message = message + arg.toString()
        }
        return message
    }
}
