/*
 * @Copyright (c) Huawei Technologies Co., Ltd. 2023-2024. All rights reserved.
 */
 
package asn1

public class ASN1ParseException <: Exception {
    public init() {
        super()
    }

    public init(message: String) {
        super(message)
    }

    public init(messageFormat: String, args: Array<ToString>) {
        super(Checks.formatMessage(messageFormat, args))
    }

    public init(cause: Exception, messageFormat: String, args: Array<ToString>) {
        super(cause.message + Checks.formatMessage(messageFormat, args))
    }
}
