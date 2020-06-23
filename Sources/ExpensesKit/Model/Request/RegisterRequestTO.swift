//
//  UserRequestTO.swift
//  App
//
//  Created by Marek Pridal on 03.02.19.
//

import Foundation

public struct RegisterRequestTO: Encodable {
    public let username: String
    public let name: String?
    public let surname: String?
    public let password: String
    public let email: String?
    public let avatarImage: Data?
    public let deviceName: String
    public let defaultCurrency: String

    public init(username: String, name: String?, surname: String?, password: String, email: String?, avatarImage: Data?, deviceName: String, defaultCurrency: String) {
        self.username = username
        self.name = name
        self.surname = surname
        self.password = password
        self.email = email
        self.avatarImage = avatarImage
        self.deviceName = deviceName
        self.defaultCurrency = defaultCurrency
    }
}
