
import SwiftUI
import StoreKit

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var settings: SettingsViewModel

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                
                VStack(spacing: 0)  {
                    Spacer()
                    ZStack {
                        
                        VStack(spacing: 8) {
                            
                            VStack(spacing: 15)  {
                                
                                Text("Music")
                                    .font(.custom(Fonts.bold.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 48:24))
                                    .textCase(.uppercase)
                                    .foregroundStyle(.yellow)
                                HStack(spacing: 20) {
                                    Text("Off")
                                        .font(.custom(Fonts.bold.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 48:24))
                                        .textCase(.uppercase)
                                        .foregroundStyle(.yellow)
                                    Button {
                                        withAnimation {
                                            settings.musicEnabled.toggle()
                                        }
                                    } label: {
                                        if settings.musicEnabled {
                                            Image(.onCPG)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(height: DeviceInfo.shared.deviceType == .pad ? 68:34)
                                        } else {
                                            Image(.offCPG)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(height: DeviceInfo.shared.deviceType == .pad ? 68:34)
                                        }
                                    }
                                    
                                    Text("On")
                                        .font(.custom(Fonts.bold.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 48:24))
                                        .textCase(.uppercase)
                                        .foregroundStyle(.yellow)
                                }
                                
                            }
                            
                            VStack(spacing: DeviceInfo.shared.deviceType == .pad ? 30:15)  {
                                
                                Text("Vibration")
                                    .font(.custom(Fonts.bold.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 48 :24))
                                    .textCase(.uppercase)
                                    .foregroundStyle(.yellow)
                                
                                HStack(spacing: 20) {
                                    Text("Off")
                                        .font(.custom(Fonts.bold.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 48:24))
                                        .textCase(.uppercase)
                                        .foregroundStyle(.yellow)
                                    Button {
                                        withAnimation {
                                            settings.soundEnabled.toggle()
                                        }
                                    } label: {
                                        if settings.soundEnabled {
                                            Image(.onCPG)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(height: DeviceInfo.shared.deviceType == .pad ? 68:34)
                                        } else {
                                            Image(.offCPG)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(height: DeviceInfo.shared.deviceType == .pad ? 68:34)
                                        }
                                    }
                                    
                                    Text("on")
                                        .font(.custom(Fonts.bold.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 48:24))
                                        .textCase(.uppercase)
                                        .foregroundStyle(.yellow)
                                }
                            }
                                Button {
                                    rateUs()
                                } label: {
                                    
                                    Text("RATE US")
                                        .font(.custom(Fonts.bold.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 40:20))
                                        .foregroundStyle(.yellow)
                                        .textCase(.uppercase)
                                        .padding(.vertical)
                                        .frame(width: DeviceInfo.shared.deviceType == .pad ? 268:134)
                                        .background(
                                            Color.mainGreen
                                        )
                                        .cornerRadius(10)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color.yellow, lineWidth: 1)
                                        )
                                }
                            
                        }.padding(DeviceInfo.shared.deviceType == .pad ? 40:20)
                            .padding(.horizontal, DeviceInfo.shared.deviceType == .pad ? 40:20)
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
                    }.frame(height: geometry.size.height * 0.87)
                    
                    Spacer()
                }
                
                VStack {
                    ZStack {
                        HStack {
                            Text("Settings")
                                .font(.custom(Fonts.bold.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 80:40))
                                .textCase(.uppercase)
                                .foregroundStyle(.yellow)
                        }
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
                            
                            CoinsBg(coins: "100")
                        }.padding([.leading, .top])
                    }
                    Spacer()
                }
                
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
        }
    }
    
    func rateUs() {
        if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            SKStoreReviewController.requestReview(in: scene)
        }
    }
}

#Preview {
    SettingsView(settings: SettingsViewModel())
}
