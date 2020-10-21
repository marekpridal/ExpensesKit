//
//  UpdateCategoryRequest.swift
//  
//
//  Created by Marek Přidal on 21/10/2020.
//

import Foundation

public struct UpdateCategoryRequest: Codable {
     public let categoryId: Int?
     public let name: String
     public let emojiIcon: String
     public let mandatory: Bool
     public let limit: LimitRequestTO?

     private enum CodingKeys: String, CodingKey {
         case categoryId = "id_kategorie"
         case name = "nazev"
         case emojiIcon
         case mandatory
         case limit
     }

    public init(categoryId: Int?, name: String, emojiIcon: String, mandatory: Bool, limit: LimitRequestTO?) {
        self.categoryId = categoryId
        self.name = name
        self.emojiIcon = emojiIcon
        self.mandatory = mandatory
        self.limit = limit
    }
 }
