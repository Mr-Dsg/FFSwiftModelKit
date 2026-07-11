//
//  PropertySetter.swift
//  FFSwiftModelKit
//
//  Created by @F.
//  Copyright © 2026 @F. All rights reserved.
//

import Foundation


/// Swift 属性写入器。
///
/// 负责：
/// - Runtime 修改 var 属性
/// - Model Decode 赋值
internal enum PropertySetter {


    /// 设置属性。
    ///
    /// - Parameters:
    ///   - object: Model对象
    ///   - name: 属性名称
    ///   - value: 新值
    static func set(
        object: Any,
        name: String,
        value: Any
    ) {


        guard let object = object as AnyObject? else {
            return
        }


        let mirror = Mirror(
            reflecting: object
        )


        var currentMirror: Mirror? = mirror


        while let mirror = currentMirror {


            for child in mirror.children {

                guard child.label == name else {
                    continue
                }


                let keyPath = name


                setValue(
                    object,
                    key: keyPath,
                    value: value
                )


                return
            }


            currentMirror = mirror.superclassMirror
        }
    }



    private static func setValue(
        _ object: AnyObject,
        key: String,
        value: Any
    ) {

        if let accessor = object as? FFModelAccessor {

            accessor.ff_set(
                value: value,
                for: key
            )
        }
    }
}
