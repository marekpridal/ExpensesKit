//
//  TodayWidgetResponseTO.swift
//  App
//
//  Created by Marek Přidal on 29/09/2019.
//

public struct TodayWidgetResponseTO: Decodable {
    public let defaultCurrency: String
    public let sumsPerMonth: [MonthWithSum]

    public init(defaultCurrency: String, sumsPerMonth: [MonthWithSum]) {
        self.defaultCurrency = defaultCurrency
        self.sumsPerMonth = sumsPerMonth
    }
}
