//
//  FFCache.swift
//  FFSwiftModelKit
//
//  Created by @F.
//  Copyright © 2026 @F. All rights reserved.
//

import Foundation

/// FFSwiftModelKit 缓存中心。
///
/// 负责缓存：
/// - ClassInfo
/// - PropertyInfo
///
/// 目的：
/// - 避免重复 Runtime / Mirror 解析
/// - 提升 Model 转换性能
internal final class FFCache: @unchecked Sendable {

    // MARK: - Singleton

    static let shared = FFCache()


    private init() {}

    
    // MARK: - Storage

    private var classCache: [ObjectIdentifier: FFClassInfo] = [:]

    private let lock = NSLock()


    // MARK: - ClassInfo

    /// 获取 Class 信息。
    ///
    /// - Parameter type: 类型
    /// - Returns: ClassInfo
    func classInfo(
        for type: Any.Type
    ) -> FFClassInfo {

        let key = ObjectIdentifier(
            type as Any.Type
        )

        lock.lock()
        defer {
            lock.unlock()
        }

        if let cache = classCache[key] {
            return cache
        }

        let info = FFClassInfo(
            type: type
        )

        classCache[key] = info

        return info
    }


    // MARK: - Property

    /// 获取属性信息。
    ///
    /// - Parameter type: 类型
    /// - Returns: 属性列表
    func propertyInfo(
        for type: Any.Type
    ) -> [FFPropertyInfo] {

        MirrorCache.shared.properties(
            for: type
        )
    }


    // MARK: - Clear

    /// 清理缓存。
    func clear() {

        lock.lock()

        classCache.removeAll()

        lock.unlock()
    }
}
