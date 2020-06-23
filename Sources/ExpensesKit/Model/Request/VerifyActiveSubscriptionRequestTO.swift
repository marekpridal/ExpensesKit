//
//  VerifyActiveSubscriptionRequestTO.swift
//  App
//
//  Created by Marek Pridal on 02/06/2019.
//

public struct VerifyActiveSubscriptionRequestTO: Encodable {
    /**
     The base64 encoded receipt data.
     */
    public let receiptData: String?

    public init(receiptData: String?) {
        self.receiptData = receiptData
    }
}
