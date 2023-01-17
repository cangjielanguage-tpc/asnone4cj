package asn1.util

public class Checks {
    private init() {}

    public static func checkState(state: Bool, messageFormat: String, args: Array<Any>) {
        if (!state) {
            // TODO
            throw IllegalArgumentException("")
        }
    }

    public static func checkArgument(bool: Bool, messageFormat: String, args: Array<Any>) {
        if (!bool) {
            // TODO
            throw IllegalArgumentException("")
        }
    }
}
