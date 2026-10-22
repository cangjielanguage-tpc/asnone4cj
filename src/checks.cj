/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2023-2024. All rights reserved.
 */

package asn1

public class Checks {
    private init() {}

    public static func checkState(state: Bool, messageFormat: String, args: Array<ToString>) {
        if (!state) {
            throw Exception("IllegalStateException:" + formatMessage(messageFormat, args))
        }
    }

    public static func checkArgument(bool: Bool, messageFormat: String, args: Array<ToString>) {
        if (!bool) {
            throw IllegalArgumentException("IllegalArgumentException:" + formatMessage(messageFormat, args))
        }
    }

    static func formatMessage(messageFormat: String, args: Array<ToString>): String {
        // 仅在存在 %s 占位符时按顺序消费 args；
        // 无占位符时不触碰 args，避免对未初始化元素调用 toString
        var parts: Array<String> = messageFormat.split("%s")
        var message: StringBuilder = StringBuilder()
        var argIndex: Int64 = 0
        for (i in 0..parts.size) {
            message.append(parts[i])
            if (i + 1 < parts.size && argIndex < args.size) {
                message.append(args[argIndex])
                argIndex++
            }
        }
        return message.toString()
    }
}
