//
//  LatestReceiptInfo.swift
//  MyExpenses
//
//  Created by Marek Pridal on 11/05/2019.
//  Copyright © 2019 Marek Pridal. All rights reserved.
//

import Foundation

public struct LatestReceiptInfo: Decodable {
    /**
     Quantity
     The number of items purchased.
     
     ASN.1 Field Type 1701
     
     ASN.1 Field Value INTEGER
     
     JSON Field Name quantity
     
     JSON Field Value string, interpreted as an integer
     
     This value corresponds to the quantity property of the SKPayment object stored in the transaction’s payment property.
     */
    public let quantity: String?
    /**
     Product Identifier
     The product identifier of the item that was purchased.
     
     ASN.1 Field Type 1702
     
     ASN.1 Field Value UTF8STRING
     
     JSON Field Name product_id
     
     JSON Field Value string
     
     This value corresponds to the productIdentifier property of the SKPayment object stored in the transaction’s payment property
     */
    public let productID: String?
    /**
     Transaction Identifier
     The transaction identifier of the item that was purchased.
     
     ASN.1 Field Type 1703
     
     ASN.1 Field Value UTF8STRING
     
     JSON Field Name transaction_id
     
     JSON Field Value string
     
     This value corresponds to the transaction’s transactionIdentifier property.
     
     For a transaction that restores a previous transaction, this value is different from the transaction identifier of the original purchase transaction. In an auto-renewable subscription receipt, a new value for the transaction identifier is generated every time the subscription automatically renews or is restored on a new device.
     */
    public let transactionID: String?
    /**
     Original Transaction Identifier
     For a transaction that restores a previous transaction, the transaction identifier of the original transaction. Otherwise, identical to the transaction identifier.
     
     ASN.1 Field Type 1705
     
     ASN.1 Field Value UTF8STRING
     
     JSON Field Name original_transaction_id
     
     JSON Field Value string
     
     This value corresponds to the original transaction’s transactionIdentifier property.
     
     This value is the same for all receipts that have been generated for a specific subscription. This value is useful for relating together multiple iOS 6 style transaction receipts for the same individual customer’s subscription.
     */
    public let originalTransactionID: String?
    /**
     Purchase Date
     The date and time that the item was purchased.
     
     ASN.1 Field Type 1704
     
     ASN.1 Field Value IA5STRING, interpreted as an RFC 3339 date
     
     JSON Field Name purchase_date
     
     JSON Field Value string, interpreted as an RFC 3339 date
     
     This value corresponds to the transaction’s transactionDate property.
     
     For a transaction that restores a previous transaction, the purchase date is the same as the original purchase date. Use Original Purchase Date to get the date of the original transaction.
     
     In an auto-renewable subscription receipt, the purchase date is the date when the subscription was either purchased or renewed (with or without a lapse). For an automatic renewal that occurs on the expiration date of the current period, the purchase date is the start date of the next period, which is identical to the end date of the current period.
     */
    public let purchaseDate: Date?
    /**
     Purchase Date
     The date and time that the item was purchased.
     
     ASN.1 Field Type 1704
     
     ASN.1 Field Value IA5STRING, interpreted as an RFC 3339 date
     
     JSON Field Name purchase_date
     
     JSON Field Value string, interpreted as an RFC 3339 date
     
     This value corresponds to the transaction’s transactionDate property.
     
     For a transaction that restores a previous transaction, the purchase date is the same as the original purchase date. Use Original Purchase Date to get the date of the original transaction.
     
     In an auto-renewable subscription receipt, the purchase date is the date when the subscription was either purchased or renewed (with or without a lapse). For an automatic renewal that occurs on the expiration date of the current period, the purchase date is the start date of the next period, which is identical to the end date of the current period.
     */
    public let purchaseDateMS: String?
    /**
     Purchase Date
     The date and time that the item was purchased.
     
     ASN.1 Field Type 1704
     
     ASN.1 Field Value IA5STRING, interpreted as an RFC 3339 date
     
     JSON Field Name purchase_date
     
     JSON Field Value string, interpreted as an RFC 3339 date
     
     This value corresponds to the transaction’s transactionDate property.
     
     For a transaction that restores a previous transaction, the purchase date is the same as the original purchase date. Use Original Purchase Date to get the date of the original transaction.
     
     In an auto-renewable subscription receipt, the purchase date is the date when the subscription was either purchased or renewed (with or without a lapse). For an automatic renewal that occurs on the expiration date of the current period, the purchase date is the start date of the next period, which is identical to the end date of the current period.
     */
    public let purchaseDatePst: Date?
    /**
     Original Purchase Date
     For a transaction that restores a previous transaction, the date of the original transaction.
     
     ASN.1 Field Type 1706
     
     ASN.1 Field Value IA5STRING, interpreted as an RFC 3339 date
     
     JSON Field Name original_purchase_date
     
     JSON Field Value string, interpreted as an RFC 3339 date
     
     This value corresponds to the original transaction’s transactionDate property.
     
     In an auto-renewable subscription receipt, this indicates the beginning of the subscription period, even if the subscription has been renewed.
     */
    public let originalPurchaseDate: Date?
    /**
     Original Purchase Date
     For a transaction that restores a previous transaction, the date of the original transaction.
     
     ASN.1 Field Type 1706
     
     ASN.1 Field Value IA5STRING, interpreted as an RFC 3339 date
     
     JSON Field Name original_purchase_date
     
     JSON Field Value string, interpreted as an RFC 3339 date
     
     This value corresponds to the original transaction’s transactionDate property.
     
     In an auto-renewable subscription receipt, this indicates the beginning of the subscription period, even if the subscription has been renewed.
     */
    public let originalPurchaseDateMS: String?
    /**
     Original Purchase Date
     For a transaction that restores a previous transaction, the date of the original transaction.
     
     ASN.1 Field Type 1706
     
     ASN.1 Field Value IA5STRING, interpreted as an RFC 3339 date
     
     JSON Field Name original_purchase_date
     
     JSON Field Value string, interpreted as an RFC 3339 date
     
     This value corresponds to the original transaction’s transactionDate property.
     
     In an auto-renewable subscription receipt, this indicates the beginning of the subscription period, even if the subscription has been renewed.
     */
    public let originalPurchaseDatePst: Date?
    /**
     Subscription Expiration Date
     The expiration date for the subscription, expressed as the number of milliseconds since January 1, 1970, 00:00:00 GMT.
     
     ASN.1 Field Type 1708
     
     ASN.1 Field Value IA5STRING, interpreted as an RFC 3339 date
     
     JSON Field Name expires_date
     
     JSON Field Value string, interpreted as an RFC 3339 date
     
     This key is only present for auto-renewable subscription receipts. Use this value to identify the date when the subscription will renew or expire, to determine if a customer should have access to content or service. After validating the latest receipt, if the subscription expiration date for the latest renewal transaction is a past date, it is safe to assume that the subscription has expired.
     */
    public let expiresDate, expiresDatePst: Date?
    /**
     Subscription Expiration Date
     The expiration date for the subscription, expressed as the number of milliseconds since January 1, 1970, 00:00:00 GMT.
     
     ASN.1 Field Type 1708
     
     ASN.1 Field Value IA5STRING, interpreted as an RFC 3339 date
     
     JSON Field Name expires_date
     
     JSON Field Value string, interpreted as an RFC 3339 date
     
     This key is only present for auto-renewable subscription receipts. Use this value to identify the date when the subscription will renew or expire, to determine if a customer should have access to content or service. After validating the latest receipt, if the subscription expiration date for the latest renewal transaction is a past date, it is safe to assume that the subscription has expired.
     */
    public let expiresDateMS, webOrderLineItemID: String?
    /**
     Subscription Trial Period
     For a subscription, whether or not it is in the free trial period.
     
     ASN.1 Field Type (none)
     
     ASN.1 Field Value (none)
     
     JSON Field Name is_trial_period
     
     JSON Field Value string
     
     This key is only present for auto-renewable subscription receipts. The value for this key is "true" if the customer’s subscription is currently in the free trial period, or "false" if not.
     
     **Note: If a previous subscription period in the receipt has the value “true” for either the is_trial_period or the is_in_intro_offer_period key, the user is not eligible for a free trial or introductory price within that subscription group.**
     */
    public let isTrialPeriod: String?
    /**
     Subscription Introductory Price Period
     For an auto-renewable subscription, whether or not it is in the introductory price period.
     
     ASN.1 Field Type 1719
     
     ASN.1 Field Value INTEGER
     
     JSON Field Name is_in_intro_offer_period
     
     JSON Field Value string
     
     This key is only present for auto-renewable subscription receipts. The value for this key is "true" if the customer’s subscription is currently in an introductory price period, or "false" if not.
     
     **Note: If a previous subscription period in the receipt has the value “true” for either the is_trial_period or the is_in_intro_offer_period key, the user is not eligible for a free trial or introductory price within that subscription group.**
     */
    public let isInIntroOfferPeriod: String?

