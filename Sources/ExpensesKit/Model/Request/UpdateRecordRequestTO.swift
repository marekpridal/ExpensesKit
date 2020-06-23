//
//  UpdateRecordRequestTO.swift
//  App
//
//  Created by Marek Přidal on 06/02/2019.
//

import Foundation

public struct UpdateRecordRequestTO: Encodable {
    public let recordId: Int
    public let note: String?
    public let username: String
    public let categoryId: UInt
    public let amount: Double
    public let date: Date
    public let latitude: Double?
    public let longitude: Double?
    public let originalCurrency: String?
    public let defaultCurrency: String
    public let originalAmount: Double?

    public init(recordId: Int, note: String?, username: String, categoryId: UInt, amount: Double, date: Date, latitude: Double?, longitude: Double?, originalCurrency: String?, defaultCurrency: String, originalAmount: Double?) {
        self.recordId = recordId
        self.note = note
        self.username = username
        self.categoryId = categoryId
        self.amount = amount
        self.date = date
        self.latitude = latitude
        self.longitude = longitude
        self.originalCurrency = originalCurrency
        self.defaultCurrency = defaultCurrency
        self.originalAmount = originalAmount
    }
}
