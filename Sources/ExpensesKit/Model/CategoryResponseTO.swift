//
//  CategoryResponseTO.swift
//  MyExpenses
//
//  Created by Marek Pridal on 15.05.17.
//  Copyright © 2017 Marek Pridal. All rights reserved.
//

import Foundation

public struct CategoryResponseTO: Codable, Equatable {
    public let categoryId: Int?
    public let username: String?
    public let name: String
    public let emojiIcon: String
    public let mandatory: Bool
    public let limit: LimitResponseTO?

    public init(categoryId: Int?, username: String?, name: String, emojiIcon: String?, mandatory: Bool, limit: LimitResponseTO?) {
        self.categoryId = categoryId
        self.username = username
        self.name = name
        self.emojiIcon = emojiIcon ?? "💸"
        self.mandatory = mandatory
        self.limit = limit
    }

    private enum CodingKeys: String, CodingKey {
        case categoryId = "id_kategorie"
        case username
        case name = "nazev"
        case emojiIcon
        case mandatory
        case limit
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.categoryId = try container.decodeIfPresent(Int.self, forKey: .categoryId)
        self.username = try container.decodeIfPresent(String.self, forKey: .username)
        self.name = try container.decode(String.self, forKey: .name)
        self.emojiIcon = try container.decode(String.self, forKey: .emojiIcon)
        self.mandatory = try container.decode(Bool.self, forKey: .mandatory)
        self.limit = try container.decodeIfPresent(LimitResponseTO.self, forKey: .limit)
    }
}
