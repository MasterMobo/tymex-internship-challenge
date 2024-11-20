//
//  ThemeManager.swift
//  CurrencyExchange
//
//  Created by KHANH VAN on 20/11/24.
//

import SwiftUI

/// Manages global theme of application
@Observable
class ThemeManager {
    var theme: ColorScheme = .light
    
    /// Toggle the theme from light to dark and vice versa
    public func toggle() {
        theme = (theme == .dark ? .light : .dark)
    }
}
