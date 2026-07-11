//
//  NSObject+FF.swift
//  FFSwiftModelKit
//
//  Created by @F.
//  Copyright © 2026 @F. All rights reserved.
//

import Foundation

internal extension NSObject {

    /// 获取对象类型名称。
    var ff_typeName: String {

        String(
            reflecting: type(of: self)
        )
    }


    /// 获取 Objective-C 类名。
    var ff_className: String {

        NSStringFromClass(
            type(of: self)
        )
    }


    /// 判断对象是否属于指定类型。
    ///
    /// - Parameter type: 类型
    /// - Returns: 是否匹配
    func ff_isKind(
        of type: AnyClass
    ) -> Bool {

        isKind(
            of: type
        )
    }


    /// 获取所有属性名称。
    ///
    /// 通过 Runtime 获取。
    var ff_propertyNames: [String] {

        var result: [String] = []

        var count: UInt32 = 0

        guard let properties = class_copyPropertyList(
            type(of: self),
            &count
        ) else {

            return result
        }

        defer {
            free(properties)
        }


        for index in 0..<Int(count) {

            let property = properties[index]

            let name = String(
                cString: property_getName(property)
            )

            result.append(name)
        }


        return result
    }
}
