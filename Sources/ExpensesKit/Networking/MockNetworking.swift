//
//  MockNetworking.swift
//  MyExpenses
//
//  Created by Marek Pridal on 10/07/2019.
//  Copyright © 2019 Marek Pridal. All rights reserved.
//

import Foundation

// swiftlint:disable required_deinit
public final class MockNetworking: Api {
    public init() { }

    public var securityHelper: SecurityHelperProtocol = MockSecurityHelper()

    public let records: [RecordTO] = [
        RecordTO(recordId: 1, note: "Note_Note_Note_Note_Note_Note_Note_Note_Note_Note_Note_Note_Note", username: "mockUser", categoryId: 1, amount: 100, date: Date(), latitude: 50.10009765625, longitude: 14.396499920355941, defaultCurrency: "CZK"),
        RecordTO(recordId: 10, note: "Note", username: "mockUser", categoryId: 2, amount: 100, date: Date(), latitude: nil, longitude: nil, defaultCurrency: "CZK"),
        RecordTO(recordId: 100, note: "Note", username: "mockUser", categoryId: 3, amount: 100, date: Calendar.current.date(byAdding: .month, value: -1, to: .init())!, latitude: nil, longitude: nil, defaultCurrency: "CZK"),
        RecordTO(recordId: 1110, note: "Note", username: "mockUser", categoryId: 4, amount: 100, date: Calendar.current.date(byAdding: .month, value: -1, to: .init())!, latitude: nil, longitude: nil, defaultCurrency: "CZK"),
        RecordTO(recordId: 1120, note: "Note", username: "mockUser", categoryId: 5, amount: 100, date: Calendar.current.date(byAdding: .month, value: -3, to: .init())!, latitude: nil, longitude: nil, defaultCurrency: "CZK"),
        RecordTO(recordId: 139, note: "Note", username: "mockUser", categoryId: 6, amount: 100, date: Calendar.current.date(byAdding: .month, value: -3, to: .init())!, latitude: nil, longitude: nil, defaultCurrency: "CZK"),
        RecordTO(recordId: 112, note: "Note", username: "mockUser", categoryId: 7, amount: 100, date: Calendar.current.date(byAdding: .month, value: -5, to: .init())!, latitude: nil, longitude: nil, defaultCurrency: "CZK"),
        RecordTO(recordId: 21, note: "Note", username: "mockUser", categoryId: 1, amount: 100, date: Calendar.current.date(byAdding: .month, value: -5, to: .init())!, latitude: nil, longitude: nil, defaultCurrency: "CZK"),
        RecordTO(recordId: 210, note: "Note", username: "mockUser", categoryId: 2, amount: 100, date: Calendar.current.date(byAdding: .month, value: -2, to: .init())!, latitude: nil, longitude: nil, defaultCurrency: "CZK"),
        RecordTO(recordId: 2100, note: "Note", username: "mockUser", categoryId: 3, amount: 100, date: Calendar.current.date(byAdding: .month, value: -2, to: .init())!, latitude: nil, longitude: nil, defaultCurrency: "CZK"),
        RecordTO(recordId: 21110, note: "Note", username: "mockUser", categoryId: 4, amount: 100, date: Calendar.current.date(byAdding: .month, value: -1, to: .init())!, latitude: nil, longitude: nil, defaultCurrency: "CZK"),
        RecordTO(recordId: 21120, note: "Note", username: "mockUser", categoryId: 5, amount: 100, date: Calendar.current.date(byAdding: .month, value: -1, to: .init())!, latitude: nil, longitude: nil, defaultCurrency: "CZK"),
        RecordTO(recordId: 2139, note: "Note", username: "mockUser", categoryId: 6, amount: 100, date: Calendar.current.date(byAdding: .month, value: -5, to: .init())!, latitude: nil, longitude: nil, defaultCurrency: "CZK"),
        RecordTO(recordId: 2112, note: "Note", username: "mockUser", categoryId: 7, amount: 100, date: Calendar.current.date(byAdding: .month, value: -5, to: .init())!, latitude: nil, longitude: nil, defaultCurrency: "CZK"),
        RecordTO(recordId: 31, note: "Note", username: "mockUser", categoryId: 1, amount: 100, date: Calendar.current.date(byAdding: .month, value: -4, to: .init())!, latitude: nil, longitude: nil, defaultCurrency: "CZK"),
        RecordTO(recordId: 310, note: "Note", username: "mockUser", categoryId: 2, amount: 100, date: Calendar.current.date(byAdding: .month, value: -4, to: .init())!, latitude: nil, longitude: nil, defaultCurrency: "CZK"),
        RecordTO(recordId: 3100, note: "Note", username: "mockUser", categoryId: 3, amount: 100, date: Calendar.current.date(byAdding: .month, value: -3, to: .init())!, latitude: nil, longitude: nil, defaultCurrency: "CZK"),
        RecordTO(recordId: 31110, note: "Note", username: "mockUser", categoryId: 4, amount: 100, date: Calendar.current.date(byAdding: .month, value: -3, to: .init())!, latitude: nil, longitude: nil, defaultCurrency: "CZK"),
        RecordTO(recordId: 31120, note: "Note", username: "mockUser", categoryId: 5, amount: 100, date: Calendar.current.date(byAdding: .month, value: -2, to: .init())!, latitude: nil, longitude: nil, defaultCurrency: "CZK"),
        RecordTO(recordId: 3139, note: "Note", username: "mockUser", categoryId: 6, amount: 100, date: Calendar.current.date(byAdding: .month, value: -2, to: .init())!, latitude: nil, longitude: nil, defaultCurrency: "CZK"),
        RecordTO(recordId: 3112, note: "Note", username: "mockUser", categoryId: 7, amount: 100, date: Calendar.current.date(byAdding: .month, value: -1, to: .init())!, latitude: nil, longitude: nil, defaultCurrency: "CZK"),
        RecordTO(recordId: 41, note: "Note", username: "mockUser", categoryId: 1, amount: 100, date: Calendar.current.date(byAdding: .month, value: -1, to: .init())!, latitude: nil, longitude: nil, defaultCurrency: "CZK"),
        RecordTO(recordId: 410, note: "Note", username: "mockUser", categoryId: 2, amount: 100, date: Calendar.current.date(byAdding: .month, value: -6, to: .init())!, latitude: nil, longitude: nil, defaultCurrency: "CZK"),
        RecordTO(recordId: 4100, note: "Note", username: "mockUser", categoryId: 3, amount: 100, date: Calendar.current.date(byAdding: .month, value: -6, to: .init())!, latitude: nil, longitude: nil, defaultCurrency: "CZK"),
        RecordTO(recordId: 41110, note: "Note", username: "mockUser", categoryId: 4, amount: 100, date: Calendar.current.date(byAdding: .month, value: -4, to: .init())!, latitude: nil, longitude: nil, defaultCurrency: "CZK"),
        RecordTO(recordId: 41120, note: "Note", username: "mockUser", categoryId: 5, amount: 100, date: Calendar.current.date(byAdding: .month, value: -4, to: .init())!, latitude: nil, longitude: nil, defaultCurrency: "CZK"),
        RecordTO(recordId: 4139, note: "Note", username: "mockUser", categoryId: 6, amount: 100, date: Calendar.current.date(byAdding: .month, value: -2, to: .init())!, latitude: nil, longitude: nil, defaultCurrency: "CZK"),
        RecordTO(recordId: 4112, note: "Note", username: "mockUser", categoryId: 7, amount: 100, date: Calendar.current.date(byAdding: .month, value: -2, to: .init())!, latitude: nil, longitude: nil, defaultCurrency: "CZK")
    ]

