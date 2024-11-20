//
//  OpenExchangeRatesProvider.swift
//  CurrencyExchange
//
//  Created by KHANH VAN on 17/11/24.
//

import Foundation

// OXR Docs: https://docs.openexchangerates.org/reference/api-introduction

/// Open Exchange Rate API Provider
class OXRProvider : CurrencyExchangeProvider {
    
    // App ID used to make API calls. This should be kept private so please don't steal lol
    let API_APP_ID: String = "56c4e021317d4241aaf79aa504986f67"

    func getRates() async throws -> [String : Double] {
        let url = "https://openexchangerates.org/api/latest.json?app_id=" + API_APP_ID
        let data = try await sendRequest(url: url)
        let decoded = try JSONDecoder().decode(OXRRatesResponse.self, from: data)
        
        return decoded.rates
    }
    
    func getCurrencies() async throws -> [String : String] {
        let url = "https://openexchangerates.org/api/currencies.json?app_id=" + API_APP_ID
        let data = try await sendRequest(url: url)
        let decoded = try JSONDecoder().decode([String:String].self, from: data)
        
        return decoded
    }
    
    /// Sends an HTTP request to the server
    ///
    /// Will catch HTTP errors in the response and throw them as ExchangeAPIError
    private func sendRequest(url: String) async throws -> Data {
        guard let url = URL(string: url) else {
            throw ExchangeAPIError.invalidUrl(url: url)
        }
                
        let request = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: request)
                
        guard let response = response as? HTTPURLResponse else {
            throw ExchangeAPIError.generalError
        }
        
        // This should catch all the errors
        let errorCatcher = OXRErrorCatcher()
        try errorCatcher.catchHTTPError(statusCode: response.statusCode)
        
        // Return data if response is ok
        return data
    }
    

}
