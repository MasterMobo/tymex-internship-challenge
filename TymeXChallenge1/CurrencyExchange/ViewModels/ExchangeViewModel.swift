//
//  ExchangeViewModel.swift
//  CurrencyExchange
//
//  Created by KHANH VAN on 16/11/24.
//

import SwiftUI

@Observable
class ExchangeViewModel {
    // MARK: - MVVM

    // Model
    var exchangeModel: ExchangeModel?
    // Factory used to create the model
    private let exchangeModelFactory: ExchangeModelFactory
    
    // View models
    // These handle the logic of sub-views
    var errorVM: ExchangeErrorViewModel? = nil
    var sourcePickerVM: ExchangePickerViewModel? = nil
    var targetPickerVM: ExchangePickerViewModel? = nil
    var headerVM: ExchangeHeaderViewModel? = nil
    var resultVM: ExchangeResultViewModel? = nil
    
    // MARK: - UI Bound

    // Control flags
    var isLoading: Bool = false
    var isError: Bool = false
    var isSourceAmountInvalid: Bool = false
    var isTargetAmountInvalid: Bool = false
    
    var timestamp: Date? {
        return exchangeModel?.timestamp
    }
    
    // Currency selections
    var sourceCurrency: String = "USD"
    var targetCurrency: String = "VND"
    
    // String representation of amount inputs
    // When an input is changed, it updates the other one
    var sourceAmountStr: String = "" {
        didSet {
            updateTargetAmount()
        }
    }
    var targetAmountStr: String = "" {
        didSet {
            updateSourceAmount()
        }
    }
    
    // Number representation of amount inputs
    // Used for faster and more accurate comparisons
    var sourceAmount: Double = 0
    var targetAmount: Double = 0
            
    // MARK: - Public Methods
    
    /// Default constructor
    ///
    /// Uses default ExchangeModelFactory as the factory.
    /// Initializes other view models.
    convenience init() {
        self.init(exchangeModelFactory: ExchangeModelFactory())
    }

    /// Initialize with factory used to create ExchangeModel
    ///
    /// Use this to inject different factories
    init(exchangeModelFactory: ExchangeModelFactory) {
        self.exchangeModelFactory = exchangeModelFactory
        errorVM = .init(exchangeVM: self)
        sourcePickerVM = .init(exchangeVM: self)
        targetPickerVM = .init(exchangeVM: self)
        headerVM = .init(exchangeVM: self)
        resultVM = .init(exchangeVM: self)
    }
    
    /// Called when view first appears
    func onStart() async {
        isLoading = true
        isError = false
        
        do {
            // Try and get model data
            exchangeModel = try await exchangeModelFactory.create()
            
            isLoading = false
        } catch {
            // If error occurs, hand it over to errorVM
            isError = true
            errorVM?.setError(error: error)
        }
    }
    
    /// Called when user refreshes view
    ///
    /// Unlike onStart(), this does not trigger the ExchangeLoadingView
    func onRefresh() async {
        isError = false
        
        do {
            // Try and get model data
            exchangeModel = try await exchangeModelFactory.create()
            
            headerVM?.refresh()
        } catch {
            // If error occurs, hand it over to errorVM
            isError = true
            errorVM?.setError(error: error)
        }
    }
    
    /// Check for input errors
    func handleAmountChange(_ newValue: String, isSource: Bool) {
        // Reset all amounts if any is empty
        guard newValue != "" else {
            resetAllAmounts()
            return
        }
        
        // Check for invalid number inputs
        guard Double(newValue) != nil else {
            showInvalidAmountError(isSource)
            return
        }
        
        // If we reach this, no error occured, so reset errors
        resetAmountError()
    }
        
    /// Activate error indicator for an amount input
    private func showInvalidAmountError(_ isSource: Bool) {
        withAnimation {
            if isSource {
                isSourceAmountInvalid = true
            } else {
                isTargetAmountInvalid = true
            }
        }
    }
    
    /// Swap the target and source currencies
    func swapCurrencies() {
        let temp = targetCurrency
        targetCurrency = sourceCurrency
        sourceCurrency = temp
    }
    
    /// Updates the target amount
    func handleSourceCurrencyChange(_ oldValue: String, _ newValue: String) {
        // If selecting the same currency, swap them
        if (newValue == targetCurrency) {
            targetCurrency = oldValue
        }
        
        updateTargetAmount()
    }
    
    /// Updates the source amount
    func handleTargetCurrencyChange(_ oldValue: String, _ newValue: String) {
        // If selecting the same currency, swap them
        if (newValue == sourceCurrency) {
            sourceCurrency = oldValue
        }
        
        updateSourceAmount()
    }
    
    /// Reset states of all amount inputs
    func resetAllAmounts() {
        sourceAmountStr = ""
        targetAmountStr = ""
        sourceAmount = 0
        targetAmount = 0
        resetAmountError()
    }
    
    // MARK: - Private methods
    
    /// Reset all amount errors to false
    private func resetAmountError() {
        isSourceAmountInvalid = false
        isTargetAmountInvalid = false
    }
    
    /// Updates the target amount based on the source
    private func updateTargetAmount() {
        guard let value = Double(sourceAmountStr) else {
            return
        }
        
        sourceAmount = value

        let newTargetAmount = exchangeModel!.convert(fromAmount: sourceAmount,
                                             fromCurrency: sourceCurrency,
                                             toCurrency: targetCurrency)
        
        // If new value is the same, we don't need to update
        // This prevents infintite update loop
        if DoubleUtils.equals(targetAmount, newTargetAmount) { return }
        
        targetAmount = newTargetAmount
        targetAmountStr = String(newTargetAmount)
    }
    
    /// Updates the source amount based on the target
    private func updateSourceAmount() {
        guard let value = Double(targetAmountStr) else {
            return
        }
        
        targetAmount = value
        
        let newSourceAmount = exchangeModel!.convert(fromAmount: targetAmount,
                                             fromCurrency: targetCurrency,
                                             toCurrency: sourceCurrency)
        
        // If new value is the same, we don't need to update
        // This prevents infintite update loop
        if DoubleUtils.equals(newSourceAmount, sourceAmount) { return }
        
        sourceAmount = newSourceAmount
        sourceAmountStr = String(newSourceAmount)
    }
}
