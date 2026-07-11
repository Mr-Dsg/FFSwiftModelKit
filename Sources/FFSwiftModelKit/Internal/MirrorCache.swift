//
//  MirrorCache.swift
//  FFSwiftModelKit
//
//  Created by @F.
//  Copyright © 2026 @F. All rights reserved.
//

import Foundation

/// Mirror 属性缓存。
///
/// 负责：
/// - 通过 Mirror 获取 Model 属性
/// - 缓存属性描述
///
/// 不负责：
/// - JSON 转换
/// - 类型转换
/// - 属性赋值
internal final class MirrorCache: @unchecked Sendable {

    // MARK: - Singleton

    static let shared = MirrorCache()


    private init() {}


    // MARK: - Cache

    private var cache: [ObjectIdentifier: [FFPropertyInfo]] = [:]

    private let lock = NSLock()


    // MARK: - Properties

    /// 获取类型属性。
    ///
    /// - Parameter type: 类型
    /// - Returns: 属性列表
    func properties(
        for type: Any.Type
    ) -> [FFPropertyInfo] {

        let identifier = ObjectIdentifier(
            type
        )


        lock.lock()

        if let properties = cache[identifier] {

            lock.unlock()

            return properties
        }

        lock.unlock()


        let properties = buildProperties(
            for: type
        )


        lock.lock()

        cache[identifier] = properties

        lock.unlock()


        return properties
    }


    // MARK: - Build

    private func buildProperties(
        for type: Any.Type
    ) -> [FFPropertyInfo] {

        let instance = createInstance(
            type
        )


        guard let instance else {
            return []
        }


        let mirror = Mirror(
            reflecting: instance
        )


        var result: [FFPropertyInfo] = []


        for child in mirror.children {

            guard let label = child.label else {
                continue
            }


            let value = child.value

            let propertyType = Swift.type(
                of: value
            )


            let isOptional =
                Mirror(
                    reflecting: value
                ).displayStyle == .optional


            let property = FFPropertyInfo(

                name: label,

                type: propertyType,

                isOptional: isOptional,

                getter: { object in

                    if let accessor = object as? FFModelAccessor {

                        return accessor.ff_get(
                            valueFor: label
                        )
                    }
                    
                    let mirror = Mirror(
                        reflecting: object
                    )

                    for item in mirror.children {

                        if item.label == label {

                            return FFAny.unwrap(
                                item.value
                            )
                        }
                    }

                    return nil
                },

                setter: { object, value in

                    PropertySetter.set(
                        object: object,
                        name: label,
                        value: value
                    )
                }
            )


            result.append(property)
        }


        return result
    }


    // MARK: - Instance

    private func createInstance(
        _ type: Any.Type
    ) -> Any? {

        guard let modelType = type as? FFModel.Type else {
            return nil
        }

        return modelType.init()
    }


    // MARK: - Clear

    func clear() {

        lock.lock()

        cache.removeAll()

        lock.unlock()
    }
}
