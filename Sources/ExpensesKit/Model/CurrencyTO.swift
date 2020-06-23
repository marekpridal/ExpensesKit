//
//  ExchangeRates.swift
//  MyExpenses
//
//  Created by Marek Pridal on 22.12.18.
//  Copyright © 2018 Marek Pridal. All rights reserved.
//

import Foundation

public struct CurrencyTO: Decodable, Equatable {
    public let countryCode: String
    public let value: Double

    public init(countryCode: String, value: Double) {
        self.countryCode = countryCode
        self.value = value
    }
}
