//
//  VerifyReceiptResponseTO.swift
//  App
//
//  Created by Marek Pridal on 26/05/2019.
//

import Foundation

public struct VerifyActiveSubscriptionResponseTO: Decodable {
    public let hasActiveSubcription: Bool
    public let expirationDate: Date?
    public let activeProduct: LatestReceiptInfo?

    public init(hasActiveSubcription: Bool, expirationDate: Date?, activeProduct: LatestReceiptInfo?) {
        self.hasActiveSubcription = hasActiveSubcription
        self.expirationDate = expirationDate
        self.activeProduct = activeProduct
    }
}
