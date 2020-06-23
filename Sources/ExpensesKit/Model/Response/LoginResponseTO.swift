//
//  LoginResponseTO.swift
//  App
//
//  Created by Marek Přidal on 06/02/2019.
//

public struct LoginResponseTO: Decodable {
    public let username: String
    public let token: String

    public init(username: String, token: String) {
        self.username = username
        self.token = token
    }
}
