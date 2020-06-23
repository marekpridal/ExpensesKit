//
//  RegisterResponseTO.swift
//  App
//
//  Created by Marek Přidal on 06/02/2019.
//

public struct RegisterResponseTO: Decodable {
    public let username: String?

    public init(username: String?) {
        self.username = username
    }
}
