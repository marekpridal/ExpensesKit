//
//  SecurityHelperProtocol.swift
//  ExpensesKit
//
//  Created by Marek Přidal on 23/06/2020.
//  Copyright © 2020 Marek Pridal. All rights reserved.
//

import Foundation

public protocol SecurityHelperProtocol {
    var log: LogDelegate.Type? { get }
    var username: String? { get set }
    var password: String? { get set }
    var canLogIn: Bool { get }
    var loggedIn: Bool { get set }
    var bearerToken: String? { get set }

    func removeAll()
}
