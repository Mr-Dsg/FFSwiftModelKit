//
//  FFRuntime.swift
//  FFSwiftModelKit
//
//  Created by @F.
//  Copyright © 2026 @F. All rights reserved.
//

import Foundation

/// Runtime 工具。
///
/// 负责：
/// - 获取类型信息
/// - 获取类信息
/// - Objective-C Runtime 辅助
///
/// 不负责：
/// - Model 转换
/// - JSON 处理
/// - 属性赋值
internal enum FFRuntime {

    // MARK: - Class

    /// 获取实例类型。
    @inline(__always)
    static func classType(
        of object: Any
    ) -> AnyClass? {

        Swift.type(
            of: object
        ) as? AnyClass
    }


    /// 判断是否为类对象。
    @inline(__always)
    static func isClass(
        _ type: Any.Type
    ) -> Bool {

        type is AnyClass
    }


    // MARK: - Name

    /// 获取类型名称。
    @inline(__always)
    static func typeName(
        _ type: Any.Type
    ) -> String {

        String(
            reflecting: type
        )
    }


    /// 获取简单类型名称。
    @inline(__always)
    static func shortTypeName(
        _ type: Any.Type
    ) -> String {

        String(
            describing: type
        )
    }


    // MARK: - NSObject

    /// 是否继承 NSObject。
    @inline(__always)
    static func inheritsNSObject(
        _ type: Any.Type
    ) -> Bool {

        guard let classType = type as? AnyClass else {
            return false
        }

        return classType.isSubclass(
            of: NSObject.self
        )
    }
}
