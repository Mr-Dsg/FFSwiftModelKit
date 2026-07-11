//
//  FFSwiftModelKitTests.swift
//  FFSwiftModelKit
//
//  Created by @F.
//  Copyright © 2026 @F. All rights reserved.
//

import XCTest
@testable import FFSwiftModelKit


final class FFSwiftModelKitTests: XCTestCase {

    // MARK: - Model

    final class User: NSObject, FFModel, FFModelAccessor {


        var name: String?

        var age: Int = 0


        required override init() {

            super.init()
        }


        func ff_set(
            value: Any,
            for key: String
        ) {

            switch key {

            case "name":

                name = value as? String


            case "age":

                age = value as? Int ?? 0


            default:
                break
            }
        }


        func ff_get(
            valueFor key: String
        ) -> Any? {


            switch key {


            case "name":

                return name


            case "age":

                return age


            default:

                return nil
            }
        }
    }


    // MARK: - Decode

    func testDecodeModel() {

        let json: [String: Any] = [

            "name": "FF",

            "age": 18
        ]


        let user = User.ff_model(
            from: json
        )


        XCTAssertNotNil(
            user
        )

        XCTAssertEqual(
            user?.name,
            "FF"
        )

        XCTAssertEqual(
            user?.age,
            18
        )
    }


    // MARK: - Encode

    func testEncodeModel() {

        let user = User()

        user.name = "FF"

        user.age = 20


        let dictionary = user.ff_dictionary()


        XCTAssertEqual(
            dictionary["name"] as? String,
            "FF"
        )


        XCTAssertEqual(
            dictionary["age"] as? Int,
            20
        )
    }


    // MARK: - JSON

    func testJSON() throws {

        let object: [String: Any] = [

            "name": "FF"
        ]


        let data = try FFJSON.data(
            from: object
        )


        let result = try FFJSON.dictionary(
            from: data
        )


        XCTAssertEqual(
            result["name"] as? String,
            "FF"
        )
    }
}
