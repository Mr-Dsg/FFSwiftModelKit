//
//  FFModelAccessor.swift
//  FFSwiftModelKit
//
//  Created by @F.
//  Copyright © 2026 @F. All rights reserved.
//

import Foundation


public protocol FFModelAccessor: FFModel {

    func ff_set(
        value: Any,
        for key: String
    )


    func ff_get(
        valueFor key: String
    ) -> Any?
}
