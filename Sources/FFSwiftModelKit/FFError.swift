//
//  FFError.swift
//  FFSwiftModelKit
//
//  Created by @F.
//  Copyright © 2026 @F. All rights reserved.
//

import Foundation

/// FFSwiftModelKit 错误类型。
public enum FFModelError: Error, LocalizedError {

    /// 无效的 JSON 对象。
    case invalidJSONObject

    /// 无效的 JSON 数组。
    case invalidJSONArray

    /// JSON 数据解析失败。
    case invalidJSONData

    /// JSON 字符串编码失败。
    case invalidJSONString

    /// 不支持的类型。
    case unsupportedType(Any.Type)

    /// 类型不匹配。
    case typeMismatch(
        expected: Any.Type,
        actual: Any.Type
    )

    /// 找不到指定属性。
    case propertyNotFound(String)

    /// 自定义错误。
    case custom(String)

    public var errorDescription: String? {

        switch self {

        case .invalidJSONObject:
            return "The JSON object is invalid."

        case .invalidJSONArray:
            return "The JSON array is invalid."

        case .invalidJSONData:
            return "The JSON data is invalid."

        case .invalidJSONString:
            return "The JSON string is invalid."

        case .unsupportedType(let type):
            return "Unsupported type: \(String(describing: type))."

        case .typeMismatch(let expected, let actual):
            return """
            Type mismatch.
            Expected: \(String(describing: expected))
            Actual: \(String(describing: actual))
            """

        case .propertyNotFound(let name):
            return "Property '\(name)' was not found."

        case .custom(let message):
            return message
        }
    }
}
