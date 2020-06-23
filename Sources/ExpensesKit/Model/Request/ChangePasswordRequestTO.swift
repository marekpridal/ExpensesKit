//
//  ChangePasswordRequestTO.swift
//  App
//
//  Created by Marek Přidal on 06/02/2019.
//

public struct ChangePasswordRequestTO: Encodable {
    public let username: String
    public let currentPassword: String
    public let newPassword: String

    public init(username: String, currentPassword: String, newPassword: String) {
        self.username = username
        self.currentPassword = currentPassword
        self.newPassword = newPassword
    }
}
