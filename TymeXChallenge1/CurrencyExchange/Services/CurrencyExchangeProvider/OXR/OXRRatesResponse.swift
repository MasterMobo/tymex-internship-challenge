//
//  CurrencyAPIResponse.swift
//  CurrencyExchange
//
//  Created by KHANH VAN on 16/11/24.
//

import Foundation

// reference: https://docs.openexchangerates.org/reference/latest-json

/// Response format of Open Exchange Rates rates API
struct OXRRatesResponse: Codable {
    let disclaimer: String
    let license: String
    let timestamp: Int
    let base: String
    let rates: [String: Double]
}
