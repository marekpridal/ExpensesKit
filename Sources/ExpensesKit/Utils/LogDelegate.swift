//
//  LogDelegate.swift
//  ExpensesAPI
//
//  Created by Marek Přidal on 26/04/2020.
//  Copyright © 2020 Marek Pridal. All rights reserved.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

// swiftlint:disable:next class_delegate_protocol
public protocol LogDelegate {
    static func error(_ error: Error)
    static func expiration(date: Date)
    static func request(_ request: URLRequest)
    static func requestCalled(function: String)
    static func response(_ response: URLResponse?, data: Data?)
}
