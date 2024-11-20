//
//  CurrencyExchangeLoadingView.swift
//  CurrencyExchange
//
//  Created by KHANH VAN on 18/11/24.
//

import SwiftUI

struct ExchangeLoadingView: View {
    var body: some View {
        ZStack {
            Color("background-primary")
                .ignoresSafeArea(.all)
            
            VStack(spacing: 25) {
                ProgressView()
                    .progressViewStyle(.circular)
                    .frame(width: 40, height: 40)
                    .scaleEffect(2)
                
                Text("Getting the latest data")
                    .font(.system(size: 24, weight: .medium))
            }
            .padding(20)
            .background {
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color("foreground-primary"))
            }
            .padding()
        }
    }
}

#Preview {
    ExchangeLoadingView()
}
