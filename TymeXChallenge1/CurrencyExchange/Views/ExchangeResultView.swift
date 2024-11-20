//
//  ExchangeResultView.swift
//  CurrencyExchange
//
//  Created by KHANH VAN on 18/11/24.
//

import SwiftUI

struct ExchangeResultView: View {
    @State var resultVM: ExchangeResultViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text(resultVM.resultTop)
                .font(.system(size: 20, weight: .medium))

            
            Text(resultVM.resultBottom)
                .font(.system(size: 36, weight: .bold))
                

            Button {
                resultVM.onCopyClick()
            } label: {
                HStack {
                    Image(systemName: "doc.on.clipboard.fill")
                    
                    Text("Copy to Clipboard")
                        .fontWeight(.medium)
                }
                .foregroundStyle(Color("AccentColor"))
                .padding(5)
                .background {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color("AccentColor").opacity(0.1))
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var exchangeVM: ExchangeViewModel = .init()
    ExchangeResultView(resultVM: exchangeVM.resultVM!)
}
