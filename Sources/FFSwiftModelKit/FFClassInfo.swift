//
//  FFClassInfo.swift
//  FFSwiftModelKit
//
//  Created by @F.
//  Copyright © 2026 @F. All rights reserved.
//

import Foundation

/// Class 信息缓存对象。
///
/// 负责保存一个 Model 类型的属性描述。
///
/// 不负责：
/// - JSON 转换
/// - 属性赋值
/// - 类型转换
internal final class FFClassInfo {

    /// Model 类型。
    let type: Any.Type

    /// 属性列表。
    let properties: [FFPropertyInfo]


    init(
        type: Any.Type
    ) {

        self.type = type

        self.properties = FFCache.shared.propertyInfo(
            for: type
        )
    }
}


// MARK: - Information

extension FFClassInfo {

    /// 类型名称。
    var typeName: String {

        String(
            reflecting: type
        )
    }


    /// 属性数量。
    var propertyCount: Int {

        properties.count
    }
}
