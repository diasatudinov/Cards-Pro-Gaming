
import SwiftUI

struct DailyRouletteView: View {
    @StateObject var user = UserCoins.shared
    @State private var bonusPoints: Int? = nil
    @State private var lastPressDate: Date? = nil
    @State private var isButtonDisabled: Bool = false 
    @Environment(\.presentationMode) var presentationMode
    
    @State private var rotationAngle: Double = 0
    @State private var isSpinning = false
    @State private var reward: Int? = nil

    let rewards = [0, 10, 100, 1000, 50]
    
    var body: some View {
        ZStack {
            
            VStack(spacing: 0) {
                
                    VStack {
                        Spacer()
                        ZStack {
                            
                            Image("roulette")
                                .resizable()
                                .scaledToFit()
                                .rotationEffect(.degrees(rotationAngle))
                            VStack {
                                Image(.flagIcon)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: DeviceInfo.shared.deviceType == .pad ? 70:34)
                                    .offset(y: DeviceInfo.shared.deviceType == .pad ? 80:40)
                                    .rotationEffect(Angle(degrees: isSpinning ? -20:0))
                                Spacer()
                            }
                        }.frame( height: DeviceInfo.shared.deviceType == .pad ? 560:279)
                        
                        Button {
                            handleButtonPress()
                        } label: {
                            TextBg(text: "Spin", textSize: DeviceInfo.shared.deviceType == .pad ? 48:24)
                                .opacity(isButtonDisabled ? 0.5 : 1.0)
                        } .disabled(isButtonDisabled)
                        
                        if DeviceInfo.shared.deviceType == .pad {
                            Spacer()
                        }
                    }
                  
                
            }
            VStack {
                ZStack {
                    
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
                    }.padding()
                }
                Spacer()
                
            }
            if let reward = reward {
                if isButtonDisabled {
                    Color.black.opacity(0.5).ignoresSafeArea()
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
                        }.padding()
                        Spacer()
                    }
                    VStack(spacing: -20) {
                        Image(.congratulationsText)
                            .resizable()
                            .scaledToFit()
                            .frame(height: DeviceInfo.shared.deviceType == .pad ? 132:66)
                        ZStack {
                            Image(.rouletteBg)
                                .resizable()
                                .scaledToFit()
                            
                            Text("\(reward)")
                                .font(.custom(Fonts.bold.rawValue, size: DeviceInfo.shared.deviceType == .pad ? 96:48))
                                .foregroundColor(.yellow)
                            
                        }.frame(height: DeviceInfo.shared.deviceType == .pad ? 360:180)
                    }
                }
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
        .onAppear {
            checkButtonState()
            reward = UserDefaults.standard.integer(forKey: "savedBonus")
        }
        
    }
    
    func startSpinning() {
        reward = nil
        withAnimation {
            isSpinning = true
        }
        withAnimation(.easeInOut(duration: 3)) {
            let spins = Double.random(in: 3...5)
            rotationAngle += spins * 360
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            reward = rewards.randomElement()
            if let reward = reward {
                UserDefaults.standard.set(reward, forKey: "savedBonus")
                user.updateUserCoins(for: reward)
            }
            withAnimation {
                isSpinning = false
            }
        }
        
        checkButtonState()
    }
    
    private func handleButtonPress() {
        startSpinning()
        lastPressDate = Date()
        UserDefaults.standard.set(lastPressDate, forKey: "LastPressDate")
        
        
        isButtonDisabled = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + (30 * 60) + 1) {
            checkButtonState()
        }
    }
    
    private func checkButtonState() {
       
        if let savedDate = UserDefaults.standard.object(forKey: "LastPressDate") as? Date {
            let elapsedTime = Date().timeIntervalSince(savedDate)
            if elapsedTime >= 30 * 60 {
                isButtonDisabled = false
            } else {
                isButtonDisabled = true
            }
        }
        
        
    }
}

#Preview {
    DailyRouletteView()
}