    public let categories: [CategoryTO] = [
        CategoryTO(categoryId: 1, username: "mockUser", name: "B_Mock category 1", emojiIcon: "💰", mandatory: false),
        CategoryTO(categoryId: 2, username: "mockUser", name: "d_Mock category 2", emojiIcon: "💰", mandatory: false),
        CategoryTO(categoryId: 3, username: "mockUser", name: "A_Mock category 3", emojiIcon: "💰", mandatory: false),
        CategoryTO(categoryId: 4, username: "mockUser", name: "Č_Mock category 4", emojiIcon: "💰", mandatory: false),
        CategoryTO(categoryId: 5, username: "mockUser", name: "E_Mock category 5", emojiIcon: "💰", mandatory: false),
        CategoryTO(categoryId: 6, username: "mockUser", name: "Ě_Mock category 6", emojiIcon: "💰", mandatory: false),
        CategoryTO(categoryId: 7, username: "mockUser", name: "é_Mock category 7", emojiIcon: "💰", mandatory: false)
    ]
    public let users: [UserResponseTO] = [
        UserResponseTO(username: "mockUser", avatarImageURL: nil, defaultCurrency: "CZK", email: nil),
        UserResponseTO(username: "mockUser 2", avatarImageURL: nil, defaultCurrency: "USD", email: nil),
        UserResponseTO(username: "mockUser 3", avatarImageURL: nil, defaultCurrency: "EUR", email: nil)
    ]
    public let partners: [SharingResponseTO] = [
        SharingResponseTO(username: "sharingUser 1", defaultCurrency: "CZK"),
        SharingResponseTO(username: "sharingUser 2", defaultCurrency: "USD"),
        SharingResponseTO(username: "sharingUser 3", defaultCurrency: "Eur")
    ]
    public let currencies: [CurrencyTO] = [
        CurrencyTO(countryCode: "CZK", value: 1.0),
        CurrencyTO(countryCode: "EUR", value: 25.5),
        CurrencyTO(countryCode: "USD", value: 22.7)
    ]
    public lazy var regularPaymentToday: RegularPaymentResponse = {
        RegularPaymentResponse(regularPaymentId: 1, note: "Note", owner: "mockUser", category: 1, amount: 250, startDate: Date(), originalCurrency: "EUR", defaultCurrency: "CZK", originalAmount: 10, frequency: .week, lastProceededDate: Date(), nextProceedDate: Calendar.current.date(byAdding: .weekOfYear, value: 1, to: Date()))
    }()
    public lazy var regularPaymentTommorow: RegularPaymentResponse = {
        let date = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
        return RegularPaymentResponse(regularPaymentId: 2, note: "Note", owner: "mockUser", category: 1, amount: 250, startDate: date, originalCurrency: "EUR", defaultCurrency: "CZK", originalAmount: 10, frequency: .week, lastProceededDate: date, nextProceedDate: Calendar.current.date(byAdding: .weekOfYear, value: 1, to: Date()))
    }()
    public lazy var regularPaymentYesterday: RegularPaymentResponse = {
        let date = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        return RegularPaymentResponse(regularPaymentId: 3, note: "Note", owner: "mockUser", category: 1, amount: 250, startDate: date, originalCurrency: "EUR", defaultCurrency: "CZK", originalAmount: 10, frequency: .week, lastProceededDate: date, nextProceedDate: Calendar.current.date(byAdding: .weekOfYear, value: 1, to: date))
    }()
    public lazy var regularPaymentNextWeek: RegularPaymentResponse = {
        let date = Calendar.current.date(byAdding: .weekOfYear, value: 1, to: Date())!
        return RegularPaymentResponse(regularPaymentId: 4, note: "Note", owner: "mockUser", category: 1, amount: 250, startDate: date, originalCurrency: "EUR", defaultCurrency: "CZK", originalAmount: 10, frequency: .week, lastProceededDate: date, nextProceedDate: Calendar.current.date(byAdding: .weekOfYear, value: 1, to: date))
    }()
    public lazy var regularPaymentNextTwoWeeks: RegularPaymentResponse = {
        let date = Calendar.current.date(byAdding: .weekOfYear, value: 2, to: Date())!
        return RegularPaymentResponse(regularPaymentId: 5, note: "Note", owner: "mockUser", category: 1, amount: 250, startDate: date, originalCurrency: "EUR", defaultCurrency: "CZK", originalAmount: 10, frequency: .week, lastProceededDate: date, nextProceedDate: Calendar.current.date(byAdding: .weekOfYear, value: 1, to: date))
    }()
    public lazy var regularPaymentNextThreeWeeks: RegularPaymentResponse = {
        let date = Calendar.current.date(byAdding: .weekOfYear, value: 3, to: Date())!
        return RegularPaymentResponse(regularPaymentId: 6, note: "Note", owner: "mockUser", category: 1, amount: 250, startDate: date, originalCurrency: "EUR", defaultCurrency: "CZK", originalAmount: 10, frequency: .week, lastProceededDate: date, nextProceedDate: Calendar.current.date(byAdding: .weekOfYear, value: 1, to: date))
    }()
    public lazy var regularPaymentNextFourWeeks: RegularPaymentResponse = {
        let date = Calendar.current.date(byAdding: .weekOfYear, value: 4, to: Date())!
        return RegularPaymentResponse(regularPaymentId: 7, note: "Note", owner: "mockUser", category: 1, amount: 250, startDate: date, originalCurrency: "EUR", defaultCurrency: "CZK", originalAmount: 10, frequency: .week, lastProceededDate: date, nextProceedDate: Calendar.current.date(byAdding: .weekOfYear, value: 1, to: date))
    }()
    public lazy var regularPaymentNextMonth: RegularPaymentResponse = {
        let date = Calendar.current.date(byAdding: .month, value: 1, to: Date())!
        return RegularPaymentResponse(regularPaymentId: 8, note: "Note", owner: "mockUser", category: 1, amount: 250, startDate: date, originalCurrency: "EUR", defaultCurrency: "CZK", originalAmount: 10, frequency: .week, lastProceededDate: date, nextProceedDate: Calendar.current.date(byAdding: .weekOfYear, value: 1, to: date))
    }()
    public lazy var regularPaymentNextTwoMonths: RegularPaymentResponse = {
        let date = Calendar.current.date(byAdding: .month, value: 2, to: Date())!
        return RegularPaymentResponse(regularPaymentId: 9, note: "Note", owner: "mockUser", category: 1, amount: 250, startDate: date, originalCurrency: "EUR", defaultCurrency: "CZK", originalAmount: 10, frequency: .week, lastProceededDate: date, nextProceedDate: Calendar.current.date(byAdding: .weekOfYear, value: 1, to: date))
    }()
    public lazy var regularPaymentNextThreeMonths: RegularPaymentResponse = {
        let date = Calendar.current.date(byAdding: .month, value: 3, to: Date())!
        return RegularPaymentResponse(regularPaymentId: 10, note: "Note", owner: "mockUser", category: 1, amount: 250, startDate: date, originalCurrency: "EUR", defaultCurrency: "CZK", originalAmount: 10, frequency: .week, lastProceededDate: date, nextProceedDate: Calendar.current.date(byAdding: .weekOfYear, value: 1, to: date))
    }()
    public lazy var regularPaymentNextFourMonths: RegularPaymentResponse = {
        let date = Calendar.current.date(byAdding: .month, value: 4, to: Date())!
        return RegularPaymentResponse(regularPaymentId: 11, note: "Note", owner: "mockUser", category: 1, amount: 250, startDate: date, originalCurrency: "EUR", defaultCurrency: "CZK", originalAmount: 10, frequency: .week, lastProceededDate: date, nextProceedDate: Calendar.current.date(byAdding: .weekOfYear, value: 1, to: date))
    }()
    public lazy var regularPaymentNextFiveMonths: RegularPaymentResponse = {
        let date = Calendar.current.date(byAdding: .month, value: 5, to: Date())!
        return RegularPaymentResponse(regularPaymentId: 12, note: "Note", owner: "mockUser", category: 1, amount: 250, startDate: date, originalCurrency: "EUR", defaultCurrency: "CZK", originalAmount: 10, frequency: .week, lastProceededDate: date, nextProceedDate: Calendar.current.date(byAdding: .weekOfYear, value: 1, to: date))
    }()
    public lazy var regularPaymentNextSixMonths: RegularPaymentResponse = {
        let date = Calendar.current.date(byAdding: .month, value: 6, to: Date())!
        return RegularPaymentResponse(regularPaymentId: 13, note: "Note", owner: "mockUser", category: 1, amount: 250, startDate: date, originalCurrency: "EUR", defaultCurrency: "CZK", originalAmount: 10, frequency: .week, lastProceededDate: date, nextProceedDate: Calendar.current.date(byAdding: .weekOfYear, value: 1, to: date))
    }()
    public lazy var regularPaymentNextSevenMonths: RegularPaymentResponse = {
        let date = Calendar.current.date(byAdding: .month, value: 7, to: Date())!
        return RegularPaymentResponse(regularPaymentId: 14, note: "Note", owner: "mockUser", category: 1, amount: 250, startDate: date, originalCurrency: "EUR", defaultCurrency: "CZK", originalAmount: 10, frequency: .week, lastProceededDate: date, nextProceedDate: Calendar.current.date(byAdding: .weekOfYear, value: 1, to: date))
    }()
    public lazy var regularPaymentNextEightMonths: RegularPaymentResponse = {
        let date = Calendar.current.date(byAdding: .month, value: 8, to: Date())!
        return RegularPaymentResponse(regularPaymentId: 15, note: "Note", owner: "mockUser", category: 1, amount: 250, startDate: date, originalCurrency: "EUR", defaultCurrency: "CZK", originalAmount: 10, frequency: .week, lastProceededDate: date, nextProceedDate: Calendar.current.date(byAdding: .weekOfYear, value: 1, to: date))
    }()
    public lazy var regularPaymentNextNineMonths: RegularPaymentResponse = {
        let date = Calendar.current.date(byAdding: .month, value: 9, to: Date())!
        return RegularPaymentResponse(regularPaymentId: 16, note: "Note", owner: "mockUser", category: 1, amount: 250, startDate: date, originalCurrency: "EUR", defaultCurrency: "CZK", originalAmount: 10, frequency: .week, lastProceededDate: date, nextProceedDate: Calendar.current.date(byAdding: .weekOfYear, value: 1, to: date))
    }()
    public lazy var regularPaymentNextTenMonths: RegularPaymentResponse = {
        let date = Calendar.current.date(byAdding: .month, value: 10, to: Date())!
        return RegularPaymentResponse(regularPaymentId: 17, note: "Note", owner: "mockUser", category: 1, amount: 250, startDate: date, originalCurrency: "EUR", defaultCurrency: "CZK", originalAmount: 10, frequency: .week, lastProceededDate: date, nextProceedDate: Calendar.current.date(byAdding: .weekOfYear, value: 1, to: date))
    }()
    public lazy var regularPaymentNextElevenMonths: RegularPaymentResponse = {
        let date = Calendar.current.date(byAdding: .month, value: 11, to: Date())!
        return RegularPaymentResponse(regularPaymentId: 18, note: "Note", owner: "mockUser", category: 1, amount: 250, startDate: date, originalCurrency: "EUR", defaultCurrency: "CZK", originalAmount: 10, frequency: .week, lastProceededDate: date, nextProceedDate: Calendar.current.date(byAdding: .weekOfYear, value: 1, to: date))
    }()
    public lazy var regularPaymentNextYear: RegularPaymentResponse = {
        let date = Calendar.current.date(byAdding: .year, value: 1, to: Date())!
        return RegularPaymentResponse(regularPaymentId: 19, note: "Note", owner: "mockUser", category: 1, amount: 250, startDate: date, originalCurrency: "EUR", defaultCurrency: "CZK", originalAmount: 10, frequency: .week, lastProceededDate: date, nextProceedDate: Calendar.current.date(byAdding: .weekOfYear, value: 1, to: date))
    }()

