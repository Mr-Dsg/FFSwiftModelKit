//
//  Dictionary+FF.swift
//  FFSwiftModelKit
//
//  Created by @F.
//  Copyright © 2026 @F. All rights reserved.
//

import Foundation

internal extension Dictionary {

    /// 转换为 Any 字典。
    ///
    /// 用于 JSON / Encoder 输出。
    var ff_anyDictionary: [AnyHashable: Any] {

        var result: [AnyHashable: Any] = [:]

        forEach { key, value in

            result[key as AnyHashable] = value
        }

        return result
    }
}


internal extension Dictionary where Key == String, Value == Any {

    /// 判断是否为 JSON Object。
    var ff_isJSONObject: Bool {

        JSONSerialization.isValidJSONObject(
            self
        )
    }


    /// 安全获取值。
    ///
    /// - Parameter key: Key
    /// - Returns: Value
    func ff_safe(
        key: String
    ) -> Any? {

        self[key]
    }


    /// 合并字典。
    ///
    /// 已存在 Key 保留当前值。
    ///
    /// - Parameter other: 需要合并的数据
    mutating func ff_merge(
        _ other: [String: Any]
    ) {

        merge(
            other
        ) { current, _ in

            current
        }
    }
}
