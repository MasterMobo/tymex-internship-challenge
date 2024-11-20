//
//  MockCurrencyExchangeProvider.swift
//  CurrencyExchange
//
//  Created by KHANH VAN on 20/11/24.
//

import Foundation

/// A mock CurrencyExchangeProvider
///
/// Provides mock data directly without making any request
class MockCurrencyExchangeProvider: CurrencyExchangeProvider {
    private var rates: [String : Double]
    private var currencies: [String : String]
    
    init(rates: [String : Double], currencies: [String : String]) {
        self.rates = rates
        self.currencies = currencies
    }
    
    /// Use default rates and currencies
    convenience init() {
        self.init(
            rates: [
                "USD" : 1.0,
                "VND" : 0.00002,
                "JPY" : 0.001
            ],
            currencies: [
                "USD" : "United States Dollar",
                "VND" : "Vietnamese Dong",
                "JPY" : "Japanese Yen"
            ])
    }
    
    func getRates() async throws -> [String : Double] {
        return rates
    }
    
    func getCurrencies() async throws -> [String : String] {
        return currencies
    }
    
}
