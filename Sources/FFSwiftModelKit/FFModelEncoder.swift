//
//  FFModelEncoder.swift
//  FFSwiftModelKit
//
//  Created by @F.
//  Copyright © 2026 @F. All rights reserved.
//

import Foundation

/// Model 编码器。
///
/// 负责：
/// - Model -> Dictionary<String, Any>
/// - 属性读取
/// - 类型转换输出
///
/// 不负责：
/// - JSON 序列化
/// - 网络请求
/// - 文件存储
public enum FFModelEncoder {

    // MARK: - Encode

    /// Model 转字典。
    ///
    /// - Parameter model: Model 对象
    /// - Returns: Dictionary
    public static func encode<T: FFModel>(
        _ model: T
    ) -> [String: Any] {

        let classInfo = FFClassInfo(
            type: T.self
        )

        var result: [String: Any] = [:]

        for property in classInfo.properties {

            guard let value = property.value(
                from: model
            ) else {
                continue
            }

            let encodedValue = FFValueConverter.encode(
                value
            )

            result[property.name] = encodedValue
        }

        return result
    }


    /// Model 数组转字典数组。
    ///
    /// - Parameter models: Model 数组
    /// - Returns: 字典数组
    public static func encode<T: FFModel>(
        _ models: [T]
    ) -> [[String: Any]] {

        models.map {
            encode($0)
        }
    }


    /// 任意 Model 对象转换。
    ///
    /// 用于嵌套 Model。
    ///
    /// - Parameter value: 任意值
    /// - Returns: 可输出对象
    public static func encodeValue(
        _ value: Any
    ) -> Any {

        FFValueConverter.encode(
            value
        )
    }
}
