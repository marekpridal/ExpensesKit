//
//  TodayWidgetResponseTO.swift
//  App
//
//  Created by Marek Přidal on 29/09/2019.
//

import Foundation

public struct TodayWidgetResponseTO: Decodable {
    public let categoriesForLastMonth: [CategoryWithSum]
    public let defaultCurrency: String
    public let sumsPerMonth: [MonthWithSum]

    public init(categoriesForLastMonth: [CategoryWithSum], defaultCurrency: String, sumsPerMonth: [MonthWithSum]) {
        self.categoriesForLastMonth = categoriesForLastMonth
        self.defaultCurrency = defaultCurrency
        self.sumsPerMonth = sumsPerMonth
    }
}
