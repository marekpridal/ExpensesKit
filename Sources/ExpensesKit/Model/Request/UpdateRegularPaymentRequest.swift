//
//  UpdateRegularPaymentRequest.swift
//  App
//
//  Created by Marek Přidal on 20/10/2019.
//

import Foundation

public struct UpdateRegularPaymentRequest: Encodable {
    public let regularPaymentId: Int
    public let note: String?
    public let categoryId: Int
    public let amount: Double
    public let startDate: Date
    public let originalCurrencyId: String?
    public let defaultCurrencyId: String
    public let originalAmount: Double?
    public let frequency: RegularPaymentFrequency

    public init(regularPaymentId: Int, note: String?, categoryId: Int, amount: Double, startDate: Date, originalCurrencyId: String?, defaultCurrencyId: String, originalAmount: Double?, frequency: RegularPaymentFrequency) {
        self.regularPaymentId = regularPaymentId
        self.note = note
        self.categoryId = categoryId
        self.amount = amount
        self.startDate = startDate
        self.originalCurrencyId = originalCurrencyId
        self.defaultCurrencyId = defaultCurrencyId
        self.originalAmount = originalAmount
        self.frequency = frequency
    }
}
