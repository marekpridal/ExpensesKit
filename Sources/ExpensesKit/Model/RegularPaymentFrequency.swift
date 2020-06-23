//
//  RegularPaymentFrequency.swift
//  App
//
//  Created by Marek Přidal on 20/10/2019.
//

import Foundation

public enum RegularPaymentFrequency: Int, Codable, CodingKey, Equatable {
    case week = 100
    case month = 200
    case quarter = 300
    case halfYear = 400
    case year = 500
    case undefined = 1000

    public init(from decoder: Decoder) {
        do {
            let container = try decoder.singleValueContainer()
            let rawValue = try container.decode(Int.self)
            self = RegularPaymentFrequency(intValue: rawValue) ?? .undefined
        } catch {
            self = .undefined
        }
    }
}
