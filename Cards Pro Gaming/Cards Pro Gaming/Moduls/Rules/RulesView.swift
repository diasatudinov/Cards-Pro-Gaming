
import SwiftUI

struct RulesView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var ruleIndex = 0
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                
                VStack {
                    Spacer()
                    HStack(spacing: 15) {
                        Spacer()
                        Button {
                            if ruleIndex > 0 {
                                ruleIndex -= 1
                            }
                        } label: {
                            
                            Image(.backIcon)
                                .resizable()
                                .scaledToFit()
                                .frame(height: DeviceInfo.shared.deviceType == .pad ? 80:40)
                                .opacity(ruleIndex == 0 ? 0 : 1)
                            
                        }
                        switch ruleIndex {
                        case 0:
                            ruleView(image: "rulesImage1", text: "The goal of the game is to get a hand value as close to 21 as possible without exceeding it. A standard 52-card deck is used. Cards numbered 2 through 10 are worth their face value, face cards (Jack, Queen, King) are worth 10 points, and an Ace can be worth either 1 or 11 points.", imageHeight: DeviceInfo.shared.deviceType == .pad ? 190:95)
                        case 1:
                            ruleView(image: "rulesImage2", text: "Players place a bet and receive two cards, one of which the dealer keeps face down. Players can choose to: hit (take another card), stand (stop taking cards), double down (double their bet and take one more card), or split (split a pair into two hands).", imageHeight: DeviceInfo.shared.deviceType == .pad ? 94:47)
                        case 2:
                            ruleView(image: "rulesImage3", text: "The dealer reveals their face-down card and takes additional cards if their hand is less than 17. If a player's hand exceeds 21, they lose; if it equals 21, they win unless the dealer also has a blackjack. In case of a tie, the player's bet is returned.", imageHeight: DeviceInfo.shared.deviceType == .pad ? 132:66)
                        default:
                            ZStack {
                                
                            }
                        }
                        
                        Button {
                            if ruleIndex < 2 {
                                ruleIndex += 1
                            }
                        } label: {
                            Image(.backIcon)
                                .resizable()
                                .scaledToFit()
                                .frame(height: DeviceInfo.shared.deviceType == .pad ? 80:40)
                                .rotationEffect(Angle(degrees: 180))
                                .opacity(ruleIndex == 2 ? 0 : 1)
                        }
                        Spacer()
                    }.frame(height: DeviceInfo.shared.deviceType == .pad ? 580:290)
                    if DeviceInfo.shared.deviceType == .pad {
                        Spacer()
                    }
                }
                
                VStack {
                    ZStack {
                        HStack {
                            Text("Rules")
                                .font(.custom(Fonts.bold.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 80:40))
                                .textCase(.uppercase)
                                .foregroundStyle(.yellow)
                        }
                        HStack {
                            Button {
                                presentationMode.wrappedValue.dismiss()
                            } label: {
                                Image(.backIcon)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: DeviceInfo.shared.deviceType == .pad ? 100:50)
                            }
                            Spacer()
                            CoinsBg(coins: "100")
                        }
                    }
                    Spacer()
                }.padding(DeviceInfo.shared.deviceType == .pad ? 40:20)
                
            }
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 83/255, green: 11/255, blue: 11/255),
                        Color(red: 137/255, green: 20/255, blue: 10/255),
                        Color(red: 83/255, green: 11/255, blue: 11/255)
                    ]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
                
            )
        }
    }
    
    @ViewBuilder func ruleView(image: String, text: String, imageHeight: CGFloat) -> some View {
        
        
        HStack(spacing: DeviceInfo.shared.deviceType == .pad ? 40:20) {
            
            VStack(alignment: .center, spacing: DeviceInfo.shared.deviceType == .pad ? 20:10) {
                
                Text(text)
                    .font(.custom(Fonts.bold.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 28:14))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.yellow)
                    .textCase(.uppercase)
                    .frame(width: DeviceInfo.shared.deviceType == .pad ? 536:268)
                
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: imageHeight)
            }.padding(DeviceInfo.shared.deviceType == .pad ? 30:15)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 83/255, green: 11/255, blue: 11/255),
                        Color(red: 137/255, green: 20/255, blue: 10/255),
                        Color(red: 83/255, green: 11/255, blue: 11/255)
                    ]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
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
    RulesView()
}
