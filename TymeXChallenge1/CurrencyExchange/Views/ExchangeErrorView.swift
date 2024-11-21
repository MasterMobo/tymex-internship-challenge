//
//  ExchangeErrorView.swift
//  CurrencyExchange
//
//  Created by KHANH VAN on 18/11/24.
//

import SwiftUI

struct ExchangeErrorView: View {
    @State var errorVM: ExchangeErrorViewModel
    
    init(errorVM: ExchangeErrorViewModel) {
        self.errorVM = errorVM
    }
    
    var body: some View {
        ZStack {
            Color("background-primary")
                .ignoresSafeArea(.all)
            
            VStack(spacing: 20) {
                errorVM.image?.resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50)
                    .foregroundStyle(.accent)
                
                Text(errorVM.message)
                    .multilineTextAlignment(.center)
                
                Button {
                    errorVM.onRetry()
                } label: {
                    Text("Retry")
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
        }
    }
}

#Preview {
    ExchangeErrorView(errorVM: .init(error: URLError(.notConnectedToInternet)))
    // Uncomment to see these!
//    ExchangeErrorView(errorVM: .init(error: URLError(.timedOut)))
//    
//    ExchangeErrorView(errorVM: .init(error: ExchangeAPIError.generalError))

}
