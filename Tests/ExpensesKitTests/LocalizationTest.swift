//
//  LocalizationTest.swift
//  
//
//  Created by Marek Přidal on 30/06/2020.
//

@testable import ExpensesKit
#if !os(watchOS)
import XCTest

final class LocalizationTest: XCTestCase {
    func testLocalizedError() {
        let error = BadRequestError()
        XCTAssertEqual(error.localizedDescription, "Something is missing here ⚠️")
    }
}
#endif
