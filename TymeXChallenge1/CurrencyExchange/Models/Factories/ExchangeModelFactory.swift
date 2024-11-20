//
//  ExchangeModelFactory.swift
//  CurrencyExchange
//
//  Created by KHANH VAN on 17/11/24.
//

import Foundation

class ExchangeModelFactory {
    private var provider: CurrencyExchangeProvider

    init() {
        // Use OXR as default provider
        provider = OXRProvider()
    }
    
    init(provider: CurrencyExchangeProvider) {
        self.provider = provider
    }
    
    func create() async throws -> ExchangeModel {
        async let rates = provider.getRates()
        async let currencies = provider.getCurrencies()
        
        return try await ExchangeModel(
            timestamp: Date(),
            rates: rates,
            currencies: currencies
        )
    }
}
