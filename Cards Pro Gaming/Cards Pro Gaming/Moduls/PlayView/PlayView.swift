
import SwiftUI

struct PlayView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var showDealerGame = false
    @State private var showOnlineGame = false
    @State private var gameSearch = false
    @State private var isSearching = false

    @ObservedObject var settingsVM: SettingsViewModel
    @ObservedObject var shopVM: ShopViewModel
    
    @State private var rotationAngle: Double = 0
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        ZStack {
                            Image(.backIcon)
                                .resizable()
                                .scaledToFit()
                            
                        }.frame(height: DeviceInfo.shared.deviceType == .pad ? 100:50)
                        
                    }
                    Spacer()
                    
                    CoinsBg(coins: "")
                }
                Spacer()
                
                if gameSearch {
                    
                    if isSearching {
                        VStack {
                            Text("Search for opponent")
                                .font(.custom(Fonts.bold.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 48:24))
                                .foregroundStyle(.yellow)
                                .textCase(.uppercase)
                            Image(.progressCircle)
                                .resizable()
                                .scaledToFit()
                                .frame(height: DeviceInfo.shared.deviceType == .pad ? 200:100)
                                .rotationEffect(.degrees(rotationAngle))
                        }.padding(DeviceInfo.shared.deviceType == .pad ? 40:20)
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
                    } else {
                        VStack {
                            Text("Oponent found")
                                .font(.custom(Fonts.bold.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 48:24))
                                .foregroundStyle(.yellow)
                                .textCase(.uppercase)
                            Image(.tickCPG)
                                .resizable()
                                .scaledToFit()
                                .frame(height: DeviceInfo.shared.deviceType == .pad ? 120:60)
                        }.padding(DeviceInfo.shared.deviceType == .pad ? 40:20)
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
                } else {
                    
                    HStack(spacing: DeviceInfo.shared.deviceType == .pad ? 100:50) {
                        Button {
                            showDealerGame = true
                        } label: {
                            Image(.dealerCard)
                                .resizable()
                                .scaledToFit()
                                .frame(height: DeviceInfo.shared.deviceType == .pad ? 420:210)
                        }
                        
                        Button {
                            gameSearch = true
                            startToSpin()
                        } label: {
                            Image(.onlineCard)
                                .resizable()
                                .scaledToFit()
                                .frame(height: DeviceInfo.shared.deviceType == .pad ? 420:210)
                        }
                    }
                }
                Spacer()
            }.padding()
        }.background(
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
        .fullScreenCover(isPresented: $showDealerGame) {
            GameWithDealer(settingsVM: settingsVM, shopVM: shopVM, gameType: .dealer)
        }
        .fullScreenCover(isPresented: $showOnlineGame) {
            GameWithDealer(settingsVM: settingsVM, shopVM: shopVM, gameType: .online)
        }
    }
    
    func startToSpin() {
        isSearching = true
        
        withAnimation(.easeInOut(duration: 5)) {
            let spins = Double(5)
            rotationAngle = spins * 360
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            isSearching = false
            
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
            showOnlineGame = true
            

        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
            gameSearch = false
            isSearching = false
            rotationAngle = 0
        }
    }
}

#Preview {
    PlayView(settingsVM: SettingsViewModel(), shopVM: ShopViewModel())
}
