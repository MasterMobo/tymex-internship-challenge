//
//  ExchangeErrorModel.swift
//  CurrencyExchange
//
//  Created by KHANH VAN on 18/11/24.
//

import SwiftUI

class ExchangeErrorModel {
    var message: String
    var image: Image
    
    init(message: String, image: Image) {
        self.message = message
        self.image = image
    }
}


class ExchangeDefaultErrorModel: ExchangeErrorModel {
    init() {
        super.init(
            message: "Something went wrong, please try again later.",
            image: Image(systemName: "exclamationmark.triangle")
        )
    }
}


class ExchangeNoInternetError: ExchangeErrorModel {
    init() {
        super.init(
            message: "No Internet connection. Please check your connection and try again.",
            image: Image(systemName: "wifi.slash")
        )
    }
}

class ExchangeTimeOutError: ExchangeErrorModel {
    init() {
        super.init(
            message: "The server took too long to response, please try again later.",
            image: Image(systemName: "clock.badge.exclamationmark")
        )
    }
}
