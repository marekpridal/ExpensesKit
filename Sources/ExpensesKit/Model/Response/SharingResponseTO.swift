//
//  SharingResponseTO.swift
//  App
//
//  Created by Marek Pridal on 09.02.19.
//

public struct SharingResponseTO: Codable, Equatable {
    public let username: String
    public let defaultCurrency: String

    public init(username: String, defaultCurrency: String) {
        self.username = username
        self.defaultCurrency = defaultCurrency
    }
}
