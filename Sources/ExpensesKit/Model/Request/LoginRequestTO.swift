//
//  LoginRequestTO.swift
//  App
//
//  Created by Marek Pridal on 05.02.19.
//

public struct LoginRequestTO: Encodable {
    public let username: String
    public let password: String
    public let deviceName: String
    public let notificationToken: String?

    public init(username: String, password: String, deviceName: String, notificationToken: String?) {
        self.username = username
        self.password = password
        self.deviceName = deviceName
        self.notificationToken = notificationToken
    }
}
