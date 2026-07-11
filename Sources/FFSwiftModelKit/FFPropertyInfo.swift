//
//  FFPropertyInfo.swift
//  FFSwiftModelKit
//
//  Created by @F.
//  Copyright © 2026 @F. All rights reserved.
//

import Foundation

/// 属性详细信息。
///
/// 负责：
/// - 保存属性元数据
/// - 属性读取
/// - 属性写入
///
/// 不负责：
/// - 类型转换
/// - JSON 解析
internal final class FFPropertyInfo {

    /// 属性名称。
    let name: String

    /// 属性类型。
    let type: Any.Type

    /// 是否 Optional。
    let isOptional: Bool

    /// 属性读取闭包。
    private let getter: (Any) -> Any?

    /// 属性写入闭包。
    internal let setter: (Any, Any) -> Void


    init(
        name: String,
        type: Any.Type,
        isOptional: Bool = false,
        getter: @escaping (Any) -> Any?,
        setter: @escaping (Any, Any) -> Void
    ) {

        self.name = name
        self.type = type
        self.isOptional = isOptional
        self.getter = getter
        self.setter = setter
    }
}


// MARK: - Access

extension FFPropertyInfo {

    /// 获取属性值。
    ///
    /// - Parameter object: 对象实例
    /// - Returns: 属性值
    func value(
        from object: Any
    ) -> Any? {

        getter(object)
    }


    /// 设置属性值。
    ///
    /// - Parameters:
    ///   - value: 新值
    ///   - object: 对象实例
    func setValue(
        _ value: Any,
        on object: Any
    ) {

        setter(
            object,
            value
        )
    }
}


// MARK: - Type

extension FFPropertyInfo {

    /// 类型名称。
    var typeName: String {

        String(
            reflecting: type
        )
    }
}
