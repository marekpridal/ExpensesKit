//
//  RegularPaymentResponse.swift
//  App
//
//  Created by Marek Přidal on 20/10/2019.
//

import Foundation

public struct RegularPaymentResponse: Equatable, Codable {
    public let regularPaymentId: Int
    public let note: String?
    public let owner: String
    public let category: Int
    public let amount: Double
    public let startDate: Date
    public let originalCurrency: String?
    public let defaultCurrency: String
    public let originalAmount: Double?
    public let frequency: DateFrequency
    public let lastProceededDate: Date?
    public let nextProceedDate: Date?

    public init(regularPaymentId: Int, note: String?, owner: String, category: Int, amount: Double, startDate: Date, originalCurrency: String?, defaultCurrency: String, originalAmount: Double?, frequency: DateFrequency, lastProceededDate: Date?, nextProceedDate: Date?) {
        self.regularPaymentId = regularPaymentId
        self.note = note
        self.owner = owner
        self.category = category
        self.amount = amount
        self.startDate = startDate
        self.originalCurrency = originalCurrency
        self.defaultCurrency = defaultCurrency
        self.originalAmount = originalAmount
        self.frequency = frequency
        self.lastProceededDate = lastProceededDate
        self.nextProceedDate = nextProceedDate
    }
}
