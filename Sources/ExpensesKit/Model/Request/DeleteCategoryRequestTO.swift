//
//  DeleteCategoryRequestTO.swift
//  MyExpenses
//
//  Created by Marek Přidal on 21/08/2019.
//  Copyright © 2019 Marek Pridal. All rights reserved.
//

public struct DeleteCategoryRequestTO: Encodable {
    public let categoryIdToDelete: Int
    public let newCategoryIdForExistingRecords: Int?

    public init(categoryIdToDelete: Int, newCategoryIdForExistingRecords: Int?) {
        self.categoryIdToDelete = categoryIdToDelete
        self.newCategoryIdForExistingRecords = newCategoryIdForExistingRecords
    }
}
