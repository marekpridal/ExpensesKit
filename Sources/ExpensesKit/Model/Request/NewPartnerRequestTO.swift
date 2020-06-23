//
//  NewPartnerRequestTO.swift
//  App
//
//  Created by Marek Pridal on 24/03/2019.
//

public struct NewPartnerRequestTO: Encodable {
    public let partnerUsername: String

    public init(partnerUsername: String) {
        self.partnerUsername = partnerUsername
    }
}
