//
//  ThemeToggleButton.swift
//  CurrencyExchange
//
//  Created by KHANH VAN on 20/11/24.
//

import SwiftUI

struct ThemeToggleButton: View {
    @Environment(ThemeManager.self) private var themeManager

    var body: some View {
        Button {
            themeManager.toggle()
        } label: {
            Image(systemName: themeManager.theme == .dark ? "moon.fill" : "sun.max.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30)
        }
    }
}

#Preview {
    @Previewable @State var themeManager: ThemeManager = .init()

    ThemeToggleButton()
        .preferredColorScheme(themeManager.theme)
        .environment(themeManager)
}
