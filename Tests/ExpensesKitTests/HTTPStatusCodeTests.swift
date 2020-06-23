//
//  HTTPStatusCodeTests.swift
//  MyExpensesUnitTests
//
//  Created by Marek Pridal on 19.02.19.
//  Copyright © 2019 Marek Pridal. All rights reserved.
//

@testable import ExpensesKit
#if !os(watchOS)
import XCTest

class HTTPStatusCodeTests: XCTestCase {
    func testHundredResponseCode() {
        for code in 100...199 {
            XCTAssert(HTTPResponseCodeHandler.error(for: code, response: nil) is GeneralError)
        }
    }

    func testTwoHundredResponseCode() {
        for code in 200...299 {
            XCTAssertNil(HTTPResponseCodeHandler.error(for: code, response: nil))
        }
    }

    func testThreeHundredResponseCode() {
        for code in 300...399 {
            XCTAssert(HTTPResponseCodeHandler.error(for: code, response: nil) is RedirectionError)
        }
    }

    func testFourHundredResponseCode() {
        for code in 400...499 {
            switch code {
            case 400:
                XCTAssert(HTTPResponseCodeHandler.error(for: code, response: nil) is BadRequestError)

            case 401:
                XCTAssert(HTTPResponseCodeHandler.error(for: code, response: nil) is WrongUsernameOrPasswordError)

            case 402:
                XCTAssert(HTTPResponseCodeHandler.error(for: code, response: nil) is PaymentRequiredError)

            case 403:
                XCTAssert(HTTPResponseCodeHandler.error(for: code, response: nil) is BadRequestError)

            case 404:
                XCTAssert(HTTPResponseCodeHandler.error(for: code, response: nil) is NotFoundError)

            case 405...407:
                XCTAssert(HTTPResponseCodeHandler.error(for: code, response: nil) is BadRequestError)
                
            case 408:
                XCTAssert(HTTPResponseCodeHandler.error(for: code, response: nil) is RequestTimeoutError)

            case 409:
                XCTAssert(HTTPResponseCodeHandler.error(for: code, response: nil) is ConflictError)

            case 410...424:
                XCTAssert(HTTPResponseCodeHandler.error(for: code, response: nil) is BadRequestError)

            case 426:
                XCTAssert(HTTPResponseCodeHandler.error(for: code, response: nil) is UpgradeRequiredError)

            default:
                XCTAssert(HTTPResponseCodeHandler.error(for: code, response: nil) is BadRequestError)
            }
        }
    }

    func testFiveHundredResponseCode() {
        for code in 500...599 {
            if code == 503 {
                XCTAssert(HTTPResponseCodeHandler.error(for: code, response: nil) is ServerInMaintenance)
            } else if code == 511 {
                XCTAssert(HTTPResponseCodeHandler.error(for: code, response: nil) is NetworkAuthenticationRequiredError)
            } else {
                XCTAssert(HTTPResponseCodeHandler.error(for: code, response: nil) is ServerError)
            }
        }
    }

    func testUnknownReponseCode() {
        for code in 0...99 {
            XCTAssert(HTTPResponseCodeHandler.error(for: code, response: nil) is GeneralError)
        }
        for code in 600...999 {
            XCTAssert(HTTPResponseCodeHandler.error(for: code, response: nil) is GeneralError)
        }
    }
}
#endif
