
import SwiftUI

struct MenuView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var showRoulette = false
    @State private var showGame = false
    @State private var showShop = false
    @State private var showHowToPlay = false
    @State private var showSettings = false
    
    @StateObject var shopVM = ShopViewModel()
    @StateObject var settingsVM = SettingsViewModel()
    @StateObject var teamVM = RegistrationViewModel()
    
    var body: some View {
        if let team = teamVM.currentTeam {
            GeometryReader { geometry in
                ZStack {
                    VStack(spacing: 0) {
                        Spacer()
                        
                        if geometry.size.width < geometry.size.height {
                            // Вертикальная ориентация
                            ZStack {
                                
                                VStack(spacing: 25) {
                                    
                                    HStack {
                                        PlayerBg()
                                        
                                        
                                    }
                                    HStack {
                                        Spacer()
                                        
                                        VStack(spacing: 20) {
                                            
                                            Image(.logo)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(height: DeviceInfo.shared.deviceType == .pad ? 180:90)
                                                .overlay {
                                                    RoundedRectangle(cornerRadius: 10)
                                                        .stroke(Color.yellow, lineWidth: 1)
                                                }
                                            
                                            Button {
                                                showRoulette = true
                                            } label: {
                                                TextBg(text: "Daily Roulette", textSize: DeviceInfo.shared.deviceType == .pad ? 48 : 24)
                                            }
                                            
                                            
                                            Button {
                                                
                                                showGame = true
                                            } label: {
                                                TextBg(text: "Play", textSize: DeviceInfo.shared.deviceType == .pad ? 48 : 24)
                                            }
                                            
                                            Button {
                                                withAnimation {
                                                    showShop = true
                                                }
                                            } label: {
                                                TextBg(text: "Shop", textSize: DeviceInfo.shared.deviceType == .pad ? 48 : 24)
                                            }
                                            
                                            Button {
                                                
                                                showHowToPlay = true
                                            } label: {
                                                TextBg(text: "Rules", textSize: DeviceInfo.shared.deviceType == .pad ? 48 : 24)
                                            }
                                            
                                            Button {
                                                showSettings = true
                                            } label: {
                                                TextBg(text: "Settings", textSize: DeviceInfo.shared.deviceType == .pad ? 48 : 24)
                                            }
                                            
                                            CoinsBg(coins: "")
                                        }
                                        Spacer()
                                    }
                                    
                                }
                                
                            }
                        } else {
                            ZStack {
                                
                                VStack(spacing: 15) {
                                    if DeviceInfo.shared.deviceType != .pad {
                                        
                                        
                                        Spacer()
                                    }
                                    HStack(alignment: .top) {
                                        PlayerBg()
                                        Spacer()
                                        Image(.logo)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: DeviceInfo.shared.deviceType == .pad ? 180:90)
                                            .overlay {
                                                RoundedRectangle(cornerRadius: 10)
                                                    .stroke(Color.yellow, lineWidth: 1)
                                            }
                                        
                                        Spacer()
                                        
                                        CoinsBg(coins: "100")
                                    }
                                    if DeviceInfo.shared.deviceType == .pad {
                                        Spacer()
                                    }
                                    VStack(spacing: 15) {
                                        Button {
                                            showRoulette = true
                                        } label: {
                                            TextBg(text: "Daily Roulette", textSize: DeviceInfo.shared.deviceType == .pad ? 48 : 24)
                                        }
                                        
                                        HStack(spacing: 15) {
                                            Spacer()
                                            Button {
                                                showGame = true
                                            } label: {
                                                TextBg(text: "Play", textSize: DeviceInfo.shared.deviceType == .pad ? 48 : 24)
                                            }
                                            
                                            Button {
                                                showShop = true
                                            } label: {
                                                TextBg(text: "Shop", textSize: DeviceInfo.shared.deviceType == .pad ? 48 : 24)
                                            }
                                            Spacer()
                                            
                                            
                                        }
                                        
                                        HStack(spacing: 15) {
                                            Spacer()
                                            Button {
                                                withAnimation {
                                                    showHowToPlay = true
                                                }
                                            } label: {
                                                TextBg(text: "Rules", textSize: DeviceInfo.shared.deviceType == .pad ? 48 : 24)
                                            }
                                            
                                            Button {
                                                
                                                showSettings = true
                                            } label: {
                                                TextBg(text: "Settings", textSize: DeviceInfo.shared.deviceType == .pad ? 48 : 24)
                                            }
                                            
                                            Spacer()
                                        }
                                        
                                        
                                        
                                        
                                    }
                                    Spacer()
                                }
                                
                                
                            }
                        }
                        Spacer()
                    }
                    
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
                .onAppear {
                    if settingsVM.musicEnabled {
                        SongsManager.shared.playBackgroundMusic()
                    }
                }
                .onChange(of: settingsVM.musicEnabled) { enabled in
                    if enabled {
                        SongsManager.shared.playBackgroundMusic()
                    } else {
                        SongsManager.shared.stopBackgroundMusic()
                    }
                }
                .fullScreenCover(isPresented: $showRoulette) {
                    DailyRouletteView()
                }
                .fullScreenCover(isPresented: $showGame) {
                    PlayView(settingsVM: settingsVM, shopVM: shopVM)
                }
                .fullScreenCover(isPresented: $showHowToPlay) {
                     RulesView()
                }
                .fullScreenCover(isPresented: $showShop) {
                    ShopView(shopVM: shopVM)
                }
                .fullScreenCover(isPresented: $showSettings) {
                     SettingsView(settings: settingsVM)
                    
                }
                
            }
        } else {
            RegistrationView(viewModel: teamVM)
        }
        
    }
    
    
}

#Preview {
    MenuView()
}
