//
//  InitRequestTO.swift
//  App
//
//  Created by Marek Přidal on 29/03/2020.
//

import Foundation

public struct InitRequestTO: Encodable {
    public let recordsMonthsBack: Int?

    public init(recordsMonthsBack: Int?) {
        self.recordsMonthsBack = recordsMonthsBack
    }
}
