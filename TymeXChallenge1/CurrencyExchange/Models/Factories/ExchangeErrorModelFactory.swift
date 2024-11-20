//
//  ExchangeErrorModelFactory.swift
//  CurrencyExchange
//
//  Created by KHANH VAN on 18/11/24.
//

import Foundation

class ExchangeErrorModelFactory {
    /// Create an ExchangeErrorModel from an Error
    func create(error: any Error) -> ExchangeErrorModel {
        if let error = error as? ExchangeAPIError {
            return fromExchangeAPIError(error: error)
        }
        
        if let error = error as? URLError {
            return fromURLError(error: error)
        }
        
        // Return default error
        return ExchangeDefaultErrorModel()
    }
    
    private func fromExchangeAPIError(error: ExchangeAPIError) -> ExchangeErrorModel {
        return ExchangeDefaultErrorModel()
    }
    
    private func fromURLError(error: URLError) -> ExchangeErrorModel {
        switch error.code {
            case .notConnectedToInternet:
                return ExchangeNoInternetError()
            
            case .timedOut:
                return ExchangeTimeOutError()
            
            default:
                return ExchangeDefaultErrorModel()
        }
    }
}
