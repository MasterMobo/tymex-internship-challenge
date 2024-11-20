//
//  OXRErrorCatcher.swift
//  CurrencyExchange
//
//  Created by KHANH VAN on 18/11/24.
//

import Foundation

class OXRErrorCatcher {
    /// Catch HTTP errors from status code and throw appropriate errors
    ///
    /// Passing through this method without any error means status code is OK
    func catchHTTPError(statusCode: Int) throws {
        // reference for error codes: https://docs.openexchangerates.org/reference/errors

        guard statusCode != 429 else {
            throw ExchangeAPIError.usageLimitHit
        }
        
        guard statusCode != 401 else {
            throw ExchangeAPIError.invalidAppId
        }
        
        // Other error codes will be thrown as general error
        guard isStatusOk(statusCode) else {
            throw ExchangeAPIError.generalError
        }
    }
    
    /// Checks if an HTTP status code is successful
    private func isStatusOk(_ statusCode: Int) -> Bool {
        return statusCode >= 200 && statusCode <= 299
    }
}
