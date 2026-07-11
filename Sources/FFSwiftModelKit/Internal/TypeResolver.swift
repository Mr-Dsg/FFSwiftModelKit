//
//  TypeResolver.swift
//  FFSwiftModelKit
//
//  Created by @F.
//  Copyright © 2026 @F. All rights reserved.
//

import Foundation

/// 类型解析器。
///
/// 负责：
/// - 类型名称解析
/// - Optional 类型判断
/// - 集合类型判断
///
/// 不负责：
/// - 数据转换
/// - Model 创建
internal enum TypeResolver {

    // MARK: - Optional

    /// 判断类型是否为 Optional。
    ///
    /// - Parameter type: 类型
    /// - Returns: 是否 Optional
    static func isOptional(
        _ type: Any.Type
    ) -> Bool {

        Mirror(
            reflecting: type
        ).displayStyle == .optional
    }


    /// 获取 Optional 包装类型。
    ///
    /// - Parameter type: 类型
    /// - Returns: Wrapped 类型
    static func optionalWrappedType(
        _ type: Any.Type
    ) -> Any.Type? {

        guard isOptional(type) else {
            return nil
        }

        return type
    }


    // MARK: - Collection

    /// 判断是否为数组类型。
    static func isArray(
        _ type: Any.Type
    ) -> Bool {

        String(
            describing: type
        ).hasPrefix("[")
    }


    /// 判断是否为字典类型。
    static func isDictionary(
        _ type: Any.Type
    ) -> Bool {

        String(
            describing: type
        ).hasPrefix("[")
        &&
        String(
            describing: type
        ).contains(":")
    }


    // MARK: - Name

    /// 获取类型名称。
    static func name(
        of type: Any.Type
    ) -> String {

        String(
            reflecting: type
        )
    }


    /// 获取简短类型名称。
    static func shortName(
        of type: Any.Type
    ) -> String {

        String(
            describing: type
        )
    }
}
