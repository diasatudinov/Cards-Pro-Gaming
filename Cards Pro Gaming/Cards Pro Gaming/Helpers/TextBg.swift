

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
                .frame(width: DeviceInfo.shared.deviceType == .pad ? 500:248)
                .background(
                    Color.mainGreen
                )
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.yellow, lineWidth: DeviceInfo.shared.deviceType == .pad ? 2:1)
                )
        }
    }
}

#Preview {
    TextBg(text: "Select", textSize: DeviceInfo.shared.deviceType == .pad ? 64:32)
}
