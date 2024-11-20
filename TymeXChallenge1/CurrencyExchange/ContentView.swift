//
//  ContentView.swift
//  CurrencyExchange
//
//  Created by KHANH VAN on 16/11/24.
//

import SwiftUI

struct ContentView: View {
    @State var themeManager: ThemeManager = .init()
    
    var body: some View {
        ExchangeView()
            .preferredColorScheme(themeManager.theme)
            .environment(themeManager)
    }
}

#Preview {
    ContentView()
}
