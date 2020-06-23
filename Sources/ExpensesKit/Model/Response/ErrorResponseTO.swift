//
//  ErrorResponseTO.swift
//  MyExpenses
//
//  Created by Marek Přidal on 15/09/2019.
//  Copyright © 2019 Marek Pridal. All rights reserved.
//

public struct ErrorResponseTO: Decodable {
    public let error: Bool
    public let reason: String

    public init(error: Bool, reason: String) {
        self.error = error
        self.reason = reason
    }
}
