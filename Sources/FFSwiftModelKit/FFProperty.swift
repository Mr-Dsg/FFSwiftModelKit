//
//  FFProperty.swift
//  FFSwiftModelKit
//
//  Created by @F.
//  Copyright © 2026 @F. All rights reserved.
//

import Foundation

/// 属性基础描述。
///
/// 负责保存属性名称和类型信息。
/// 具体 Runtime 信息由 FFPropertyInfo 管理。
internal struct FFProperty {

    /// 属性名称。
    let name: String

    /// 属性类型。
    let type: Any.Type

    /// 是否为 Optional。
    let isOptional: Bool

    /// 初始化。
    init(
        name: String,
        type: Any.Type,
        isOptional: Bool = false
    ) {

        self.name = name
        self.type = type
        self.isOptional = isOptional
    }
}


// MARK: - Type

extension FFProperty {

    /// 类型名称。
    var typeName: String {

        String(
            reflecting: type
        )
    }
}
