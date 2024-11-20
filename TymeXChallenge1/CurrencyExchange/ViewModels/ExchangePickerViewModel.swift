//
//  ExchangePickerViewModel.swift
//  CurrencyExchange
//
//  Created by KHANH VAN on 18/11/24.
//

import Foundation

@Observable
class ExchangePickerViewModel {
    // Master view model
    private var exchangeVM: ExchangeViewModel

    // MARK: - UI Bound
    var searchText = ""
    var selectionSheetPresented = false
    
    // Map from currency code to name
    var currencies: [String : String] {
        return exchangeVM.exchangeModel?.currencies ?? [:]
    }
    
    // Currencies filtered by search text
    var filteredCurrencies: [String : String] {
        if searchText.isEmpty {
            return currencies
        }
        
        // Filter based on both currency code and name
        return currencies.filter { $0.value.localizedCaseInsensitiveContains(searchText) || $0.key.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    init(exchangeVM: ExchangeViewModel) {
        self.exchangeVM = exchangeVM
    }
    
    func toggleSheet() {
        selectionSheetPresented.toggle()
    }
    
}
