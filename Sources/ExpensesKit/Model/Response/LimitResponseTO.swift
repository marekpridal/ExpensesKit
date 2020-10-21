//
//  LimitResponseTO.swift
//  
//
//  Created by Marek Přidal on 21/10/2020.
//

import Foundation

public struct LimitResponseTO: Codable, Equatable {
     public var id: Int?
     public let frequency: DateFrequency
     public let limit: Double

    public init(id: Int? = nil, frequency: DateFrequency, limit: Double) {
        self.id = id
        self.frequency = frequency
        self.limit = limit
    }
 }
