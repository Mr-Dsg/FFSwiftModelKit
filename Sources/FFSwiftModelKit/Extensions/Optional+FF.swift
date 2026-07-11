//
//  Optional+FF.swift
//  FFSwiftModelKit
//
//  Created by @F.
//  Copyright © 2026 @F. All rights reserved.
//

import Foundation

internal extension Optional {

    /// 判断 Optional 是否为空。
    var ff_isNil: Bool {

        self == nil
    }


    /// 获取包装值。
    ///
    /// - Returns:
    ///   - 有值: 返回 Wrapped
    ///   - nil: 返回 nil
    func ff_unwrapped() -> Any? {

        switch self {

        case .none:
            return nil

        case .some(let value):
            return value
        }
    }
}


internal extension Optional where Wrapped == Any {

    /// 转换为 Any。
    var ff_anyValue: Any? {

        switch self {

        case .none:
            return nil

        case .some(let value):
            return value
        }
    }
}
