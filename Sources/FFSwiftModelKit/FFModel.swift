//
//  FFModel.swift
//  FFSwiftModelKit
//
//  Created by @F.
//  Copyright © 2026 @F. All rights reserved.
//

import Foundation

/// FFSwiftModelKit 模型协议。
///
/// 所有参与转换的 Model 类型需要遵循该协议。
///
/// 示例：
///
/// ```swift
/// final class User: FFModel {
///     var name: String?
///     var age: Int = 0
///
///     required init() {}
/// }
/// ```
public protocol FFModel: AnyObject {

    /// 必须提供无参初始化。
    init()
}


// MARK: - Decode

public extension FFModel {

    /// 从字典创建 Model。
    ///
    /// - Parameter dictionary: 数据源
    /// - Returns: Model 实例
    static func ff_model(
        from dictionary: [String: Any]
    ) -> Self? {
        
        FFModelDecoder.decode(
            dictionary,
            type: self
        )
    }


    /// 从 JSON Data 创建 Model。
    ///
    /// - Parameter data: JSON 数据
    /// - Returns: Model 实例
    static func ff_model(
        from data: Data
    ) -> Self? {

        guard let dictionary = try? FFJSON.dictionary(
            from: data
        ) else {
            return nil
        }

        return ff_model(
            from: dictionary
        )
    }


    /// 从数组创建 Model 数组。
    ///
    /// - Parameter dictionaries: 数据数组
    /// - Returns: Model 数组
    static func ff_models(
        from dictionaries: [[String: Any]]
    ) -> [Self] {

        dictionaries.compactMap {
            ff_model(from: $0)
        }
    }
}


// MARK: - Encode

public extension FFModel {

    /// 转换为字典。
    ///
    /// - Returns: [String: Any]
    func ff_dictionary() -> [String: Any] {

        FFModelEncoder.encode(self)
    }


    /// 转换为 JSON Data。
    ///
    /// - Returns: Data
    func ff_jsonData() -> Data? {

        try? FFJSON.data(
            from: ff_dictionary()
        )
    }


    /// 转换为 JSON 字符串。
    ///
    /// - Returns: String
    func ff_jsonString() -> String? {

        guard let data = ff_jsonData() else {
            return nil
        }

        return FFJSON.string(
            from: data
        )
    }
}
