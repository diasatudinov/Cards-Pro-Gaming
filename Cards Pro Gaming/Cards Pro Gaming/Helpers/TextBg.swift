//
//  TextBg.swift
//  Cards Pro Gaming
//
//  Created by Dias Atudinov on 03.02.2025.
//


import SwiftUI

struct TextBg: View {
    var text: String
    var textSize: CGFloat
    var body: some View {
        ZStack {
            Text(text)
                .font(.custom(Fonts.bold.rawValue, size: textSize))
                .foregroundStyle(.yellow)
                .textCase(.uppercase)
                .padding(.vertical)
                .frame(width: 248)
                .background(
                    Color.mainGreen
                )
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.yellow, lineWidth: 1)
                )
        }
    }
}

#Preview {
    TextBg(text: "Select", textSize: 32)
}
