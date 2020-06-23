//
//  MonthWithSum.swift
//  App
//
//  Created by Marek Přidal on 29/09/2019.
//

import Foundation

public struct MonthWithSum: Decodable {
    public let month: Date
    public let sum: Double

    public init(month: Date, sum: Double) {
        self.month = month
        self.sum = sum
    }
}
