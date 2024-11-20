//
//  ExchangeAPIError.swift
//  CurrencyExchange
//
//  Created by KHANH VAN on 17/11/24.
//

import Foundation

enum ExchangeAPIError: Error {
    case generalError
    case invalidUrl(url: String)
    case invalidAppId
    case usageLimitHit
}
