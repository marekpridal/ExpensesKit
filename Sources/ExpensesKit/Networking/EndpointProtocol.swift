//
//  EndpointProtocol.swift
//  ExpensesKit
//
//  Created by Marek Přidal on 02/05/2020.
//  Copyright © 2020 Marek Pridal. All rights reserved.
//

import Foundation

public protocol EndpointProtocol {
    var login: URL { get }
    var logout: URL { get }
    var category: URL { get }
    var record: URL { get }
    var exchangeRates: URL { get }
    var updateNotificationToken: URL { get }
    var initData: URL { get }
    var register: URL { get }
    var newPartner: URL { get }
    var removePartner: URL { get }
    var verifyReceipt: URL { get }
    var todayWidget: URL { get }
    var regularPayments: URL { get }
    var updateRegularPayment: URL { get }
    var newRegularPayment: URL { get }
    var deleteRegularPayment: URL { get }
    var changePassword: URL { get }
    var passwordReset: URL { get }
}