    public lazy var regularPayments: [RegularPaymentResponse] = {
        [
            regularPaymentToday,
            regularPaymentTommorow,
            regularPaymentYesterday,
            regularPaymentNextWeek,
            regularPaymentNextTwoWeeks,
            regularPaymentNextThreeWeeks,
            regularPaymentNextFourWeeks,
            regularPaymentNextMonth,
            regularPaymentNextTwoMonths,
            regularPaymentNextThreeMonths,
            regularPaymentNextFourMonths,
            regularPaymentNextFiveMonths,
            regularPaymentNextSixMonths,
            regularPaymentNextSevenMonths,
            regularPaymentNextEightMonths,
            regularPaymentNextNineMonths,
            regularPaymentNextTenMonths,
            regularPaymentNextElevenMonths,
            regularPaymentNextYear
        ]
    }()

    // MARK: - Init date
    public func initData(requestObject: InitRequestTO, completionHandler: @escaping (Result<InitResponseTO, Error>) -> Void) {
        completionHandler(.success(InitResponseTO(records: records, categories: categories, users: users, partners: partners)))
    }

    // MARK: - Record
    public func insert(newRecord: NewRecordRequestTO, completionHandler: @escaping (Result<RecordTO, Error>) -> Void) {
        completionHandler(.success(RecordTO(recordId: Int.random(in: 1...1_000_000), note: newRecord.note, username: newRecord.username, categoryId: Int(newRecord.categoryId), amount: newRecord.amount, date: newRecord.date, latitude: newRecord.latitude, longitude: newRecord.longitude, defaultCurrency: newRecord.defaultCurrency)))
    }
    public func update(record: UpdateRecordRequestTO, completionHandler: @escaping (Result<RecordTO, Error>) -> Void) {
        completionHandler(.success(RecordTO(recordId: record.recordId, note: record.note, username: record.username, categoryId: Int(record.categoryId), amount: record.amount, date: record.date, latitude: record.latitude, longitude: record.longitude, defaultCurrency: record.defaultCurrency)))
    }
    public func delete(record: DeleteRecordRequestTO, completionHandler: @escaping (Result<RecordTO, Error>) -> Void) {
        completionHandler(.success((RecordTO(recordId: record.recordId, note: record.note, username: record.username, categoryId: Int(record.categoryId), amount: record.amount, date: record.date, latitude: record.latitude, longitude: record.longitude, defaultCurrency: record.defaultCurrency))))
    }

