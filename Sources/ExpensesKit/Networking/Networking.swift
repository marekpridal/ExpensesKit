//
//  Networking.swift
//  MyExpenses
//
//  Created by Marek Pridal on 14.05.17.
//  Copyright © 2017 Marek Pridal. All rights reserved.
//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

// swiftlint:disable type_body_length required_deinit file_length nesting function_body_length
public final class Networking: NSObject, Api {
    // MARK: - Public properties
    public var securityHelper: SecurityHelperProtocol

    // MARK: - Private properties
    private let endpoint: EndpointProtocol
    private let log: LogDelegate.Type?
    #if !os(Linux)
    private let certificatePinningHandler: ((SecTrust, @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) -> Void)?
    #endif
    private var verifyReceiptRequestCalled = false

    fileprivate static var encoder: JSONEncoder {
        if #available(iOS 10, macOS 10.12, tvOS 10.0, *) {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            return encoder
        } else {
            let encoder = JSONEncoder()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            encoder.dateEncodingStrategy = .formatted(dateFormatter)
            return encoder
        }
    }

    fileprivate static var decoder: JSONDecoder {
        if #available(iOS 10, macOS 10.12, tvOS 10.0, *) {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            return decoder
        } else {
            let decoder = JSONDecoder()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            return decoder
        }
    }

    // MARK: - URL Session
    lazy var session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)

    #if os(Linux)
    public init(endpoint: EndpointProtocol, logDelegate: LogDelegate.Type?, securityHelper: SecurityHelperProtocol) {
        self.endpoint = endpoint
        self.log = logDelegate
        self.securityHelper = securityHelper
    }
    #else
    public init(endpoint: EndpointProtocol, logDelegate: LogDelegate.Type?, securityHelper: SecurityHelperProtocol, certificatePinningHandler: ((SecTrust, @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) -> Void)?) {
        self.endpoint = endpoint
        self.log = logDelegate
        self.securityHelper = securityHelper
        self.certificatePinningHandler = certificatePinningHandler
    }
    #endif

    // MARK: - Init date
    public func initData(requestObject: InitRequestTO, completionHandler: @escaping (Result<InitResponseTO, Error>) -> Void) {
        guard let bearerToken = securityHelper.bearerToken else {
            DispatchQueue.main.async {
                completionHandler(.failure(MissingBearerToken()))
            }
            return
        }

        var request = URLRequest(url: endpoint.initData, cachePolicy: .useProtocolCachePolicy)
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        request.setValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
        request.setValue("ios-app", forHTTPHeaderField: "User-Agent")
        request.setValue(Environment.appVersion, forHTTPHeaderField: "APP_VERSION")
        request.setValue(Environment.iosVersion, forHTTPHeaderField: "IOS_VERSION")
        request.httpMethod = "POST"

        do {
            request.httpBody = try JSONEncoder().encode(requestObject)
        } catch let error {
            DispatchQueue.main.async {
                completionHandler(.failure(error))
            }
        }

        log?.request(request)

        session.dataTask(with: request) { [weak self] data, response, error in
            self?.log?.response(response, data: data)
            if let error = error {
                DispatchQueue.main.async {
                    if (error as NSError).code == NSURLErrorCancelled {
                        completionHandler(.failure(CertificatePinningFailed()))
                        return
                    }
                    completionHandler(.failure(error))
                }
            } else if let error = HTTPResponseCodeHandler.error(for: (response as? HTTPURLResponse)?.statusCode ?? 0, response: data) {
                DispatchQueue.main.async {
                    if error is WrongUsernameOrPasswordError {
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: Identifier.logout), object: error)
                    }
                    completionHandler(.failure(error))
                }
            } else if let responseData = data {
                do {
                    let responseObject = try Networking.decoder.decode(InitResponseTO.self, from: responseData)
                    DispatchQueue.main.async {
                        completionHandler(.success(responseObject))
                    }
                } catch let error {
                    DispatchQueue.main.async {
                        completionHandler(.failure(error))
                    }
                }
            } else {
                DispatchQueue.main.async {
                    completionHandler(.failure(GeneralError()))
                }
            }
        }.resume()
    }

    // MARK: - Record
    public func insert(newRecord: NewRecordRequestTO, completionHandler: @escaping (Result<RecordTO, Error>) -> Void) {
        guard let bearerToken = securityHelper.bearerToken else {
            DispatchQueue.main.async {
                completionHandler(.failure(MissingBearerToken()))
            }
            return
        }
        var request = URLRequest(url: endpoint.record, cachePolicy: .useProtocolCachePolicy)
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        request.setValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
        request.setValue("ios-app", forHTTPHeaderField: "User-Agent")
        request.setValue(Environment.appVersion, forHTTPHeaderField: "APP_VERSION")
        request.setValue(Environment.iosVersion, forHTTPHeaderField: "IOS_VERSION")

        do {
            let postData = try Networking.encoder.encode(newRecord)
            request.httpMethod = "POST"
            request.httpBody = postData
        } catch let error {
            DispatchQueue.main.async {
                completionHandler(.failure(error))
            }
        }

        log?.request(request)

        session.dataTask(with: request) { [weak self] data, response, error in
            self?.log?.response(response, data: data)
            if let error = error {
                DispatchQueue.main.async {
                    if (error as NSError).code == NSURLErrorCancelled {
                        completionHandler(.failure(CertificatePinningFailed()))
                        return
                    }
                    completionHandler(.failure(error))
                }
            } else if let error = HTTPResponseCodeHandler.error(for: (response as? HTTPURLResponse)?.statusCode ?? 0, response: data) {
                DispatchQueue.main.async {
                    if error is WrongUsernameOrPasswordError {
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: Identifier.logout), object: error)
                    }
                    completionHandler(.failure(error))
                }
            } else if let responseData = data {
                do {
                    let responseObject = try Networking.decoder.decode(RecordTO.self, from: responseData)
                    DispatchQueue.main.async {
                        completionHandler(.success(responseObject))
                    }
                } catch let error {
                    DispatchQueue.main.async {
                        completionHandler(.failure(error))
                    }
                }
            } else {
                DispatchQueue.main.async {
                    completionHandler(.failure(GeneralError()))
                }
            }
        }.resume()
    }

    public func update(record: UpdateRecordRequestTO, completionHandler: @escaping (Result<RecordTO, Error>) -> Void) {
        guard let bearerToken = securityHelper.bearerToken else {
            DispatchQueue.main.async {
                completionHandler(.failure(MissingBearerToken()))
            }
            return
        }
        var request = URLRequest(url: endpoint.record, cachePolicy: .useProtocolCachePolicy)
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        request.setValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
        request.setValue("ios-app", forHTTPHeaderField: "User-Agent")
        request.setValue(Environment.appVersion, forHTTPHeaderField: "APP_VERSION")
        request.setValue(Environment.iosVersion, forHTTPHeaderField: "IOS_VERSION")

        do {
            let postData = try Networking.encoder.encode(record)
            request.httpMethod = "PUT"
            request.httpBody = postData
        } catch let error {
            DispatchQueue.main.async {
                completionHandler(.failure(error))
            }
        }

        log?.request(request)

        session.dataTask(with: request) { [weak self] data, response, error in
            self?.log?.response(response, data: data)
            if let error = error {
                DispatchQueue.main.async {
                    if (error as NSError).code == NSURLErrorCancelled {
                        completionHandler(.failure(CertificatePinningFailed()))
                        return
                    }
                    completionHandler(.failure(error))
                }
            } else if let error = HTTPResponseCodeHandler.error(for: (response as? HTTPURLResponse)?.statusCode ?? 0, response: data) {
                DispatchQueue.main.async {
                    if error is WrongUsernameOrPasswordError {
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: Identifier.logout), object: error)
                    }
                    completionHandler(.failure(error))
                }
            } else if let responseData = data {
                do {
                    let responseObject = try Networking.decoder.decode(RecordTO.self, from: responseData)
                    DispatchQueue.main.async {
                        completionHandler(.success(responseObject))
                    }
                } catch let error {
                    DispatchQueue.main.async {
                        completionHandler(.failure(error))
                    }
                }
            } else {
                DispatchQueue.main.async {
                    completionHandler(.failure(GeneralError()))
                }
            }
        }.resume()
    }

    public func delete(record: DeleteRecordRequestTO, completionHandler: @escaping (Result<RecordTO, Error>) -> Void) {
        guard let bearerToken = securityHelper.bearerToken else {
            DispatchQueue.main.async {
                completionHandler(.failure(MissingBearerToken()))
            }
            return
        }
        do {
            let postData = try Networking.encoder.encode(record)
            var request = URLRequest(url: endpoint.record, cachePolicy: .useProtocolCachePolicy)
            request.setValue("application/json", forHTTPHeaderField: "content-type")
            request.setValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
            request.setValue("ios-app", forHTTPHeaderField: "User-Agent")
            request.setValue(Environment.appVersion, forHTTPHeaderField: "APP_VERSION")
            request.setValue(Environment.iosVersion, forHTTPHeaderField: "IOS_VERSION")
            request.httpMethod = "DELETE"
            request.httpBody = postData

            log?.request(request)

            session.dataTask(with: request) { [weak self] data, response, error in
                self?.log?.response(response, data: data)
                if let error = error {
                    DispatchQueue.main.async {
                        if (error as NSError).code == NSURLErrorCancelled {
                            completionHandler(.failure(CertificatePinningFailed()))
                            return
                        }
                        completionHandler(.failure(error))
                    }
                } else if let error = HTTPResponseCodeHandler.error(for: (response as? HTTPURLResponse)?.statusCode ?? 0, response: data) {
                    DispatchQueue.main.async {
                        if error is WrongUsernameOrPasswordError {
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: Identifier.logout), object: error)
                        }
                        completionHandler(.failure(error))
                    }
                } else if let responseData = data {
                    do {
                        let responseObject = try Networking.decoder.decode(RecordTO.self, from: responseData)
                        DispatchQueue.main.async {
                            completionHandler(.success(responseObject))
                        }
                    } catch let error {
                        DispatchQueue.main.async {
                            completionHandler(.failure(error))
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        completionHandler(.failure(GeneralError()))
                    }
                }
            }.resume()
        } catch let error {
            DispatchQueue.main.async {
                completionHandler(.failure(error))
            }
        }
    }

    // MARK: - Category
    public func insert(category: NewCategoryRequestTO, completionHandler: @escaping (Result<CategoryTO, Error>) -> Void) {
        guard let bearerToken = securityHelper.bearerToken else {
            DispatchQueue.main.async {
                completionHandler(.failure(MissingBearerToken()))
            }
            return
        }
        do {
            let postData = try Networking.encoder.encode(category)

            var request = URLRequest(url: endpoint.category, cachePolicy: .useProtocolCachePolicy)
            request.setValue("application/json", forHTTPHeaderField: "content-type")
            request.setValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
            request.setValue("ios-app", forHTTPHeaderField: "User-Agent")
            request.setValue(Environment.appVersion, forHTTPHeaderField: "APP_VERSION")
            request.setValue(Environment.iosVersion, forHTTPHeaderField: "IOS_VERSION")
            request.httpMethod = "POST"
            request.httpBody = postData

            log?.request(request)

            session.dataTask(with: request) { [weak self] data, response, error in
                self?.log?.response(response, data: data)
                if let error = error {
                    DispatchQueue.main.async {
                        if (error as NSError).code == NSURLErrorCancelled {
                            completionHandler(.failure(CertificatePinningFailed()))
                            return
                        }
                        completionHandler(.failure(error))
                    }
                } else if let error = HTTPResponseCodeHandler.error(for: (response as? HTTPURLResponse)?.statusCode ?? 0, response: data) {
                    DispatchQueue.main.async {
                        if error is WrongUsernameOrPasswordError {
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: Identifier.logout), object: error)
                        }
                        completionHandler(.failure(error))
                    }
                } else if let responseData = data {
                    do {
                        let responseObject = try Networking.decoder.decode(CategoryTO.self, from: responseData)
                        DispatchQueue.main.async {
                            completionHandler(.success(responseObject))
                        }
                    } catch let error {
                        DispatchQueue.main.async {
                            completionHandler(.failure(error))
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        completionHandler(.failure(GeneralError()))
                    }
                }
            }.resume()
        } catch let error {
            DispatchQueue.main.async {
                completionHandler(.failure(error))
            }
        }
    }

    public func update(category: CategoryTO, completionHandler: @escaping (Result<CategoryTO, Error>) -> Void) {
        guard let bearerToken = securityHelper.bearerToken else {
            DispatchQueue.main.async {
                completionHandler(.failure(MissingBearerToken()))
            }
            return
        }
        var request = URLRequest(url: endpoint.category, cachePolicy: .useProtocolCachePolicy)
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        request.setValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
        request.setValue("ios-app", forHTTPHeaderField: "User-Agent")
        request.setValue(Environment.appVersion, forHTTPHeaderField: "APP_VERSION")
        request.setValue(Environment.iosVersion, forHTTPHeaderField: "IOS_VERSION")

        do {
            let postData = try Networking.encoder.encode(category)
            request.httpMethod = "PUT"
            request.httpBody = postData
        } catch let error {
            DispatchQueue.main.async {
                completionHandler(.failure(error))
            }
        }

        log?.request(request)

        session.dataTask(with: request) { [weak self] data, response, error in
            self?.log?.response(response, data: data)
            if let error = error {
                DispatchQueue.main.async {
                    if (error as NSError).code == NSURLErrorCancelled {
                        completionHandler(.failure(CertificatePinningFailed()))
                        return
                    }
                    completionHandler(.failure(error))
                }
            } else if let error = HTTPResponseCodeHandler.error(for: (response as? HTTPURLResponse)?.statusCode ?? 0, response: data) {
                DispatchQueue.main.async {
                    if error is WrongUsernameOrPasswordError {
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: Identifier.logout), object: error)
                    }
                    completionHandler(.failure(error))
                }
            } else if let responseData = data {
                do {
                    let responseObject = try Networking.decoder.decode(CategoryTO.self, from: responseData)
                    DispatchQueue.main.async {
                        completionHandler(.success(responseObject))
                    }
                } catch let error {
                    DispatchQueue.main.async {
                        completionHandler(.failure(error))
                    }
                }
            } else {
                DispatchQueue.main.async {
                    completionHandler(.failure(GeneralError()))
                }
            }
        }.resume()
    }

    public func delete(category requestObject: DeleteCategoryRequestTO, completionHandler: @escaping (Result<CategoryTO, Error>) -> Void) {
        guard let bearerToken = securityHelper.bearerToken else {
            DispatchQueue.main.async {
                completionHandler(.failure(MissingBearerToken()))
            }
            return
        }
        var request = URLRequest(url: endpoint.category, cachePolicy: .useProtocolCachePolicy)
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        request.setValue("ios-app", forHTTPHeaderField: "User-Agent")
        request.setValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
        request.setValue(Environment.appVersion, forHTTPHeaderField: "APP_VERSION")
        request.setValue(Environment.iosVersion, forHTTPHeaderField: "IOS_VERSION")

        do {
            let encoder = JSONEncoder()
            let postData = try encoder.encode(requestObject)

            request.httpMethod = "DELETE"
            request.httpBody = postData

            log?.request(request)

            session.dataTask(with: request) { [weak self] data, response, error in
                self?.log?.response(response, data: data)
                if let error = error {
                    DispatchQueue.main.async {
                        if (error as NSError).code == NSURLErrorCancelled {
                            completionHandler(.failure(CertificatePinningFailed()))
                            return
                        }
                        completionHandler(.failure(error))
                    }
                } else if let error = HTTPResponseCodeHandler.error(for: (response as? HTTPURLResponse)?.statusCode ?? 0, response: data) {
                    DispatchQueue.main.async {
                        if error is WrongUsernameOrPasswordError {
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: Identifier.logout), object: error)
                        }
                        completionHandler(.failure(error))
                    }
                } else if let responseData = data {
                    do {
                        let responseObject = try Networking.decoder.decode(CategoryTO.self, from: responseData)
                        DispatchQueue.main.async {
                            completionHandler(.success(responseObject))
                        }
                    } catch let error {
                        DispatchQueue.main.async {
                            completionHandler(.failure(error))
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        completionHandler(.failure(GeneralError()))
                    }
                }
            }.resume()
        } catch let error {
            DispatchQueue.main.async {
                completionHandler(.failure(error))
            }
        }
    }

    // MARK: - User
    public func register(request requestObject: RegisterRequestTO, completionHandler: @escaping ((Result<Void, Error>) -> Void)) {
        var request = URLRequest(url: endpoint.register, cachePolicy: .useProtocolCachePolicy)
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        request.setValue("ios-app", forHTTPHeaderField: "User-Agent")
        request.setValue(Environment.appVersion, forHTTPHeaderField: "APP_VERSION")
        request.setValue(Environment.iosVersion, forHTTPHeaderField: "IOS_VERSION")

        do {
            let encoder = JSONEncoder()
            let postData = try encoder.encode(requestObject)

            request.httpMethod = "POST"
            request.httpBody = postData

            log?.request(request)

            session.dataTask(with: request) { [weak self] data, response, error in
                self?.log?.response(response, data: data)
                if let error = error {
                    DispatchQueue.main.async {
                        if (error as NSError).code == NSURLErrorCancelled {
                            completionHandler(.failure(CertificatePinningFailed()))
                            return
                        }
                        completionHandler(.failure(error))
                    }
                } else if let error = HTTPResponseCodeHandler.error(for: (response as? HTTPURLResponse)?.statusCode ?? 0, response: data) {
                    DispatchQueue.main.async {
                        completionHandler(.failure(error))
                    }
                } else if let data = data {
                    do {
                        let responseObject = try JSONDecoder().decode(RegisterResponseTO.self, from: data)
                        DispatchQueue.main.async {
                            self?.securityHelper.username = responseObject.username
                            self?.securityHelper.password = requestObject.password
                            completionHandler(.success(()))
                        }
                    } catch let error {
                        DispatchQueue.main.async {
                            completionHandler(.failure(error))
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        completionHandler(.failure(GeneralError()))
                    }
                }
            }.resume()
        } catch let error {
            DispatchQueue.main.async {
                completionHandler(.failure(error))
            }
        }
    }

    public func login(request requestObject: LoginRequestTO, completionHandler: @escaping (Result<Void, Error>) -> Void) {
        var request = URLRequest(url: endpoint.login, cachePolicy: .useProtocolCachePolicy)
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        request.setValue("ios-app", forHTTPHeaderField: "User-Agent")
        request.setValue(Environment.appVersion, forHTTPHeaderField: "APP_VERSION")
        request.setValue(Environment.iosVersion, forHTTPHeaderField: "IOS_VERSION")

        do {
            let postData = try Networking.encoder.encode(requestObject)

            request.httpMethod = "POST"
            request.httpBody = postData

            log?.request(request)

            session.dataTask(with: request) { [weak self] data, response, error in
                self?.log?.response(response, data: data)
                if let error = error {
                    DispatchQueue.main.async {
                        if (error as NSError).code == NSURLErrorCancelled {
                            completionHandler(.failure(CertificatePinningFailed()))
                            return
                        }
                        completionHandler(.failure(error))
                    }
                } else if let error = HTTPResponseCodeHandler.error(for: (response as? HTTPURLResponse)?.statusCode ?? 0, response: data) {
                    DispatchQueue.main.async {
                        completionHandler(.failure(error))
                    }
                } else if let responseData = data {
                    do {
                        let decoder = JSONDecoder()
                        let responseObject = try decoder.decode(LoginResponseTO.self, from: responseData)
                        DispatchQueue.main.async {
                            self?.securityHelper.bearerToken = responseObject.token
                            self?.securityHelper.username = responseObject.username
                            self?.securityHelper.password = requestObject.password
                            completionHandler(.success(()))
                        }
                    } catch let error {
                        DispatchQueue.main.async {
                            completionHandler(.failure(error))
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        completionHandler(.failure(GeneralError()))
                    }
                }
            }.resume()
        } catch let error {
            DispatchQueue.main.async {
                completionHandler(.failure(error))
            }
        }
    }

    public func logout(request requestObject: LogoutRequestTO, completionHandler: @escaping (Result<Void, Error>) -> Void) {
        guard let bearerToken = securityHelper.bearerToken else {
            DispatchQueue.main.async {
                completionHandler(.failure(MissingBearerToken()))
            }
            return
        }
        var request = URLRequest(url: endpoint.logout, cachePolicy: .useProtocolCachePolicy)
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        request.setValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
        request.setValue("ios-app", forHTTPHeaderField: "User-Agent")
        request.setValue(Environment.appVersion, forHTTPHeaderField: "APP_VERSION")
        request.setValue(Environment.iosVersion, forHTTPHeaderField: "IOS_VERSION")

        do {
            let encoder = JSONEncoder()
            let postData = try encoder.encode(requestObject)

            request.httpMethod = "POST"
            request.httpBody = postData

            log?.request(request)

            session.dataTask(with: request) { [weak self] data, response, error in
                self?.log?.response(response, data: data)
                if let error = error {
                    DispatchQueue.main.async {
                        if (error as NSError).code == NSURLErrorCancelled {
                            completionHandler(.failure(CertificatePinningFailed()))
                            return
                        }
                        completionHandler(.failure(error))
                    }
                } else if let error = HTTPResponseCodeHandler.error(for: (response as? HTTPURLResponse)?.statusCode ?? 0, response: data) {
                    DispatchQueue.main.async {
                        if error is WrongUsernameOrPasswordError {
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: Identifier.logout), object: error)
                        }
                        completionHandler(.failure(error))
                    }
                } else {
                    DispatchQueue.main.async {
                        self?.securityHelper.removeAll()
                        completionHandler(.success(()))
                    }
                }
            }.resume()
        } catch let error {
            DispatchQueue.main.async {
                completionHandler(.failure(error))
            }
        }
    }

    public func passwordReset(requestObject: PasswordResetRequestTO, completionHandler: @escaping (Result<Void, Error>) -> Void) {
        var request = URLRequest(url: endpoint.passwordReset, cachePolicy: .useProtocolCachePolicy)
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        request.setValue("ios-app", forHTTPHeaderField: "User-Agent")
        request.setValue(Environment.appVersion, forHTTPHeaderField: "APP_VERSION")
        request.setValue(Environment.iosVersion, forHTTPHeaderField: "IOS_VERSION")
        request.httpMethod = "POST"
        do {
            let postData = try JSONEncoder().encode(requestObject)
            request.httpBody = postData
        } catch let error {
            DispatchQueue.main.async {
                completionHandler(.failure(error))
            }
        }
        log?.request(request)
        session.dataTask(with: request) { [weak self] data, response, error in
            self?.log?.response(response, data: data)
            if let error = error {
                DispatchQueue.main.async {
                    if (error as NSError).code == NSURLErrorCancelled {
                        completionHandler(.failure(CertificatePinningFailed()))
                        return
                    }
                    completionHandler(.failure(error))
                }
            } else if let error = HTTPResponseCodeHandler.error(for: (response as? HTTPURLResponse)?.statusCode ?? 0, response: data) {
                DispatchQueue.main.async {
                    completionHandler(.failure(error))
                }
            } else {
                DispatchQueue.main.async {
                    completionHandler(.success(()))
                }
            }
        }
        .resume()
    }

    public func changePassword(requestObject: ChangePasswordRequestTO, completionHandler: @escaping (Result<Void, Error>) -> Void) {
        guard let bearerToken = securityHelper.bearerToken else {
            DispatchQueue.main.async {
                completionHandler(.failure(MissingBearerToken()))
            }
            return
        }
        var request = URLRequest(url: endpoint.changePassword, cachePolicy: .useProtocolCachePolicy)
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        request.setValue("ios-app", forHTTPHeaderField: "User-Agent")
        request.setValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
        request.setValue(Environment.appVersion, forHTTPHeaderField: "APP_VERSION")
        request.setValue(Environment.iosVersion, forHTTPHeaderField: "IOS_VERSION")
        request.httpMethod = "POST"
        do {
            let postData = try JSONEncoder().encode(requestObject)
            request.httpBody = postData
        } catch let error {
            DispatchQueue.main.async {
                completionHandler(.failure(error))
            }
        }
        log?.request(request)
        session.dataTask(with: request) { [weak self] data, response, error in
            self?.log?.response(response, data: data)
            if let error = error {
                DispatchQueue.main.async {
                    if (error as NSError).code == NSURLErrorCancelled {
                        completionHandler(.failure(CertificatePinningFailed()))
                        return
                    }
                    completionHandler(.failure(error))
                }
            } else if let error = HTTPResponseCodeHandler.error(for: (response as? HTTPURLResponse)?.statusCode ?? 0, response: data) {
                DispatchQueue.main.async {
                    if error is WrongUsernameOrPasswordError {
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: Identifier.logout), object: error)
                    }
                    completionHandler(.failure(error))
                }
            } else {
                DispatchQueue.main.async {
                    completionHandler(.success(()))
                }
            }
        }
        .resume()
    }

    // MARK: - Sharing
    public func newPartner(request requestObject: NewPartnerRequestTO, completionHandler: @escaping ((Result<Void, Error>) -> Void)) {
        guard let bearerToken = securityHelper.bearerToken else {
            DispatchQueue.main.async {
                completionHandler(.failure(MissingBearerToken()))
            }
            return
        }
        var request = URLRequest(url: endpoint.newPartner, cachePolicy: .useProtocolCachePolicy)
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        request.setValue("ios-app", forHTTPHeaderField: "User-Agent")
        request.setValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
        request.setValue(Environment.appVersion, forHTTPHeaderField: "APP_VERSION")
        request.setValue(Environment.iosVersion, forHTTPHeaderField: "IOS_VERSION")

        do {
            let encoder = JSONEncoder()
            let postData = try encoder.encode(requestObject)

            request.httpMethod = "POST"
            request.httpBody = postData

            log?.request(request)

            session.dataTask(with: request) { [weak self] data, response, error in
                self?.log?.response(response, data: data)
                if let error = error {
                    DispatchQueue.main.async {
                        if (error as NSError).code == NSURLErrorCancelled {
                            completionHandler(.failure(CertificatePinningFailed()))
                            return
                        }
                        completionHandler(.failure(error))
                    }
                } else if let error = HTTPResponseCodeHandler.error(for: (response as? HTTPURLResponse)?.statusCode ?? 0, response: data) {
                    DispatchQueue.main.async {
                        if error is WrongUsernameOrPasswordError {
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: Identifier.logout), object: error)
                        }
                        completionHandler(.failure(error))
                    }
                } else {
                    DispatchQueue.main.async {
                        completionHandler(.success(()))
                    }
                }
            }.resume()
        } catch let error {
            DispatchQueue.main.async {
                completionHandler(.failure(error))
            }
        }
    }

    public func removePartner(request requestObject: RemovePartnerRequestTO, completionHandler: @escaping ((Result<Void, Error>) -> Void)) {
        guard let bearerToken = securityHelper.bearerToken else {
            DispatchQueue.main.async {
                completionHandler(.failure(MissingBearerToken()))
            }
            return
        }
        var request = URLRequest(url: endpoint.removePartner, cachePolicy: .useProtocolCachePolicy)
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        request.setValue("ios-app", forHTTPHeaderField: "User-Agent")
        request.setValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
        request.setValue(Environment.appVersion, forHTTPHeaderField: "APP_VERSION")
        request.setValue(Environment.iosVersion, forHTTPHeaderField: "IOS_VERSION")

        do {
            let encoder = JSONEncoder()
            let postData = try encoder.encode(requestObject)

            request.httpMethod = "POST"
            request.httpBody = postData

            log?.request(request)

            session.dataTask(with: request) { [weak self] data, response, error in
                self?.log?.response(response, data: data)
                if let error = error {
                    DispatchQueue.main.async {
                        if (error as NSError).code == NSURLErrorCancelled {
                            completionHandler(.failure(CertificatePinningFailed()))
                            return
                        }
                        completionHandler(.failure(error))
                    }
                } else if let error = HTTPResponseCodeHandler.error(for: (response as? HTTPURLResponse)?.statusCode ?? 0, response: data) {
                    DispatchQueue.main.async {
                        if error is WrongUsernameOrPasswordError {
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: Identifier.logout), object: error)
                        }
                        completionHandler(.failure(error))
                    }
                } else {
                    DispatchQueue.main.async {
                        completionHandler(.success(()))
                    }
                }
            }.resume()
        } catch let error {
            DispatchQueue.main.async {
                completionHandler(.failure(error))
            }
        }
    }

    // MARK: - Exchange rate
    public func exchangeRates(completionHandler: @escaping (Result<[CurrencyTO], Error>) -> Void) {
        guard let bearerToken = securityHelper.bearerToken else {
            DispatchQueue.main.async {
                completionHandler(.failure(MissingBearerToken()))
            }
            return
        }
        enum Static {
            static var isCalled: Bool?
        }

        if Static.isCalled ?? false {
            log?.requestCalled(function: #function)
            return
        }

        Static.isCalled = true

        var request = URLRequest(url: endpoint.exchangeRates, cachePolicy: .useProtocolCachePolicy)
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        request.setValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
        request.setValue("ios-app", forHTTPHeaderField: "User-Agent")
        request.setValue(Environment.appVersion, forHTTPHeaderField: "APP_VERSION")
        request.setValue(Environment.iosVersion, forHTTPHeaderField: "IOS_VERSION")
        request.httpMethod = "GET"

        log?.request(request)

        session.dataTask(with: request) { [weak self] data, response, error in
            self?.log?.response(response, data: data)
            Static.isCalled = false
            if let error = error {
                DispatchQueue.main.async {
                    if (error as NSError).code == NSURLErrorCancelled {
                        completionHandler(.failure(CertificatePinningFailed()))
                        return
                    }
                    completionHandler(.failure(error))
                }
            } else if let error = HTTPResponseCodeHandler.error(for: (response as? HTTPURLResponse)?.statusCode ?? 0, response: data) {
                DispatchQueue.main.async {
                    if error is WrongUsernameOrPasswordError {
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: Identifier.logout), object: error)
                    }
                    completionHandler(.failure(error))
                }
            } else if let responseData = data {
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let responseObject = try decoder.decode([CurrencyTO].self, from: responseData)
                    DispatchQueue.main.async {
                        completionHandler(.success(responseObject))
                    }
                } catch let error {
                    DispatchQueue.main.async {
                        completionHandler(.failure(error))
                    }
                }
            } else {
                DispatchQueue.main.async {
                    completionHandler(.failure(GeneralError()))
                }
            }
        }.resume()
    }

    // MARK: - Regular Payment
    public func regularPayments(completionHandler: @escaping (Result<[RegularPaymentResponse], Error>) -> Void) {
        guard let bearerToken = securityHelper.bearerToken else {
            DispatchQueue.main.async {
                completionHandler(.failure(MissingBearerToken()))
            }
            return
        }
        var request = URLRequest(url: endpoint.regularPayments, cachePolicy: .useProtocolCachePolicy)
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        request.setValue("ios-app", forHTTPHeaderField: "User-Agent")
        request.setValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
        request.setValue(Environment.appVersion, forHTTPHeaderField: "APP_VERSION")
        request.setValue(Environment.iosVersion, forHTTPHeaderField: "IOS_VERSION")
        request.httpMethod = "GET"
        log?.request(request)
        session.dataTask(with: request) { [weak self] data, response, error in
            self?.log?.response(response, data: data)
            if let error = error {
                DispatchQueue.main.async {
                    if (error as NSError).code == NSURLErrorCancelled {
                        completionHandler(.failure(CertificatePinningFailed()))
                        return
                    }
                    completionHandler(.failure(error))
                }
            } else if let error = HTTPResponseCodeHandler.error(for: (response as? HTTPURLResponse)?.statusCode ?? 0, response: data) {
                DispatchQueue.main.async {
                    if error is WrongUsernameOrPasswordError {
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: Identifier.logout), object: error)
                    }
                    completionHandler(.failure(error))
                }
            } else if let data = data, let response = try? Networking.decoder.decode([RegularPaymentResponse].self, from: data) {
                DispatchQueue.main.async {
                    completionHandler(.success(response))
                }
            } else {
                DispatchQueue.main.async {
                    completionHandler(.failure(GeneralError()))
                }
            }
        }.resume()
    }

    public func newRegularPayment(requestObject: NewRegularPaymentRequest, completionHandler: @escaping (Result<NewRegularPaymentResponse, Error>) -> Void) {
        guard let bearerToken = securityHelper.bearerToken else {
            DispatchQueue.main.async {
                completionHandler(.failure(MissingBearerToken()))
            }
            return
        }
        var request = URLRequest(url: endpoint.newRegularPayment, cachePolicy: .useProtocolCachePolicy)
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        request.setValue("ios-app", forHTTPHeaderField: "User-Agent")
        request.setValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
        request.setValue(Environment.appVersion, forHTTPHeaderField: "APP_VERSION")
        request.setValue(Environment.iosVersion, forHTTPHeaderField: "IOS_VERSION")
        request.httpMethod = "POST"
        do {
            let postData = try Networking.encoder.encode(requestObject)
            request.httpBody = postData
        } catch let error {
            DispatchQueue.main.async {
                completionHandler(.failure(error))
            }
        }
        log?.request(request)
        session.dataTask(with: request) { [weak self] data, response, error in
            self?.log?.response(response, data: data)
            if let error = error {
                DispatchQueue.main.async {
                    if (error as NSError).code == NSURLErrorCancelled {
                        completionHandler(.failure(CertificatePinningFailed()))
                        return
                    }
                    completionHandler(.failure(error))
                }
            } else if let error = HTTPResponseCodeHandler.error(for: (response as? HTTPURLResponse)?.statusCode ?? 0, response: data) {
                DispatchQueue.main.async {
                    if error is WrongUsernameOrPasswordError {
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: Identifier.logout), object: error)
                    }
                    completionHandler(.failure(error))
                }
            } else if let data = data, let response = try? Networking.decoder.decode(NewRegularPaymentResponse.self, from: data) {
                DispatchQueue.main.async {
                    completionHandler(.success(response))
                }
            } else {
                DispatchQueue.main.async {
                    completionHandler(.failure(GeneralError()))
                }
            }
        }.resume()
    }

    public func updateRegularPayment(requestObject: UpdateRegularPaymentRequest, completionHandler: @escaping (Result<UpdateRegularPaymentResponse, Error>) -> Void) {
        guard let bearerToken = securityHelper.bearerToken else {
            DispatchQueue.main.async {
                completionHandler(.failure(MissingBearerToken()))
            }
            return
        }
        var request = URLRequest(url: endpoint.updateRegularPayment, cachePolicy: .useProtocolCachePolicy)
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        request.setValue("ios-app", forHTTPHeaderField: "User-Agent")
        request.setValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
        request.setValue(Environment.appVersion, forHTTPHeaderField: "APP_VERSION")
        request.setValue(Environment.iosVersion, forHTTPHeaderField: "IOS_VERSION")
        request.httpMethod = "PUT"
        do {
            let postData = try Networking.encoder.encode(requestObject)
            request.httpBody = postData
        } catch let error {
            DispatchQueue.main.async {
                completionHandler(.failure(error))
            }
        }
        log?.request(request)
        session.dataTask(with: request) { [weak self] data, response, error in
            self?.log?.response(response, data: data)
            if let error = error {
                DispatchQueue.main.async {
                    if (error as NSError).code == NSURLErrorCancelled {
                        completionHandler(.failure(CertificatePinningFailed()))
                        return
                    }
                    completionHandler(.failure(error))
                }
            } else if let error = HTTPResponseCodeHandler.error(for: (response as? HTTPURLResponse)?.statusCode ?? 0, response: data) {
                DispatchQueue.main.async {
                    if error is WrongUsernameOrPasswordError {
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: Identifier.logout), object: error)
                    }
                    completionHandler(.failure(error))
                }
            } else if let data = data, let response = try? Networking.decoder.decode(UpdateRegularPaymentResponse.self, from: data) {
                DispatchQueue.main.async {
                    completionHandler(.success(response))
                }
            } else {
                DispatchQueue.main.async {
                    completionHandler(.failure(GeneralError()))
                }
            }
        }.resume()
    }

    public func deleteRegularPayment(requestObject: DeleteRegularPaymentRequest, completionHandler: @escaping (Result<RegularPaymentResponse, Error>) -> Void) {
        guard let bearerToken = securityHelper.bearerToken else {
            DispatchQueue.main.async {
                completionHandler(.failure(MissingBearerToken()))
            }
            return
        }
        var request = URLRequest(url: endpoint.deleteRegularPayment, cachePolicy: .useProtocolCachePolicy)
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        request.setValue("ios-app", forHTTPHeaderField: "User-Agent")
        request.setValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
        request.setValue(Environment.appVersion, forHTTPHeaderField: "APP_VERSION")
        request.setValue(Environment.iosVersion, forHTTPHeaderField: "IOS_VERSION")
        request.httpMethod = "DELETE"
        do {
            let postData = try Networking.encoder.encode(requestObject)
            request.httpBody = postData
        } catch let error {
            DispatchQueue.main.async {
                completionHandler(.failure(error))
            }
        }
        log?.request(request)
        session.dataTask(with: request) { [weak self] data, response, error in
            self?.log?.response(response, data: data)
            if let error = error {
                DispatchQueue.main.async {
                    if (error as NSError).code == NSURLErrorCancelled {
                        completionHandler(.failure(CertificatePinningFailed()))
                        return
                    }
                    completionHandler(.failure(error))
                }
            } else if let error = HTTPResponseCodeHandler.error(for: (response as? HTTPURLResponse)?.statusCode ?? 0, response: data) {
                DispatchQueue.main.async {
                    if error is WrongUsernameOrPasswordError {
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: Identifier.logout), object: error)
                    }
                    completionHandler(.failure(error))
                }
            } else if let data = data {
                do {
                    let response = try Networking.decoder.decode(RegularPaymentResponse.self, from: data)
                    DispatchQueue.main.async {
                        completionHandler(.success(response))
                    }
                } catch let error {
                    DispatchQueue.main.async {
                        completionHandler(.failure(error))
                    }
                }
            } else {
                DispatchQueue.main.async {
                    completionHandler(.failure(GeneralError()))
                }
            }
        }.resume()
    }

    // MARK: - Today widget
    public func todayWidgetData(requestObject: TodayWidgetRequestTO, completionHandler: @escaping (Result<TodayWidgetResponseTO, Error>) -> Void) {
        guard let bearerToken = securityHelper.bearerToken else {
            DispatchQueue.main.async {
                completionHandler(.failure(MissingBearerToken()))
            }
            return
        }
        var request = URLRequest(url: endpoint.todayWidget, cachePolicy: .useProtocolCachePolicy)
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        request.setValue("ios-app", forHTTPHeaderField: "User-Agent")
        request.setValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
        request.setValue(Environment.appVersion, forHTTPHeaderField: "APP_VERSION")
        request.setValue(Environment.iosVersion, forHTTPHeaderField: "IOS_VERSION")

        request.httpMethod = "POST"
        request.httpBody = try? JSONEncoder().encode(requestObject)
        log?.request(request)
        session.dataTask(with: request) { [weak self] data, response, error in
            self?.log?.response(response, data: data)
            if let error = error {
                DispatchQueue.main.async {
                    if (error as NSError).code == NSURLErrorCancelled {
                        completionHandler(.failure(CertificatePinningFailed()))
                        return
                    }
                    completionHandler(.failure(error))
                }
            } else if let error = HTTPResponseCodeHandler.error(for: (response as? HTTPURLResponse)?.statusCode ?? 0, response: data) {
                DispatchQueue.main.async {
                    completionHandler(.failure(error))
                }
            } else if let data = data {
                do {
                    let responseObject = try Networking.decoder.decode(TodayWidgetResponseTO.self, from: data)
                    DispatchQueue.main.async {
                        completionHandler(.success(responseObject))
                    }
                } catch let error {
                    DispatchQueue.main.async {
                        completionHandler(.failure(error))
                    }
                }
            } else {
                DispatchQueue.main.async {
                    completionHandler(.failure(GeneralError()))
                }
            }
        }.resume()
    }

    // MARK: - Notification
    public func updateNotificationToken(request requestObject: UpdateNotificationTokenTO, completionHandler: ((Result<Void, Error>) -> Void)? = nil) {
        guard let bearerToken = securityHelper.bearerToken else {
            DispatchQueue.main.async {
                completionHandler?(.failure(MissingBearerToken()))
            }
            return
        }
        var request = URLRequest(url: endpoint.updateNotificationToken, cachePolicy: .useProtocolCachePolicy)
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        request.setValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
        request.setValue("ios-app", forHTTPHeaderField: "User-Agent")
        request.setValue(Environment.appVersion, forHTTPHeaderField: "APP_VERSION")
        request.setValue(Environment.iosVersion, forHTTPHeaderField: "IOS_VERSION")

        do {
            let encoder = JSONEncoder()
            let postData = try encoder.encode(requestObject)

            request.httpMethod = "PUT"
            request.httpBody = postData

            log?.request(request)

            session.dataTask(with: request) { [weak self] data, response, error in
                self?.log?.response(response, data: data)
                if let error = error {
                    DispatchQueue.main.async {
                        if (error as NSError).code == NSURLErrorCancelled {
                            completionHandler?(.failure(MissingBearerToken()))
                            return
                        }
                        completionHandler?(.failure(error))
                    }
                } else if let error = HTTPResponseCodeHandler.error(for: (response as? HTTPURLResponse)?.statusCode ?? 0, response: data) {
                    DispatchQueue.main.async {
                        completionHandler?(.failure(error))
                    }
                } else {
                    DispatchQueue.main.async {
                        completionHandler?(.success(()))
                    }
                }
            }.resume()
        } catch let error {
            DispatchQueue.main.async {
                completionHandler?(.failure(error))
            }
        }
    }

    // MARK: - Receipt
    public func verify(receipt data: Data?, completionHandler: ((Result<VerifyActiveSubscriptionResponseTO, Error>) -> Void)?) {
        guard !verifyReceiptRequestCalled else { return }
        verifyReceiptRequestCalled = true
        guard let bearerToken = securityHelper.bearerToken else {
            DispatchQueue.main.async {
                completionHandler?(.failure(MissingBearerToken()))
            }
            verifyReceiptRequestCalled = false
            return
        }
        let requestObject = VerifyActiveSubscriptionRequestTO(receiptData: data?.base64EncodedString())
        guard let bodyData = try? JSONEncoder().encode(requestObject) else {
            DispatchQueue.main.async {
                completionHandler?(.failure(GeneralError()))
            }
            verifyReceiptRequestCalled = false
            return
        }
        var request = URLRequest(url: endpoint.verifyReceipt)
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        request.setValue("ios-app", forHTTPHeaderField: "User-Agent")
        request.setValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
        request.setValue(Environment.appVersion, forHTTPHeaderField: "APP_VERSION")
        request.setValue(Environment.iosVersion, forHTTPHeaderField: "IOS_VERSION")
        request.httpMethod = "POST"
        request.httpBody = bodyData
        log?.request(request)
        session.dataTask(with: request) { [weak self] data, response, error in
            self?.log?.response(response, data: data)

            if let error = error {
                DispatchQueue.main.async {
                    if (error as NSError).code == NSURLErrorCancelled {
                        completionHandler?(.failure(CertificatePinningFailed()))
                        return
                    }
                    completionHandler?(.failure(error))
                }
            } else if let error = HTTPResponseCodeHandler.error(for: (response as? HTTPURLResponse)?.statusCode ?? 0, response: data) {
                DispatchQueue.main.async {
                    completionHandler?(.failure(error))
                }
            } else if let data = data, let response = try? Networking.decoder.decode(VerifyActiveSubscriptionResponseTO.self, from: data) {
                if let expiresDate = response.expirationDate {
                    self?.log?.expiration(date: expiresDate)
                }
                DispatchQueue.main.async {
                    completionHandler?(.success(response))
                }
            } else {
                DispatchQueue.main.async {
                    completionHandler?(.failure(GeneralError()))
                }
            }

            self?.verifyReceiptRequestCalled = false
        }.resume()
    }
}

extension Networking: URLSessionDelegate {
    #if !os(Linux)
    public func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
            if let serverTrust = challenge.protectionSpace.serverTrust {
                guard let certificatePinningHandler = certificatePinningHandler else {
                    completionHandler(URLSession.AuthChallengeDisposition.useCredential, nil)
                    return
                }
                certificatePinningHandler(serverTrust, completionHandler)
            }
        }
    }
    #endif
}
