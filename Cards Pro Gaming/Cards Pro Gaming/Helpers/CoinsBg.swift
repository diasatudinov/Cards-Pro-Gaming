//
//  CoinsBg.swift
//  Cards Pro Gaming
//
//  Created by Dias Atudinov on 03.02.2025.
//

import SwiftUI

struct CoinsBg: View {
    @StateObject var user = UserCoins.shared
    @State var coins: String
    var body: some View {
        HStack(spacing: 4) {
            Image(.coinIcon)
                .resizable()
                .scaledToFit()
                .frame(height: 30)
                .padding(5)
                .background(
                    Color.mainGreen
                )
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.yellow, lineWidth: 1)
                )
            Text("\(user.coins)")
                .font(.custom(Fonts.bold.rawValue, size: 24))
                .foregroundStyle(.yellow)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 6)
                .background(
                    Color.mainGreen
                )
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.yellow, lineWidth: 1)
                )
        }.frame(width: 200)
    }
}

#Preview {
    CoinsBg(coins: "100")
}
