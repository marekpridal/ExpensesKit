//
//  CategoryTO.swift
//  MyExpenses
//
//  Created by Marek Pridal on 15.05.17.
//  Copyright © 2017 Marek Pridal. All rights reserved.
//

import Foundation

public struct CategoryTO: Codable, Equatable {
    public let categoryId: Int?
    public let username: String?
    public let name: String
    public let emojiIcon: String
    public let mandatory: Bool

    public init(categoryId: Int?, username: String?, name: String, emojiIcon: String?, mandatory: Bool) {
        self.categoryId = categoryId
        self.username = username
        self.name = name
        self.emojiIcon = emojiIcon ?? "💸"
        self.mandatory = mandatory
    }

    private enum CodingKeys: String, CodingKey {
        case categoryId = "id_kategorie"
        case username = "username"
        case name = "nazev"
        case emojiIcon = "emojiIcon"
        case mandatory = "mandatory"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.categoryId = try container.decode(Int.self, forKey: .categoryId)
        self.username = try container.decode(String.self, forKey: .username)
        self.name = try container.decode(String.self, forKey: .name)
        self.emojiIcon = try container.decode(String.self, forKey: .emojiIcon)
        self.mandatory = try container.decode(Bool.self, forKey: .mandatory)
    }
}
