//
//  UpdateNotificationTokenTO.swift
//  App
//
//  Created by Marek Pridal on 10.02.19.
//

public struct UpdateNotificationTokenTO: Encodable {
    public let deviceName: String
    public let notificationToken: String

    public init(deviceName: String, notificationToken: String) {
        self.deviceName = deviceName
        self.notificationToken = notificationToken
    }
}
