//
//  RecordTO.swift
//  MyExpenses
//
//  Created by Marek Pridal on 15.05.17.
//  Copyright © 2017 Marek Pridal. All rights reserved.
//

import Foundation

public struct RecordTO: Codable, Equatable {
    public let recordId: Int?
    public let note: String?
    public let username: String
    public let categoryId: Int
    public let amount: Double
    public let date: Date
    public let latitude: Double?
    public let longitude: Double?
    public let distance: Double?
    public let avatarImageURL: String?
    public let authorName: String?
    public let originalCurrency: String?
    public let originalAmount: Double?
    public let defaultCurrency: String

    private enum CodingKeys: String, CodingKey {
        case recordId = "id_zapis"
        case note = "poznamka"
        case username = "username"
        case categoryId = "id_kategorie"
        case amount = "pohyb"
        case date = "datum"
        case latitude = "latitude"
        case longitude = "longitude"
        case distance = "distance"
        case avatarImageURL = "avatarImageURL"
        case authorName = "name"
        case originalCurrency = "originalCurrency"
        case originalAmount = "originalAmount"
        case defaultCurrency = "defaultCurrency"
    }

    public init(recordId: Int?, note: String?, username: String, categoryId: Int, amount: Double, date: Date, latitude: Double?, longitude: Double?, distance: Double? = nil, avatarImageURL: String? = nil, authorName: String? = nil, originalCurrency: String? = nil, originalAmount: Double? = nil, defaultCurrency: String) {
        self.recordId = recordId
        self.note = note
        self.username = username
        self.categoryId = categoryId
        self.amount = amount
        self.date = date
        self.latitude = latitude
        self.longitude = longitude
        self.distance = distance
        self.avatarImageURL = avatarImageURL
        self.authorName = authorName
        self.originalCurrency = originalCurrency
        self.originalAmount = originalAmount
        self.defaultCurrency = defaultCurrency
    }
}
