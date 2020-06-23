//
//  TodayWidgetRequestTO.swift
//  App
//
//  Created by Marek Přidal on 29/09/2019.
//

public struct TodayWidgetRequestTO: Encodable {
    public let monthsBack: Int?

    public init(monthsBack: Int?) {
        self.monthsBack = monthsBack
    }
}
