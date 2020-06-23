//
//  Enviroment.swift
//  MyExpenses
//
//  Created by Marek Přidal on 15/09/2019.
//  Copyright © 2019 Marek Pridal. All rights reserved.
//

import Foundation
#if os(iOS)
import UIKit
#endif

public enum Environment {
    public static let appVersion: String? = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    public static let buildNumber: String? = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String
    public static let appName: String? = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
    public static var iosVersion: String? {
        #if os(iOS)
        return UIDevice.current.systemVersion
        #else
        return nil
        #endif
    }
}
