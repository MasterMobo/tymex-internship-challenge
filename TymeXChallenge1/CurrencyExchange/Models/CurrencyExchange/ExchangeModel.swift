//
//  ExchangeModel.swift
//  CurrencyExchange
//
//  Created by KHANH VAN on 16/11/24.
//

import Foundation

/// Model of a currency exchange
struct ExchangeModel {
    // When these rates where retrieved
    var timestamp: Date
    
    // Map from currency code to exchange rate
    var rates: [String: Double] = [:]
    
    // Map from currency code to name
    var currencies: [String: String] = [:]
    
    init(timestamp: Date, rates: [String : Double], currencies: [String : String]) {
        self.timestamp = timestamp
        self.rates = rates
        self.currencies = currencies
    }
    
    /// Converts a specific amount from one currency to another
    func convert(fromAmount: Double, fromCurrency: String, toCurrency: String) -> Double {
        return rates[toCurrency]! / rates[fromCurrency]! * fromAmount
    }
}
