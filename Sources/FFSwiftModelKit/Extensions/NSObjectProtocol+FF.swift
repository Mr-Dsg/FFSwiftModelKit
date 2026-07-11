//
//  NSObjectProtocol+FF.swift
//  FFSwiftModelKit
//
//  Created by @F.
//  Copyright © 2026 @F. All rights reserved.
//

import Foundation

internal extension NSObjectProtocol {

    /// 获取对象运行时类型名称。
    var ff_runtimeTypeName: String {

        String(
            reflecting: Swift.type(of: self)
        )
    }


    /// 判断对象是否为指定类型。
    ///
    /// - Parameter type: 目标类型
    /// - Returns: 是否匹配
    func ff_isType(
        _ type: Any.Type
    ) -> Bool {

        Swift.type(
            of: self
        ) == type
    }
}
