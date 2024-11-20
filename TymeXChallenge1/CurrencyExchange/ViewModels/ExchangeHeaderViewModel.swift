//
//  ExchangeHeaderViewModel.swift
//  CurrencyExchange
//
//  Created by KHANH VAN on 18/11/24.
//

import SwiftUI

@Observable
class ExchangeHeaderViewModel {
    // Master view model
    var exchangeVM: ExchangeViewModel

    // MARK: - UI Bound
    
    // Map from currency code to name
    var rates: [String : Double] {
        return exchangeVM.exchangeModel?.rates ?? [:]
    }
    
    // Contains randomly selected currency codes from rates
    var randomCurrencies: [String] = []
    
    init(exchangeVM: ExchangeViewModel) {
        self.exchangeVM = exchangeVM
    }
    
    func refresh() {
        withAnimation {
            updateRandomCurrencies()
        }
    }
    
    /// Randomly selects currency codes from rates and put it randomCurrencies
    func updateRandomCurrencies() {
        guard !rates.isEmpty else {
            return
        }
        
        var result: [String] = []
        var selectionPool = rates
        
        // Remove items that are already displayed
        for element in randomCurrencies {
            selectionPool.removeValue(forKey: element)
        }
        
        for _ in 0..<3 {
            guard let randomCurrency = selectionPool.randomElement() else {
                break
            }
            result.append(randomCurrency.key)
            
            selectionPool.removeValue(forKey: randomCurrency.key)
        }
        
        randomCurrencies = result
    }
}
