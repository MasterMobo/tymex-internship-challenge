//
//  ExchangeResultViewModel.swift
//  CurrencyExchange
//
//  Created by KHANH VAN on 18/11/24.
//

import SwiftUI
import UniformTypeIdentifiers

@Observable
class ExchangeResultViewModel {
    // Master view model
    private var exchangeVM: ExchangeViewModel
    
    // MARK: - UI Bound
    // Top line of result
    var resultTop: String {
        return "\(formatDouble(exchangeVM.sourceAmount)) \(getCurrencyName(code: exchangeVM.sourceCurrency)) equals"
    }
    
    // Bottom line of result
    var resultBottom: String {
        return "\(formatDouble(exchangeVM.targetAmount)) \(getCurrencyName(code: exchangeVM.targetCurrency))"
    }
    
    init(exchangeVM: ExchangeViewModel) {
        self.exchangeVM = exchangeVM
    }
    
    /// Copies formated target amount string to the clip board
    func onCopyClick() {
        UIPasteboard.general.setValue(exchangeVM.targetAmountStr,
            forPasteboardType: UTType.plainText.identifier)
    }
    
    private func formatDouble(_ d: Double) -> String {
        return String(d.formatted(.number))
    }
    
    private func getCurrencyName(code: String) -> String{
        return exchangeVM.exchangeModel?.currencies[code] ?? code
    }
}
