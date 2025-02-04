import SwiftUI

struct CardView: View {
    let card: Card
    var hidden: Bool = false
    
    var body: some View {
        if hidden {
            Image("\(card.design)_cardBack")
                .resizable()
                .scaledToFit()
                .frame(height: DeviceInfo.shared.deviceType == .pad ? 200:95)
        } else {
            Image("\(card.design)_\(card.suit)_\(card.type)")
                .resizable()
                .scaledToFit()
                .frame(height: DeviceInfo.shared.deviceType == .pad ? 200:95)
        }
    }
}