//
//  Array+FF.swift
//  FFSwiftModelKit
//
//  Created by @F.
//  Copyright © 2026 @F. All rights reserved.
//

import Foundation

internal extension Array {

    /// 转换为 Any 数组。
    ///
    /// 用于 JSON / Encoder 输出。
    var ff_anyArray: [Any] {

        map {
            $0
        }
    }
}


internal extension Array where Element == Any {

    /// 判断数组是否为空 JSON 数组。
    var ff_isEmptyJSON: Bool {

        isEmpty
    }


    /// 安全获取元素。
    ///
    /// - Parameter index: 下标
    /// - Returns: 元素
    func ff_safe(
        index: Int
    ) -> Any? {

        guard indices.contains(index) else {
            return nil
        }

        return self[index]
    }
}
