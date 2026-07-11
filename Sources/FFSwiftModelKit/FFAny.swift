//
//  FFAny.swift
//  FFSwiftModelKit
//
//  Created by @F.
//  Copyright © 2026 @F. All rights reserved.
//

import Foundation

/// Any 工具。
///
/// 负责：
/// - Optional 判断与解包
/// - Foundation 类型桥接
/// - 类型信息获取
/// - 基础类型判断
///
/// 不负责：
/// - JSON 解析
/// - Model 转换
/// - Runtime
internal enum FFAny {

    // MARK: - Optional

    /// 判断一个值是否为 nil（包含 Optional.none）。
    @inline(__always)
    static func isNil(_ value: Any?) -> Bool {

        guard let value else {
            return true
        }

        let mirror = Mirror(reflecting: value)

        guard mirror.displayStyle == .optional else {
            return false
        }

        return mirror.children.isEmpty
    }

    /// 解包 Optional。
    ///
    /// 非 Optional 类型会直接返回自身。
    @inline(__always)
    static func unwrap(_ value: Any?) -> Any? {

        guard let value else {
            return nil
        }

        let mirror = Mirror(reflecting: value)

        guard mirror.displayStyle == .optional else {
            return value
        }

        return mirror.children.first?.value
    }

    // MARK: - Collection

    /// 是否为数组类型。
    @inline(__always)
    static func isArray(_ value: Any) -> Bool {
        Mirror(reflecting: value).displayStyle == .collection
    }

    /// 是否为字典类型。
    @inline(__always)
    static func isDictionary(_ value: Any) -> Bool {
        Mirror(reflecting: value).displayStyle == .dictionary
    }

    /// 是否为集合类型（Set）。
    @inline(__always)
    static func isSet(_ value: Any) -> Bool {
        Mirror(reflecting: value).displayStyle == .set
    }

    // MARK: - NSObject

    @inline(__always)
    static func isNSObject(_ value: Any) -> Bool {
        value is NSObject
    }

    // MARK: - Foundation

    @inline(__always)
    static func isNSNumber(_ value: Any) -> Bool {
        value is NSNumber
    }

    @inline(__always)
    static func isNSString(_ value: Any) -> Bool {
        value is NSString
    }

    @inline(__always)
    static func isNSDate(_ value: Any) -> Bool {
        value is NSDate
    }

    @inline(__always)
    static func isNSURL(_ value: Any) -> Bool {
        value is NSURL
    }

    // MARK: - Bridge

    /// Foundation -> Swift 基础类型桥接。
    @inline(__always)
    static func bridge(_ value: Any) -> Any {

        switch value {

        case let string as NSString:
            return String(string)

        case let number as NSNumber:
            return number

        case let date as NSDate:
            return date as Date

        case let url as NSURL:
            return url as URL

        default:
            return value
        }
    }

    // MARK: - Cast

    /// 安全类型转换。
    @inline(__always)
    static func cast<T>(_ value: Any?) -> T? {

        guard let value = unwrap(value) else {
            return nil
        }

        return value as? T
    }

    // MARK: - Type

    /// 获取运行时类型。
    @inline(__always)
    static func type(of value: Any) -> Any.Type {
        Swift.type(of: value)
    }

    /// 获取类型名称。
    @inline(__always)
    static func typeName(of value: Any) -> String {
        String(reflecting: Swift.type(of: value))
    }
}
