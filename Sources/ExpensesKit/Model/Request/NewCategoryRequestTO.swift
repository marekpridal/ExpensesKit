//
//  NewCategoryRequestTO.swift
//  App
//
//  Created by Marek Pridal on 09.02.19.
//

public struct NewCategoryRequestTO: Encodable {
    public let name: String
    public let emojiIcon: String
    public let mandatory: Bool
    public let limit: LimitRequestTO?

    public init(name: String, emojiIcon: String, mandatory: Bool, limit: LimitRequestTO?) {
        self.name = name
        self.emojiIcon = emojiIcon
        self.mandatory = mandatory
        self.limit = limit
    }
}
