//
//  CurrencyExchangeView.swift
//  CurrencyExchange
//
//  Created by KHANH VAN on 17/11/24.
//

import SwiftUI

struct ExchangeView: View {
    
    @State private var exchangeVM: ExchangeViewModel = .init()
    
    var body: some View {
        ZStack(alignment: .top) {
            if exchangeVM.isError {
                ExchangeErrorView(errorVM: exchangeVM.errorVM!)
            } else if exchangeVM.isLoading {
                ExchangeLoadingView()
            } else {
                ExchangeContentView(exchangeVM: $exchangeVM)
            }
        }
        .task {
            await exchangeVM.onStart()
        }
        // MARK: - Handler functions
        .onChange(of: exchangeVM.sourceAmountStr, { oldValue, newValue in
            exchangeVM.handleAmountChange(newValue, isSource: true)
        })
        .onChange(of: exchangeVM.targetAmountStr, { oldValue, newValue in
            exchangeVM.handleAmountChange(newValue, isSource: false)
        })
        .onChange(of: exchangeVM.sourceCurrency, { oldValue, newValue in
            exchangeVM.handleSourceCurrencyChange(oldValue, newValue)
        })
        .onChange(of: exchangeVM.targetCurrency, { oldValue, newValue in
            exchangeVM.handleTargetCurrencyChange(oldValue, newValue)
        })
    }
}

#Preview {
    @Previewable @State var themeManager: ThemeManager = .init()

    ExchangeView()
        .preferredColorScheme(themeManager.theme)
        .environment(themeManager)

}
