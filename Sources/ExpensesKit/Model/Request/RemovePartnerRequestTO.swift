//
//  RemovePartnerRequestTO.swift
//  App
//
//  Created by Marek Pridal on 24/03/2019.
//

public struct RemovePartnerRequestTO: Encodable {
    public let partnerUsername: String

    public init(partnerUsername: String) {
        self.partnerUsername = partnerUsername
    }
}
