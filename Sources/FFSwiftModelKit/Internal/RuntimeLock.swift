//
//  RuntimeLock.swift
//  FFSwiftModelKit
//
//  Created by @F.
//  Copyright © 2026 @F. All rights reserved.
//

import Foundation

/// Runtime 操作锁。
///
/// 用于保护：
/// - 类型缓存
/// - 属性缓存
/// - Runtime 查询
///
/// 保证多线程环境下缓存安全。
internal final class RuntimeLock: @unchecked Sendable {

    // MARK: - Singleton

    static let shared = RuntimeLock()


    private init() {}


    // MARK: - Lock

    private let lock = NSRecursiveLock()


    // MARK: - Execute

    /// 同步执行代码。
    ///
    /// - Parameter block: 执行内容
    /// - Returns: 返回值
    @inline(__always)
    func sync<T>(
        _ block: () throws -> T
    ) rethrows -> T {

        lock.lock()

        defer {
            lock.unlock()
        }

        return try block()
    }


    /// 异步安全读取。
    ///
    /// 当前内部缓存均为同步访问，
    /// 此方法用于统一入口。
    @inline(__always)
    func read<T>(
        _ block: () throws -> T
    ) rethrows -> T {

        try sync(block)
    }


    /// 异步安全写入。
    ///
    /// 当前内部缓存均为同步访问，
    /// 此方法用于统一入口。
    @inline(__always)
    func write<T>(
        _ block: () throws -> T
    ) rethrows -> T {

        try sync(block)
    }
}
