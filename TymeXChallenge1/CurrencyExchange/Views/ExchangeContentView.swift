//
//  ExchangeContentView.swift
//  CurrencyExchange
//
//  Created by KHANH VAN on 19/11/24.
//

import SwiftUI

struct ExchangeContentView: View {
    @Binding var exchangeVM: ExchangeViewModel

    var body: some View {
        ZStack {
            // Background
            Color("background-primary")
                .ignoresSafeArea(edges: .all)
            
            // Foreground
            ScrollView {
                VStack(spacing: 20) {
                    HStack {
                        Spacer()
                        
                        ThemeToggleButton()
                    }
                    
                    ExchangeHeaderView(headerVM: exchangeVM.headerVM!)
                    
                    ExchangeConvertView(exchangeVM: $exchangeVM)
                }
                .padding(.horizontal)
            }
            .refreshable {
                await exchangeVM.onRefresh()
            }
            
        }

    }
}

#Preview {
    @Previewable @State var exchangeVM: ExchangeViewModel = .init()
    @Previewable @State var themeManager: ThemeManager = .init()


    ExchangeContentView(exchangeVM: $exchangeVM)
        .preferredColorScheme(themeManager.theme)
        .environment(themeManager)
        .task {
            await exchangeVM.onStart()
        }
}
