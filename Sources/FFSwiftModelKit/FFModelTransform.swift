//
//  FFModelTransform.swift
//  FFSwiftModelKit
//
//  Created by @F.
//  Copyright © 2026 @F. All rights reserved.
//

import Foundation

/// Model 转换协议。
///
/// 用于支持自定义类型转换。
///
/// 默认情况下框架会自动处理：
/// - 基础类型
/// - Optional
/// - Array
/// - Dictionary
/// - NSObject
/// - FFModel
///
/// 对于特殊类型，可以通过实现该协议扩展。
public protocol FFModelTransform {

    /// 原始数据转换为当前类型。
    ///
    /// - Parameter value: JSON 中的原始值
    /// - Returns: 转换后的对象
    static func ff_transform(
        from value: Any
    ) -> Self?

    /// 当前对象转换为输出数据。
    ///
    /// - Returns: 输出值
    func ff_transformValue() -> Any
}


// MARK: - Default

public extension FFModelTransform {

    func ff_transformValue() -> Any {

        self
    }
}


// MARK: - Foundation Support

extension Date: FFModelTransform {

    public static func ff_transform(
        from value: Any
    ) -> Date? {

        switch value {

        case let date as Date:
            return date

        case let interval as TimeInterval:
            return Date(
                timeIntervalSince1970: interval
            )

        case let number as NSNumber:
            return Date(
                timeIntervalSince1970: number.doubleValue
            )

        case let string as String:

            let formatter = ISO8601DateFormatter()

            return formatter.date(
                from: string
            )

        default:
            return nil
        }
    }


    public func ff_transformValue() -> Any {

        timeIntervalSince1970
    }
}


extension URL: FFModelTransform {

    public static func ff_transform(
        from value: Any
    ) -> URL? {

        switch value {

        case let url as URL:
            return url

        case let string as String:
            return URL(
                string: string
            )

        default:
            return nil
        }
    }


    public func ff_transformValue() -> Any {

        absoluteString
    }
}
