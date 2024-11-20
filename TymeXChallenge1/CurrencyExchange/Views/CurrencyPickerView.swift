//
//  CurrencyPickerView.swift
//  CurrencyExchange
//
//  Created by KHANH VAN on 16/11/24.
//

import SwiftUI

struct CurrencyPickerView: View {
    
    @State var pickerVM: ExchangePickerViewModel
    @Binding var selection: String
        
    var body: some View {
        Button {
            pickerVM.toggleSheet()
        } label: {
            HStack {
                Text(selection)
                    .font(.system(size: 16, weight: .medium))
                    .lineLimit(1)
                    .fixedSize()
                
                Image(systemName: "chevron.down")
            }
            .padding(10)
            .foregroundStyle(.white)
            .background(
                Color("AccentColor"),
                in: RoundedRectangle(cornerRadius: 5, style: .continuous))
        }
        .sheet(isPresented: $pickerVM.selectionSheetPresented) {
            CurrencyPickerSheet(pickerVM: $pickerVM, selection: $selection)
        }
    }
    

}

struct CurrencyPickerSheet: View {
    @Binding var pickerVM: ExchangePickerViewModel
    @Binding var selection: String

    var body: some View {
        NavigationStack {
            List {
                ForEach(Array(pickerVM.filteredCurrencies.keys), id:\.self) { currency in
                    
                    HStack {
                        Text(pickerVM.currencies[currency] ?? currency)
                        Spacer()
                        Text(currency)
                    }
                    .onTapGesture {
                        selection = currency
                        pickerVM.toggleSheet()
                    }
                }
            }

        }
        .presentationDetents([.medium, .large])
        .searchable(text: $pickerVM.searchText, prompt: "Search Currency")
    }

}

#Preview {
    @Previewable @State var exchangeVM: ExchangeViewModel = .init()
    @Previewable @State var selection: String = "USD"

    VStack {
        CurrencyPickerView(
            pickerVM: exchangeVM.sourcePickerVM!,
            selection: $selection)
    }
    .task {
        await exchangeVM.onStart()
    }
}
