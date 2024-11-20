//
//  ExchangeHeaderView.swift
//  CurrencyExchange
//
//  Created by KHANH VAN on 18/11/24.
//

import SwiftUI

struct ExchangeHeaderView: View {
    
    @State var headerVM: ExchangeHeaderViewModel
    let timer = Timer.publish(every: 10, on: .main, in: .common).autoconnect()
        
    init(headerVM: ExchangeHeaderViewModel) {
        self.headerVM = headerVM
    }
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Label {
                Text("HIGHLIGHTS")
            } icon: {
                Image(systemName: "star.fill")
            }
            .foregroundStyle(Color("AccentColor"))
            .font(.system(size: 20, weight: .bold))
            .padding()
            
            Divider()
                .padding(0)

            VStack(alignment: .leading, spacing: 0) {
                ForEach(Array(headerVM.randomCurrencies.enumerated()), id: \.element) { index, currency in
                    HStack {
                        Text("1 \(currency)")
                            .font(.system(size: 20, weight: .medium))
                        Spacer()
                        Text("\(headerVM.rates[currency]!.formatted(.number)) USD")
                            .font(.system(size: 20, weight: .medium))

                    }
                    .transition(.slide.combined(with: .opacity))
                    .padding()
                    .background {
                        if index % 2 == 0 {
                            Color("foreground-secondary")
                        }
                    }
                }
                
                Text("Last updated: \(headerVM.exchangeVM.timestamp?.formatted() ?? "")")
                    .font(.footnote)
                    .italic()
                    .padding()
                    .foregroundStyle(.gray)
                    
            }
            .clipped()  // Clip item when sliding outside during transition
        }
        .background {
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(Color("foreground-primary"))
        }
        .onAppear {
            headerVM.refresh()
        }
        .onReceive(timer) { _ in
            headerVM.refresh()
        }
        
    }
    
}

#Preview {
    @Previewable @State var exchangeVM: ExchangeViewModel = .init()

    ZStack {
        Color("background-primary")
        ExchangeHeaderView(headerVM: exchangeVM.headerVM!)
            .task {
                await exchangeVM.onStart()
            }
    }
}
