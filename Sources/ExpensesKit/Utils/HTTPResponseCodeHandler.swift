//
//  HTTPResponseCodeHandler.swift
//  MyExpenses
//
//  Created by Marek Pridal on 17.02.19.
//  Copyright © 2019 Marek Pridal. All rights reserved.
//

import Foundation

//swiftlint:disable function_body_length
enum HTTPResponseCodeHandler {
    // swiftlint:disable cyclomatic_complexity
    static func error(for responseCode: Int, response: Data?) -> Error? {
        switch responseCode {
        case 100...199: // Informational response
            return GeneralError()
        case 200...299: // OK
            return nil
        case 300...399: // Redirection
            return RedirectionError()
        case 400...499: // Client error
            switch responseCode {
            case 400:
                return BadRequestError()

            case 401:
                return WrongUsernameOrPasswordError()

            case 402:
                return PaymentRequiredError()

            case 403:
                return BadRequestError()

            case 404:
                return NotFoundError()

            case 405...407:
                return BadRequestError()

            case 408:
                return RequestTimeoutError()

            case 409:
                return ConflictError()

            case 410...425:
                return BadRequestError()

            case 426:
                return UpgradeRequiredError()

            case 430:
                guard let response = response, let customError = try? JSONDecoder().decode(ErrorResponseTO.self, from: response) else {
                    return BadRequestError()
                }

                return CustomError(serverCustomError: customError)

            default:
                return BadRequestError()
            }
        case 500...599: // Server error
            switch responseCode {
            case 503:
                return ServerInMaintenance()

            case 511:
                return NetworkAuthenticationRequiredError()

            default:
                return ServerError()
            }

        default:
            return GeneralError()
        }
    }
    // swiftlint:enable cyclomatic_complexity
}

//swiftlint:enable function_body_length
