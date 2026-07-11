//
//  UnsafeCast.swift
//  FFSwiftModelKit
//
//  Created by @F.
//  Copyright © 2026 @F. All rights reserved.
//

import Foundation

/// 不安全转换工具。
///
/// 负责：
/// - 底层类型快速转换
/// - 避免重复的类型判断
///
/// 使用范围：
/// - Runtime
/// - Property Setter
///
/// 注意：
/// 调用方必须保证类型安全。
internal enum UnsafeCast {

    // MARK: - Cast

    /// 强制转换。
    @inline(__always)
    static func cast<T>(
        _ value: Any
    ) -> T {

        value as! T
    }


    /// 安全转换。
    @inline(__always)
    static func castIfPossible<T>(
        _ value: Any
    ) -> T? {

        value as? T
    }


    // MARK: - Pointer

    /// 转换为 UnsafeRawPointer。
    ///
    /// 用于底层 Runtime 操作。
    @inline(__always)
    static func pointer<T>(
        _ value: inout T
    ) -> UnsafeMutableRawPointer {

        withUnsafeMutablePointer(
            to: &value
        ) {
            UnsafeMutableRawPointer($0)
        }
    }


    // MARK: - Object

    /// AnyObject 转换。
    @inline(__always)
    static func object(
        _ value: Any
    ) -> AnyObject? {

        value as AnyObject
    }
}