    // MARK: - Category
    public func insert(category: NewCategoryRequestTO, completionHandler: @escaping (Result<CategoryTO, Error>) -> Void) {
        completionHandler(.success(CategoryTO(categoryId: Int.random(in: 1...1_000_000), username: "mockUser", name: category.name, emojiIcon: category.emojiIcon, mandatory: category.mandatory)))
    }
    public func update(category: CategoryTO, completionHandler: @escaping (Result<CategoryTO, Error>) -> Void) {
        completionHandler(.success(category))
    }
    public func delete(category requestObject: DeleteCategoryRequestTO, completionHandler: @escaping (Result<CategoryTO, Error>) -> Void) {
        completionHandler(.success((CategoryTO(categoryId: requestObject.categoryIdToDelete, username: nil, name: "", emojiIcon: nil, mandatory: false))))
    }

    // MARK: - User
    public func register(request requestObject: RegisterRequestTO, completionHandler: @escaping ((Result<Void, Error>) -> Void)) {
        completionHandler(.success(()))
    }
    public func login(request requestObject: LoginRequestTO, completionHandler: @escaping (Result<Void, Error>) -> Void) {
        completionHandler(.success(()))
    }
    public func logout(request requestObject: LogoutRequestTO, completionHandler: @escaping (Result<Void, Error>) -> Void) {
        completionHandler(.success(()))
    }

