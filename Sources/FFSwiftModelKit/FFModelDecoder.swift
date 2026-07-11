//
//  FFModelDecoder.swift
//  FFSwiftModelKit
//
//  Created by @F.
//  Copyright © 2026 @F. All rights reserved.
//

import Foundation


/// Model 解码器。
///
/// 负责：
/// - Dictionary -> Model
/// - 属性遍历
/// - 类型转换
internal enum FFModelDecoder {


    // MARK: - Decode


    static func decode<T: FFModel>(
        _ dictionary: [String: Any],
        type: T.Type
    ) -> T? {


        let model = type.init()



        let properties = MirrorCache.shared.properties(
            for: type
        )



        for property in properties {


            guard let value = dictionary[property.name]
            else {

                continue
            }



            guard let converted = FFValueConverter.convert(
                value,
                to: property.type
            )
            else {

                continue
            }

            property.setter(
                model,
                converted
            )
        }


        return model
    }
}
