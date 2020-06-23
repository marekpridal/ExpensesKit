//
//  LogoutRequestTO.swift
//  App
//
//  Created by Marek Přidal on 06/02/2019.
//

public struct LogoutRequestTO: Encodable {
    public let deviceName: String

    public init(deviceName: String) {
        self.deviceName = deviceName
    }
}