    public func passwordReset(requestObject: PasswordResetRequestTO, completionHandler: @escaping (Result<Void, Error>) -> Void) {
        completionHandler(.success(()))
    }

    public func changePassword(requestObject: ChangePasswordRequestTO, completionHandler: @escaping (Result<Void, Error>) -> Void) {
        completionHandler(.success(()))
    }

    // MARK: - Sharing
    public func newPartner(request requestObject: NewPartnerRequestTO, completionHandler: @escaping ((Result<Void, Error>) -> Void)) {
        completionHandler(.success(()))
    }
    public func removePartner(request requestObject: RemovePartnerRequestTO, completionHandler: @escaping ((Result<Void, Error>) -> Void)) {
        completionHandler(.success(()))
    }

    // MARK: - Exchange rate
    public func exchangeRates(completionHandler: @escaping (Result<[CurrencyTO], Error>) -> Void) {
        completionHandler(.success(currencies))
    }

    // MARK: - Regular Payment
    public func regularPayments(completionHandler: @escaping (Result<[RegularPaymentResponse], Error>) -> Void) {
        completionHandler(.success(regularPayments.shuffled()))
    }

    public func newRegularPayment(requestObject: NewRegularPaymentRequest, completionHandler: @escaping (Result<NewRegularPaymentResponse, Error>) -> Void) {
        completionHandler(.success(NewRegularPaymentResponse(regularPaymentId: 1,
                                                             note: requestObject.note,
                                                             owner: "mockUser",
                                                             category: requestObject.categoryId,
                                                             amount: requestObject.amount,
                                                             startDate: requestObject.startDate,
                                                             originalCurrency: requestObject.originalCurrencyId,
                                                             defaultCurrency: requestObject.defaultCurrencyId,
                                                             originalAmount: requestObject.originalAmount,
                                                             frequency: requestObject.frequency,
                                                             lastProceededDate: nil,
                                                             nextProceedDate: nil)))
    }

