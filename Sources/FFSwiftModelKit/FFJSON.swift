//
//  FFJSON.swift
//  FFSwiftModelKit
//
//  Created by @F.
//  Copyright © 2026 @F. All rights reserved.
//

import Foundation

/// JSON 工具类。
///
/// 负责：
/// - JSON Data 与 Foundation Object 之间转换
/// - JSON 字符串处理
///
/// 内部统一使用：
///// - Dictionary<String, Any>
/// - Array<Any>
///
/// 不负责：
///// - Model 转换
/// - 属性映射
/// - 类型转换
public enum FFJSON {

    // MARK: - Decode

    /// Data 转 JSON Object。
    ///
    /// - Parameter data: JSON 数据
    /// - Returns: Dictionary 或 Array
    /// - Throws: FFModelError
    public static func object(from data: Data) throws -> Any {

        do {

            return try JSONSerialization.jsonObject(
                with: data,
                options: []
            )

        } catch {

            throw FFModelError.invalidJSONData
        }
    }

    /// Data 转字典。
    ///
    /// - Parameter data: JSON 数据
    /// - Returns: [String: Any]
    /// - Throws: FFModelError
    public static func dictionary(from data: Data) throws -> [String: Any] {

        let object = try object(from: data)

        guard let dictionary = object as? [String: Any] else {

            throw FFModelError.invalidJSONObject
        }

        return dictionary
    }

    /// Data 转数组。
    ///
    /// - Parameter data: JSON 数据
    /// - Returns: [Any]
    /// - Throws: FFModelError
    public static func array(from data: Data) throws -> [Any] {

        let object = try object(from: data)

        guard let array = object as? [Any] else {

            throw FFModelError.invalidJSONArray
        }

        return array
    }

    // MARK: - Encode

    /// JSON Object 转 Data。
    ///
    /// - Parameter object: JSON 对象
    /// - Returns: Data
    /// - Throws: FFModelError
    public static func data(from object: Any) throws -> Data {

        guard JSONSerialization.isValidJSONObject(object) else {

            throw FFModelError.invalidJSONObject
        }

        do {

            return try JSONSerialization.data(
                withJSONObject: object,
                options: []
            )

        } catch {

            throw FFModelError.invalidJSONObject
        }
    }

    // MARK: - String

    /// Data 转 JSON 字符串。
    ///
    /// - Parameter data: JSON 数据
    /// - Returns: String
    public static func string(from data: Data) -> String? {

        String(
            data: data,
            encoding: .utf8
        )
    }

    /// JSON Object 转字符串。
    ///
    /// - Parameter object: JSON 对象
    /// - Returns: String
    /// - Throws: FFModelError
    public static func string(from object: Any) throws -> String? {

        let data = try self.data(from: object)

        return string(from: data)
    }

    // MARK: - Pretty

    /// JSON 美化输出。
    ///
    /// - Parameter object: JSON 对象
    /// - Returns: Data
    /// - Throws: FFModelError
    public static func prettyData(from object: Any) throws -> Data {

        guard JSONSerialization.isValidJSONObject(object) else {

            throw FFModelError.invalidJSONObject
        }

        do {

            return try JSONSerialization.data(
                withJSONObject: object,
                options: [
                    .prettyPrinted,
                    .sortedKeys
                ]
            )

        } catch {

            throw FFModelError.invalidJSONObject
        }
    }
}
