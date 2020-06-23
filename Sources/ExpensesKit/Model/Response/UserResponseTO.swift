//
//  UserResponseTO.swift
//  App
//
//  Created by Marek Pridal on 09.02.19.
//

public struct UserResponseTO: Codable, Equatable {
    public let username: String
    public let avatarImageURL: String?
    public let defaultCurrency: String
    public let email: String?

    public init(username: String, avatarImageURL: String?, defaultCurrency: String, email: String?) {
        self.username = username
        self.avatarImageURL = avatarImageURL
        self.defaultCurrency = defaultCurrency
        self.email = email
    }
}