    public func updateRegularPayment(requestObject: UpdateRegularPaymentRequest, completionHandler: @escaping (Result<UpdateRegularPaymentResponse, Error>) -> Void) {
        completionHandler(.success(UpdateRegularPaymentResponse(regularPaymentId: 1,
                                                                note: requestObject.note,
                                                                owner: "mockUser",
                                                                category: requestObject.categoryId,
                                                                amount: requestObject.amount,
                                                                startDate: requestObject.startDate,
                                                                originalCurrency: requestObject.originalCurrencyId,
                                                                defaultCurrency: requestObject.defaultCurrencyId,
                                                                originalAmount: requestObject.originalAmount,
                                                                frequency: requestObject.frequency,
                                                                lastProceededDate: nil,
                                                                nextProceedDate: nil)))
    }

    public func deleteRegularPayment(requestObject: DeleteRegularPaymentRequest, completionHandler: @escaping (Result<RegularPaymentResponse, Error>) -> Void) {
        completionHandler(.success((RegularPaymentResponse(regularPaymentId: requestObject.regularPaymentId, note: nil, owner: "", category: 0, amount: 0.0, startDate: .init(), originalCurrency: nil, defaultCurrency: "CZK", originalAmount: nil, frequency: .month, lastProceededDate: nil, nextProceedDate: nil))))
    }

