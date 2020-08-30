//
//  CategoryWithSum.swift
//  App
//
//  Created by Marek Přidal on 30/08/2020.
//

import Foundation

public struct CategoryWithSum: Codable {
    public let categoryId: Int?
    public let username: String?
    public let name: String
    public let emojiIcon: String
    public let mandatory: Bool
    public var sum: Double

    public init(category: CategoryTO, sum: Double = 0) {
        self.categoryId = category.categoryId
        self.username = category.username
        self.name = category.name
        self.emojiIcon = category.emojiIcon
        self.mandatory = category.mandatory
        self.sum = sum
    }
}
