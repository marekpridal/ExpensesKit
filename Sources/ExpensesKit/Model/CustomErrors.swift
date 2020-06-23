//
//  CustomErrors.swift
//  MyExpenses
//
//  Created by Marek Přidal on 15.07.18.
//  Copyright © 2018 Marek Pridal. All rights reserved.
//

import Foundation

public struct EmptyUsernameOrPasswordError: LocalizedError {
    public var errorDescription: String? {
        return NSLocalizedString("Empty username or password", comment: "")
    }

    public init() { }
}

public struct WrongUsernameOrPasswordError: LocalizedError {
    public var errorDescription: String? {
        return NSLocalizedString("Wrong username or password", comment: "")
    }

    public init() { }
}

public struct GeneralError: LocalizedError {
    public var errorDescription: String? {
        return NSLocalizedString("Something went wrong", comment: "")
    }

    public init() { }
}

public struct CertificatePinningFailed: LocalizedError {
    public var errorDescription: String? {
        return NSLocalizedString("CERTIFICATE_PINNING_FAILED", comment: "")
    }

    public init() { }
}

public struct MissingBearerToken: LocalizedError {
    public var errorDescription: String? {
        return NSLocalizedString("NETWORKING_MISSING_BERARE_TOKEN", comment: "")
    }

    public init() { }
}

public struct BadRequestError: LocalizedError {
    public var errorDescription: String? {
        return NSLocalizedString("BAD_REQUEST_ERROR", comment: "")
    }

    public init() { }
}

public struct RequestTimeoutError: LocalizedError {
    public var errorDescription: String? {
        return NSLocalizedString("REQUEST_TIMEOUT_ERROR", comment: "")
    }

    public init() { }
}

public struct PaymentRequiredError: LocalizedError {
    public var errorDescription: String? {
        return NSLocalizedString("PAYMENT_REQUIRED_ERROR", comment: "")
    }

    public init() { }
}

public struct ForbiddenError: LocalizedError {
    public var errorDescription: String? {
        return NSLocalizedString("FORBIDDEN_ERROR", comment: "")
    }

    public init() { }
}

public struct ConflictError: LocalizedError {
    public var errorDescription: String? {
        return NSLocalizedString("CONFLICT_ERROR", comment: "")
    }

    public init() { }
}

public struct RedirectionError: LocalizedError {
    public var errorDescription: String? {
        return NSLocalizedString("REDIRECTION_ERROR", comment: "")
    }

    public init() { }
}

public struct GoneError: LocalizedError {
    public var errorDescription: String? {
        return NSLocalizedString("GONE_ERROR", comment: "")
    }

    public init() { }
}

public struct UpgradeRequiredError: LocalizedError {
    public var errorDescription: String? {
        return NSLocalizedString("UPGRADE_REQUIRED_ERROR", comment: "")
    }

    public init() { }
}

public struct ServerError: LocalizedError {
    public var errorDescription: String? {
        return NSLocalizedString("SERVER_ERROR", comment: "")
    }

    public init() { }
}

public struct NetworkAuthenticationRequiredError: LocalizedError {
    public var errorDescription: String? {
        return NSLocalizedString("NETWORK_AUTHENTICATION_REQUIRED_ERROR", comment: "")
    }

    public init() { }
}

public struct RegistrationErrorUsernameTooLong: LocalizedError {
    public var errorDescription: String? {
        return NSLocalizedString("REGISTRATION_ERROR_USERNAME_TOO_LONG", comment: "")
    }

    public init() { }
}

public struct RegistrationErrorUsernameTooShort: LocalizedError {
    public var errorDescription: String? {
        return NSLocalizedString("REGISTRATION_ERROR_USERNAME_TOO_SHORT", comment: "")
    }

    public init() { }
}

public struct RegistrationErrorMissingUsername: LocalizedError {
    public var errorDescription: String? {
        return NSLocalizedString("REGISTRATION_ERROR_MISSING_USERNAME", comment: "")
    }

    public init() { }
}

public struct RegistrationErrorEmailTooLong: LocalizedError {
    public var errorDescription: String? {
        return NSLocalizedString("REGISTRATION_ERROR_EMAIL_TOO_LONG", comment: "")
    }

    public init() { }
}

public struct RegistrationErrorMissingEmail: LocalizedError {
    public var errorDescription: String? {
        return NSLocalizedString("REGISTRATION_ERROR_MISSING_EMAIL", comment: "")
    }

    public init() { }
}

public struct RegistrationErrorMissingPassword: LocalizedError {
    public var errorDescription: String? {
        return NSLocalizedString("REGISTRATION_ERROR_MISSING_PASSWORD", comment: "")
    }

    public init() { }
}

public struct RegistrationErrorDuplicateUsername: LocalizedError {
    public var errorDescription: String? {
        return NSLocalizedString("REGISTRATION_ERROR_DUPLICATE_USERNAME", comment: "")
    }

    public init() { }
}

public struct RegistrationErrorUnsupportedCurrency: LocalizedError {
    public var errorDescription: String? {
        return NSLocalizedString("REGISTRATION_ERROR_UNSUPPORTED_CURRENCY", comment: "")
    }

    public init() { }
}

public struct RegistrationErrorUnsupportedAvatarImage: LocalizedError {
    public var errorDescription: String? {
        return NSLocalizedString("REGISTRATION_ERROR_UNSUPPORTED_AVATAR_IMAGE", comment: "")
    }

    public init() { }
}

public struct NotFoundError: LocalizedError {
    public var errorDescription: String? {
        return NSLocalizedString("BAD_REQUEST_ERROR", comment: "")
    }

    public init() { }
}

public struct ServerInMaintenance: LocalizedError {
    public var errorDescription: String? {
        return NSLocalizedString("SERVER_IN_MAINTENANCE_ERROR", comment: "")
    }

    public init() { }
}

public struct CustomError: LocalizedError, Error {
    //swiftlint:disable nslocalizedstring_key
    public var errorDescription: String? {
        return NSLocalizedString("CUSTOM_ERROR_\(serverCustomError.reason)", comment: "")
    }
    //swiftlint:enable nslocalizedstring_key

    private let serverCustomError: ErrorResponseTO

    public init(serverCustomError: ErrorResponseTO) {
        self.serverCustomError = serverCustomError
    }
}