    // MARK: - Today widget
    public func todayWidgetData(requestObject: TodayWidgetRequestTO, completionHandler: @escaping (Result<TodayWidgetResponseTO, Error>) -> Void) {
    }

    // MARK: - Notification
    public func updateNotificationToken(request requestObject: UpdateNotificationTokenTO, completionHandler: ((Result<Void, Error>) -> Void)?) {
    }

    // MARK: - Receipt
    public func verify(receipt data: Data?, completionHandler: ((Result<VerifyActiveSubscriptionResponseTO, Error>) -> Void)?) {
    }
}

public struct MockDataGenerator {
    public var recordsInMonth = 150
    public var numberOfMonths = 12 * 6

    public var generatedRecords: [RecordTO] {
        var records: [RecordTO] = []
        var currentMonth = 0
        var lastRecordId = 0

        while currentMonth < numberOfMonths {
            (1...recordsInMonth).forEach { (_) in
                var date = Date()
                date = Calendar.current.date(byAdding: .month, value: -currentMonth, to: date)!
                date = Calendar.current.date(bySetting: .day, value: Int.random(in: 1...25), of: date)!
                date = Calendar.current.date(bySetting: .hour, value: Int.random(in: 1...22), of: date)!
                date = Calendar.current.date(bySetting: .minute, value: Int.random(in: 1...59), of: date)!
                let record = generateRecord(recordId: lastRecordId + 1, categoryId: 1, date: date)
                lastRecordId = record.recordId!
                records.append(record)
            }
            currentMonth += 1
        }

        return records
    }

    public init() { }

    public func generateRecord(recordId: Int = Int.random(in: 1...1_000_000), categoryId: Int = Int.random(in: 1...1_000_000), date: Date = Date()) -> RecordTO {
        let record = RecordTO(recordId: recordId, note: "\(recordId) Mock note", username: "mockUser", categoryId: categoryId, amount: Double.random(in: 1...100_000), date: date, latitude: Double.random(in: 1...80_000), longitude: Double.random(in: 1...80_000), originalCurrency: "USD", originalAmount: Double.random(in: 1...100_000), defaultCurrency: "EUR")
        return record
    }
}
// swiftlint:enable required_deinit

struct MockSecurityHelper: SecurityHelperProtocol {
    var log: LogDelegate.Type?
    var username: String?
    var password: String?
    var canLogIn: Bool = false
    var loggedIn: Bool = false
    var bearerToken: String?

    func removeAll() { }
}
