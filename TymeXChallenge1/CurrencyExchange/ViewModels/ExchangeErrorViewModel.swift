//
//  ExchangeErrorViewModel.swift
//  CurrencyExchange
//
//  Created by KHANH VAN on 18/11/24.
//

import SwiftUI

@Observable
class ExchangeErrorViewModel {
    // Master view model
    private var exchangeVM: ExchangeViewModel

    // MARK: - UI Bound
    var message: String = ""
    var image: Image? = nil
    
    // The error being handled. Needs to be set by exchangeVM before it can handle the error
    private var error: (any Error)? = nil
    
    init(exchangeVM: ExchangeViewModel) {
        self.exchangeVM = exchangeVM
    }
    
    /// Initialize with error directly
    ///
    /// - warning: Use for debugging/previews only.
    init(error: any Error) {
        self.error = error
        exchangeVM = .init()
        handleError()
    }
    
    /// Sets the error and handles it
    func setError(error: any Error) {
        self.error = error
        handleError()
    }
    
    func onRetry() {
        Task {
            await exchangeVM.onStart()
        }
    }
    
    /// Renders the error
    private func handleError() {
        print(error!.localizedDescription)
        
        // Create the error model
        let factory = ExchangeErrorModelFactory()
        let model = factory.create(error: error!)
        
        // Update UI
        message = model.message
        image = model.image
    }
    
    private func reset() {
        error = nil
        message = ""
    }
}
