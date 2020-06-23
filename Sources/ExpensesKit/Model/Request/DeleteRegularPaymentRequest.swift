//
//  DeleteRegularPaymentRequest.swift
//  App
//
//  Created by Marek Přidal on 20/10/2019.
//

public struct DeleteRegularPaymentRequest: Encodable {
    public let regularPaymentId: Int

    public init(regularPaymentId: Int) {
        self.regularPaymentId = regularPaymentId
    }
}