    public enum CodingKeys: String, CodingKey {
        case quantity = "quantity"
        case productID = "product_id"
        case transactionID = "transaction_id"
        case originalTransactionID = "original_transaction_id"
        case purchaseDate = "purchase_date"
        case purchaseDateMS = "purchase_date_ms"
        case purchaseDatePst = "purchase_date_pst"
        case originalPurchaseDate = "original_purchase_date"
        case originalPurchaseDateMS = "original_purchase_date_ms"
        case originalPurchaseDatePst = "original_purchase_date_pst"
        case expiresDate = "expires_date"
        case expiresDateMS = "expires_date_ms"
        case expiresDatePst = "expires_date_pst"
        case webOrderLineItemID = "web_order_line_item_id"
        case isTrialPeriod = "is_trial_period"
        case isInIntroOfferPeriod = "is_in_intro_offer_period"
    }

    // swiftlint:disable:next line_length
    public init(quantity: String?, productID: String?, transactionID: String?, originalTransactionID: String?, purchaseDate: Date?, purchaseDateMS: String?, purchaseDatePst: Date?, originalPurchaseDate: Date?, originalPurchaseDateMS: String?, originalPurchaseDatePst: Date?, expiresDate: Date?, expiresDatePst: Date?, expiresDateMS: String?, webOrderLineItemID: String?, isTrialPeriod: String?, isInIntroOfferPeriod: String?) {
        self.quantity = quantity
        self.productID = productID
        self.transactionID = transactionID
        self.originalTransactionID = originalTransactionID
        self.purchaseDate = purchaseDate
        self.purchaseDateMS = purchaseDateMS
        self.purchaseDatePst = purchaseDatePst
        self.originalPurchaseDate = originalPurchaseDate
        self.originalPurchaseDateMS = originalPurchaseDateMS
        self.originalPurchaseDatePst = originalPurchaseDatePst
        self.expiresDate = expiresDate
        self.expiresDatePst = expiresDatePst
        self.expiresDateMS = expiresDateMS
        self.webOrderLineItemID = webOrderLineItemID
        self.isTrialPeriod = isTrialPeriod
        self.isInIntroOfferPeriod = isInIntroOfferPeriod
    }
}
