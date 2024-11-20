//
//  ExchangeProvider.swift
//  CurrencyExchange
//
//  Created by KHANH VAN on 17/11/24.
//

import Foundation

/// Provides currency exchange data
///
/// The data can come from any source, but must adhere to methods in this protocol.
/// This protocol does not provide error handling when error occurs when getting data.
protocol CurrencyExchangeProvider {
    /// Get the exchange rates
    ///
    /// - returns: A map from the currency code (commonly the 3-letter ISO currency codes) to the exchange rate. All exchange rates have a common base.
    func getRates() async throws -> [String : Double]
    
    /// Get user-friendly currency name from currency code
    ///
    /// - returns: A map from the currency code to the currency name
    func getCurrencies() async throws -> [String : String]
}
