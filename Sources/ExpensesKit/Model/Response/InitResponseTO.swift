//
//  InitReponseTO.swift
//  App
//
//  Created by Marek Přidal on 12/02/2019.
//

public struct InitResponseTO: Decodable {
    public let records: [RecordTO]
    public let categories: [CategoryTO]
    public let users: [UserResponseTO]
    public let partners: [SharingResponseTO]

    public init(records: [RecordTO], categories: [CategoryTO], users: [UserResponseTO], partners: [SharingResponseTO]) {
        self.records = records
        self.categories = categories
        self.users = users
        self.partners = partners
    }
}
