//
//  Api.swift
//  MyExpenses
//
//  Created by Marek Pridal on 10/07/2019.
//  Copyright © 2019 Marek Pridal. All rights reserved.
//

import Foundation

public protocol Api: class {
    var securityHelper: SecurityHelperProtocol { get set }

    // MARK: - Init date
    func initData(requestObject: InitRequestTO, completionHandler: @escaping (Result<InitResponseTO, Error>) -> Void)

    // MARK: - Record
    func insert(newRecord: NewRecordRequestTO, completionHandler: @escaping (Result<RecordTO, Error>) -> Void)
    func update(record: UpdateRecordRequestTO, completionHandler: @escaping (Result<RecordTO, Error>) -> Void)
    func delete(record: DeleteRecordRequestTO, completionHandler: @escaping (Result<RecordTO, Error>) -> Void)

    // MARK: - Category
    func insert(category: NewCategoryRequestTO, completionHandler: @escaping (Result<CategoryTO, Error>) -> Void)
    func update(category: CategoryTO, completionHandler: @escaping (Result<CategoryTO, Error>) -> Void)
    func delete(category requestObject: DeleteCategoryRequestTO, completionHandler: @escaping (Result<CategoryTO, Error>) -> Void)

    // MARK: - User
    func register(request requestObject: RegisterRequestTO, completionHandler: @escaping ((Result<Void, Error>) -> Void))
    func login(request requestObject: LoginRequestTO, completionHandler: @escaping (Result<Void, Error>) -> Void)
    func logout(request requestObject: LogoutRequestTO, completionHandler: @escaping (Result<Void, Error>) -> Void)
    func passwordReset(requestObject: PasswordResetRequestTO, completionHandler: @escaping (Result<Void, Error>) -> Void)
    func changePassword(requestObject: ChangePasswordRequestTO, completionHandler: @escaping (Result<Void, Error>) -> Void)

    // MARK: - Sharing
    func newPartner(request requestObject: NewPartnerRequestTO, completionHandler: @escaping ((Result<Void, Error>) -> Void))
    func removePartner(request requestObject: RemovePartnerRequestTO, completionHandler: @escaping ((Result<Void, Error>) -> Void))

    // MARK: - Exchange rate
    func exchangeRates(completionHandler: @escaping (Result<[CurrencyTO], Error>) -> Void)

    // MARK: - Regular Payment
    func regularPayments(completionHandler: @escaping (Result<[RegularPaymentResponse], Error>) -> Void)
    func newRegularPayment(requestObject: NewRegularPaymentRequest, completionHandler: @escaping (Result<NewRegularPaymentResponse, Error>) -> Void)
    func updateRegularPayment(requestObject: UpdateRegularPaymentRequest, completionHandler: @escaping (Result<UpdateRegularPaymentResponse, Error>) -> Void)
    func deleteRegularPayment(requestObject: DeleteRegularPaymentRequest, completionHandler: @escaping (Result<RegularPaymentResponse, Error>) -> Void)

    // MARK: - Today widget
    func todayWidgetData(requestObject: TodayWidgetRequestTO, completionHandler: @escaping (Result<TodayWidgetResponseTO, Error>) -> Void)

    // MARK: - Notification
    func updateNotificationToken(request requestObject: UpdateNotificationTokenTO, completionHandler: ((Result<Void, Error>) -> Void)?)

    // MARK: - Receipt
    func verify(receipt data: Data?, completionHandler: ((Result<VerifyActiveSubscriptionResponseTO, Error>) -> Void)?)
}
