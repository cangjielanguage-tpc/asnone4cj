package asn1.util

from std import format.*

public class Checks {
    private init() {}

    public static func checkState(state: Bool, messageFormat: String, args: Array<Formatter>) {
        if (!state) {
            throw IllegalArgumentException(formatMessage(messageFormat,args))
        }
    }

    public static func checkArgument(bool: Bool, messageFormat: String, args: Array<Formatter>) {
        if (!bool) {
            throw IllegalArgumentException(formatMessage(messageFormat,args))
        }
    }

    static func formatMessage(messageFormat: String, args: Array<Formatter>): String {
        var message: String = ""
        for (arg in args) {
            message = message + arg.format(messageFormat)
        }
        return message
    }
}
