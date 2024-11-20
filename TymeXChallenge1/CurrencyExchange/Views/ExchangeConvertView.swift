//
//  ExchangeConvertView.swift
//  CurrencyExchange
//
//  Created by KHANH VAN on 19/11/24.
//

import SwiftUI

struct ExchangeConvertView: View {
    
    @Binding var exchangeVM: ExchangeViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            // Label & Clear button
            HStack {
                Label {
                    Text("Convert")
                } icon: {
                    Image(systemName: "dollarsign.circle")
                }
                .foregroundStyle(Color("AccentColor"))
                .font(.system(size: 26, weight: .bold))

                Spacer()
                
                Button {
                    exchangeVM.resetAllAmounts()
                } label: {
                    Text("Clear")
                }
            }
            
            // Result view
            if !exchangeVM.sourceAmountStr.isEmpty
                && !exchangeVM.targetAmountStr.isEmpty {
                ExchangeResultView(resultVM: exchangeVM.resultVM!)
                    .padding(.vertical, 15)
            }
            
            // Source Input
            HStack {
                TextField(
                    "Enter Amount",
                    text: $exchangeVM.sourceAmountStr
                )
                .textFieldStyle(.roundedBorder)
                .border(exchangeVM.isSourceAmountInvalid ? .red : .clear)
                
                CurrencyPickerView(pickerVM: exchangeVM.sourcePickerVM!, selection: $exchangeVM.sourceCurrency)
                
            }
            
            CurrencySwapDivider(exchangeVM: $exchangeVM)
        
            // Target Input
            HStack {
                TextField(
                    "Enter Amount",
                    text: $exchangeVM.targetAmountStr
                )
                .textFieldStyle(.roundedBorder)
                .border(exchangeVM.isTargetAmountInvalid ? .red : .clear)
                
                
                CurrencyPickerView(pickerVM: exchangeVM.targetPickerVM!, selection: $exchangeVM.targetCurrency)
            }
            
            Spacer()
            
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color("foreground-primary"))
        }
    }
}

private struct CurrencySwapDivider: View {
    @Binding var exchangeVM: ExchangeViewModel
    
    var body: some View {
        ZStack {
            Divider()
                .overlay(Color.gray)
            
            Button {
                exchangeVM.swapCurrencies()
            } label: {
                Image(systemName: "arrow.up.arrow.down")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20)
            }
            .background {
                Rectangle()
                    .fill(Color("foreground-primary"))
                    .frame(width: 50)
            }
            
        }
    }
}

#Preview {
    @Previewable @State var exchangeVM: ExchangeViewModel = .init()

    ExchangeConvertView(exchangeVM: $exchangeVM)
        .task {
            await exchangeVM.onStart()
        }
}
