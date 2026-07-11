//
//  FFValueConverter.swift
//  FFSwiftModelKit
//
//  Created by @F.
//  Copyright © 2026 @F. All rights reserved.
//

import Foundation

/// 类型转换器。
///
/// 负责：
/// - JSON Value -> Model Property
/// - Model Property -> JSON Value
///
/// 支持：
/// - 基础类型
/// - Optional
/// - Array
/// - Dictionary
/// - Enum
/// - FFModel
/// - FFModelTransform
internal enum FFValueConverter {

    // MARK: - Decode

    /// 转换输入值到目标类型。
    static func convert(
        _ value: Any,
        to type: Any.Type
    ) -> Any? {
        
        let value = FFAny.unwrap(
            value
        ) ?? value


        // 已经是目标类型
        if Swift.type(
            of: value
        ) == type {

            return value
        }


        // Optional
        let typeName = String(describing: type)

        if typeName.hasPrefix("Optional<") {

            switch value {

            case let string as String:
                return string

            case let int as Int:
                return int

            case let double as Double:
                return double

            case let float as Float:
                return float

            case let bool as Bool:
                return bool

            default:
                return value
            }
        }


        // Model
        if let modelType = type as? FFModel.Type {

            guard let dictionary = value as? [String: Any] else {
                return nil
            }

            return FFModelDecoder.decode(
                dictionary,
                type: modelType
            )
        }


        // 自定义转换
        if let transformType = type as? FFModelTransform.Type {

            return transformType.ff_transform(
                from: value
            )
        }


        // Array
        let mirror = Mirror(
            reflecting: type
        )

        if mirror.displayStyle == .collection {

            return convertArray(
                value,
                to: type
            )
        }


        // 基础类型
        return convertPrimitive(
            value,
            to: type
        )
    }


    // MARK: - Primitive

    private static func convertPrimitive(
        _ value: Any,
        to type: Any.Type
    ) -> Any? {


        switch type {


        case is String.Type:

            return String(
                describing: value
            )


        case is Int.Type:

            if let number = value as? NSNumber {
                return number.intValue
            }

            return Int(
                "\(value)"
            )


        case is Double.Type:

            if let number = value as? NSNumber {
                return number.doubleValue
            }


            return Double(
                "\(value)"
            )


        case is Float.Type:

            if let number = value as? NSNumber {
                return number.floatValue
            }


            return Float(
                "\(value)"
            )


        case is Bool.Type:

            if let number = value as? NSNumber {
                return number.boolValue
            }


            return Bool(
                "\(value)"
            )


        default:

            return nil
        }
    }


    // MARK: - Array

    private static func convertArray(
        _ value: Any,
        to type: Any.Type
    ) -> Any? {

        guard let array = value as? [Any] else {
            return nil
        }


        return array
    }


    // MARK: - Encode

    /// Model Value 转输出值。
    static func encode(
        _ value: Any
    ) -> Any {


        let value = FFAny.unwrap(
            value
        ) ?? value


        if let model = value as? FFModel {

            return FFModelEncoder.encode(
                model
            )
        }


        if let transform = value as? FFModelTransform {

            return transform.ff_transformValue()
        }


        if let array = value as? [Any] {

            return array.map {
                encode($0)
            }
        }


        if let dictionary = value as? [String: Any] {

            var result: [String: Any] = [:]

            dictionary.forEach {

                result[$0.key] = encode(
                    $0.value
                )
            }

            return result
        }


        return value
    }
}
