//
//  PasswordResetRequestTO.swift
//  App
//
//  Created by Marek Přidal on 07/02/2020.
//

import Foundation

public struct PasswordResetRequestTO: Encodable {
    public let username: String
    public let email: String

    public init(username: String, email: String) {
        self.username = username
        self.email = email
    }
}
